# OpenCode Web Container

Runs OpenCode Web with git and PDF reading tools (`pdftotext`, `pdfinfo`).

## Run

The container starts OpenCode Web by default. Expose container port `4096` or the value of `OPENCODE_PORT`.

This repository includes a Compose helper for local development:

```sh
docker compose up --build
```

Open `http://localhost:4096`.

For Docker, Kubernetes, or another container runtime, mount storage to the container paths below.

## Mounts

| Container path | Purpose |
| --- | --- |
| `/home/node/workspace` | Default project workspace. OpenCode Web's project picker lists projects from `/home/node`, so mount projects under `/home/node/...` if you want them selectable there. |
| `/home/node/.config/opencode` | Persist OpenCode configuration across container restarts. |
| `/home/node/.local/share/opencode` | Persist provider login state, sessions, and OpenCode local state across container restarts. Mount this to stay logged in. |

The included Compose file mounts these paths from local ignored directories for development.

## Environment

| Name | Default | Explanation |
| --- | --- | --- |
| `OPENCODE_HOSTNAME` | `0.0.0.0` | Allows OpenCode to accept traffic forwarded by Docker, Kubernetes, or a reverse proxy. Keep this default for container deployments. |
| `OPENCODE_PORT` | `4096` | OpenCode's listen port inside the container. Change it if your platform requires a different container port. |
| `OPENCODE_SERVER_PASSWORD` | unset | Enables web UI basic auth when set. Leave unset only for trusted local networks. |
| `OPENCODE_SERVER_USERNAME` | `opencode` | Basic auth username used with `OPENCODE_SERVER_PASSWORD`; change it if you want a non-default login name. |

The Compose helper maps host port `4096` to container port `4096`.
