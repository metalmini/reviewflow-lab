# frozen_string_literal: true

require "json"
require "pathname"
require "uri"
require "yaml"

ROOT = Pathname.new(__dir__).join("../..").cleanpath
failures = []
checked = Hash.new(0)

def repository_files(pattern)
  Dir.glob(ROOT.join(pattern).to_s, File::FNM_DOTMATCH).sort
end

def relative(path)
  Pathname.new(path).relative_path_from(ROOT).to_s
end

yaml_files = repository_files(".github/**/*.{yml,yaml}") +
  repository_files(".reviewflow/*.{yml,yaml}")

yaml_files.uniq.each do |path|
  YAML.safe_load(
    File.read(path),
    permitted_classes: [],
    permitted_symbols: [],
    aliases: false
  )
  checked[:yaml] += 1
rescue Psych::Exception => error
  failures << "#{relative(path)}: invalid YAML (#{error.message.lines.first.strip})"
end

repository_files(".github/**/*.json").each do |path|
  JSON.parse(File.read(path))
  checked[:json] += 1
rescue JSON::ParserError => error
  failures << "#{relative(path)}: invalid JSON (#{error.message})"
end

markdown_files = repository_files("**/*.md").reject do |path|
  path.include?("/.git/") || path.include?("/vendor/")
end

markdown_files.each do |path|
  File.foreach(path).with_index(1) do |line, line_number|
    line.scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |raw_target|
      target = raw_target.strip.sub(/\A</, "").sub(/>\z/, "")
      target = target.split(/\s+[\"']/, 2).first
      next if target.empty? || target.start_with?("#")
      next if target.match?(%r{\A(?:https?|mailto):}i)

      path_part = URI::DEFAULT_PARSER.unescape(target.split(/[?#]/, 2).first)
      destination = if path_part.start_with?("/")
        ROOT.join(path_part.delete_prefix("/"))
      else
        Pathname.new(path).dirname.join(path_part)
      end.cleanpath

      unless destination.exist?
        failures << "#{relative(path)}:#{line_number}: missing local link #{target}"
      end
      checked[:links] += 1
    end
  end
end

workflow_files = repository_files(".github/workflows/*.{yml,yaml}")
workflow_files.each do |path|
  content = File.read(path)
  name = relative(path)

  failures << "#{name}: pull_request_target is prohibited" if content.match?(/^\s*pull_request_target\s*:/)
  failures << "#{name}: secrets context is prohibited" if content.include?("secrets.")

  content.scan(/^\s*-?\s*uses:\s*([^\s#]+)/).flatten.each do |reference|
    next if reference.start_with?("./", "$/")

    _action, version = reference.split("@", 2)
    unless version&.match?(/\A[0-9a-f]{40}\z/)
      failures << "#{name}: action is not pinned to a full commit SHA (#{reference})"
    end
  end
end

policy_path = ROOT.join(".github/workflows/policy.yml")
policy = File.read(policy_path)
failures << "policy workflow: contents permission must be read-only" unless policy.match?(/^permissions:\n\s+contents:\s+read\s*$/)
failures << "policy workflow: write permission is prohibited" if policy.match?(/^\s+\S+:\s+write\s*$/)
failures << "policy workflow: checkout credentials must not persist" unless policy.include?("persist-credentials: false")
failures << "policy workflow: cache and artifact handoff are prohibited" if policy.match?(/actions\/(?:cache|upload-artifact|download-artifact)@/)

reviewflow = YAML.safe_load(File.read(ROOT.join(".reviewflow/config.yaml")), aliases: false)
expected_models = ["codeqwen:latest", "gemma4:latest"].sort
actual_models = reviewflow.dig("ai", "allowed_local_models")&.sort

failures << ".reviewflow/config.yaml: remote/default provider must remain null" unless reviewflow["provider"].nil?
failures << ".reviewflow/config.yaml: AI must remain disabled by default" unless reviewflow.dig("ai", "enabled") == false
failures << ".reviewflow/config.yaml: allowed model set changed" unless actual_models == expected_models
failures << ".reviewflow/config.yaml: only one model request is allowed" unless reviewflow.dig("ai", "max_requests") == 1
failures << ".reviewflow/config.yaml: retries must remain zero" unless reviewflow.dig("ai", "retries") == 0

risk_registry = YAML.safe_load(File.read(ROOT.join(".reviewflow/accepted-risks.yaml")), aliases: false)
failures << ".reviewflow/accepted-risks.yaml: acceptances must be a list" unless risk_registry["acceptances"].is_a?(Array)

ruleset = JSON.parse(File.read(ROOT.join(".github/rulesets/main.json")))
rule_types = ruleset.fetch("rules", []).map { |rule| rule["type"] }
required_rule_types = %w[deletion non_fast_forward required_linear_history required_status_checks pull_request]

failures << ".github/rulesets/main.json: ruleset must be active" unless ruleset["enforcement"] == "active"
failures << ".github/rulesets/main.json: bypass actors are prohibited" unless ruleset["bypass_actors"] == []
(required_rule_types - rule_types).each do |type|
  failures << ".github/rulesets/main.json: missing #{type} rule"
end

status_rule = ruleset.fetch("rules", []).find { |rule| rule["type"] == "required_status_checks" }
required_checks = status_rule&.dig("parameters", "required_status_checks") || []
policy_check = required_checks.find { |check| check["context"] == "policy" }
failures << ".github/rulesets/main.json: policy check must be required" unless policy_check
if policy_check && policy_check["integration_id"] != 15_368
  failures << ".github/rulesets/main.json: policy check must be bound to GitHub Actions"
end

if failures.any?
  warn "Policy validation failed:"
  failures.each { |failure| warn "- #{failure}" }
  exit 1
end

puts "Policy validation passed (#{checked[:yaml]} YAML, #{checked[:json]} JSON, #{checked[:links]} local links)."
