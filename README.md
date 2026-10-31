# Instaconnection

## Agent Reach + OpenCLI

Install [Agent Reach](https://github.com/Panniantong/agent-reach) and its [OpenCLI](https://github.com/jackwener/opencli) dependency:

```bash
./scripts/install-agent-reach.sh              # core + OpenCLI
./scripts/install-agent-reach.sh instagram    # also add the Instagram channel (needs browser + OpenCLI extension)
```

Requirements: `curl`, Node.js/npm (Agent Reach installs a private Node if missing), and outbound access to
github.com, api.github.com, registry.npmjs.org and the sites you want to read.
