#!/usr/bin/env bash
# Install Agent Reach (https://github.com/Panniantong/agent-reach) and its OpenCLI dependency.
# Follows the project's official docs/install.md. NOTE: the PyPI package named
# "agent-reach" is NOT this project -- always install from the GitHub release.
set -euo pipefail

# 1. uv (installer used by Agent Reach >= 1.6)
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"

# 2. Agent Reach itself + default channels + agent skill
if ! command -v agent-reach >/dev/null 2>&1; then
  uv tool install https://github.com/Panniantong/Agent-Reach/releases/latest/download/agent-reach.zip
fi
agent-reach setup

# 3. OpenCLI (npm @jackwener/opencli, pinned by Agent Reach to 1.8.7; Node.js required).
#    Uses Agent Reach's own installer so it lands in ~/.agent-reach/tools/npm-global
#    and is recorded as managed by Agent Reach (removed by `agent-reach uninstall`).
AR_PY="$(uv tool dir)/agent-reach/bin/python"
"$AR_PY" -I -c "from agent_reach.runtime import tools; tools.ensure('node'); print(tools.ensure('opencli'))"

# 4. Optional: browser-backed channels (also fetches the OpenCLI Chrome extension
#    from api.github.com). Pass channel names as arguments, e.g. ./install-agent-reach.sh instagram
for ch in "$@"; do
  agent-reach add "$ch"
done

agent-reach doctor --text
