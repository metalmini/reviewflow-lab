# Approved local Ollama models

Read-only inventory recorded on 2026-08-23. These models were installed by Michael before ReviewFlow Lab implementation. ReviewFlow Lab did not download or modify them.

| Tag | Local size | Architecture | Parameters | Quantization | Advertised context | Intended experiment |
| --- | ---: | --- | ---: | --- | ---: | --- |
| `codeqwen:latest` | 4.2 GB | Qwen2 | 7.3B | Q4_0 | 65,536 | First code-review comparison candidate |
| `gemma4:latest` | 9.6 GB | Gemma 4 | 8.0B | Q4_K_M | 131,072 | Second-model comparison and general reasoning |

## Project limits

The advertised model context is not the project context limit. ReviewFlow Lab caps local AI at:

- 50,000 input bytes;
- 16,384 context tokens;
- 800 output tokens;
- one request;
- 60 seconds;
- zero retries.

Neither model may be invoked from GitHub Actions. The provider remains disabled by default and does not use model tool capabilities, vision, audio, or network access.

## License note

The local `gemma4:latest` metadata reports Apache-2.0. The `codeqwen:latest` metadata points to its bundled CodeQwen license rather than printing the license text. ReviewFlow Lab does not redistribute either model. The CodeQwen license must be reviewed before any future redistribution or bundled download is considered.
