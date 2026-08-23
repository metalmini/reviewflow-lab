# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "pathname"
require "tmpdir"
require "yaml"

class PolicyTest < Minitest::Test
  ROOT = Pathname.new(__dir__).join("../..").cleanpath
  SCRIPT = ".github/scripts/policy.rb"

  def test_current_repository_passes
    _stdout, stderr, status = Open3.capture3("ruby", SCRIPT, chdir: ROOT.to_s)

    assert_predicate status, :success?, stderr
  end

  def test_mutable_action_reference_fails
    with_repository_copy do |copy|
      workflow = copy.join(".github/workflows/policy.yml")
      content = workflow.read.sub(/[0-9a-f]{40} # v7\.0\.1/, "v7.0.1")
      workflow.write(content)

      assert_policy_fails(copy, "not pinned to a full commit SHA")
    end
  end

  def test_pull_request_target_fails
    with_repository_copy do |copy|
      workflow = copy.join(".github/workflows/policy.yml")
      workflow.write("#{workflow.read}\npull_request_target:\n")

      assert_policy_fails(copy, "pull_request_target is prohibited")
    end
  end

  def test_missing_local_link_fails
    with_repository_copy do |copy|
      readme = copy.join("README.md")
      readme.write("#{readme.read}\n[Missing](docs/does-not-exist.md)\n")

      assert_policy_fails(copy, "missing local link")
    end
  end

  def test_remote_provider_fails
    with_repository_copy do |copy|
      config = copy.join(".reviewflow/config.yaml")
      config.write(config.read.sub("provider: null", "provider: remote"))

      assert_policy_fails(copy, "provider must remain null")
    end
  end

  def test_privileged_feedback_checkout_fails
    with_repository_copy do |copy|
      workflow = copy.join(".github/workflows/pr-feedback.yml")
      workflow.write("#{workflow.read}\n# actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1\n")

      assert_policy_fails(copy, "checkout, cache, and artifact actions are prohibited")
    end
  end

  def test_feedback_script_has_valid_javascript_syntax
    workflow = YAML.safe_load(
      ROOT.join(".github/workflows/pr-feedback.yml").read,
      aliases: false
    )
    script = workflow.dig("jobs", "feedback", "steps", 0, "with", "script")

    Dir.mktmpdir("reviewflow-javascript-") do |directory|
      wrapped = Pathname.new(directory).join("feedback.js")
      wrapped.write("async function reviewflow({ github, context, core }) {\n#{script}\n}\n")
      _stdout, stderr, status = Open3.capture3("node", "--check", wrapped.to_s)

      assert_predicate status, :success?, stderr
    end
  end

  private

  def with_repository_copy
    Dir.mktmpdir("reviewflow-policy-") do |directory|
      copy = Pathname.new(directory)
      ROOT.children.reject { |path| path.basename.to_s == ".git" }.each do |path|
        FileUtils.cp_r(path, copy)
      end
      yield copy
    end
  end

  def assert_policy_fails(copy, expected_message)
    _stdout, stderr, status = Open3.capture3("ruby", SCRIPT, chdir: copy.to_s)

    refute_predicate status, :success?
    assert_includes stderr, expected_message
  end
end
