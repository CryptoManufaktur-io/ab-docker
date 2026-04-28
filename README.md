# AB Docker

Docker deployment for AB Core (geth fork) RPC nodes.

This is ab-docker v0.1.0

## Quick Start

```bash
cp default.env .env
# Edit .env if needed
./abd up
```

## Prerequisites

- Docker Engine 23+ with Compose V2
- 200+ GiB free disk space

```bash
# On Debian/Ubuntu:
./abd install
```

## Command Reference

| Command | Description |
|---------|-------------|
| `./abd up` | Build and start the node |
| `./abd down` | Stop the node |
| `./abd restart` | Restart the node |
| `./abd logs -f` | Follow logs |
| `./abd check-sync` | Check sync status against public RPC |
| `./abd version` | Show geth version |
| `./abd space` | Show disk space usage |
| `./abd update` | Update configuration |
| `./abd help` | Show full help |

## Configuration

Key variables in `.env`:

| Variable | Description | Default |
|----------|-------------|---------|
| `AB_VERSION` | AB Core geth binary version | `v1.13.15-abcore-1.2` |
| `AB_DEPLOY_VERSION` | AB deploy package version | `v1.8.8` |
| `NETWORK` | Network (mainnet/testnet) | `mainnet` |
| `P2P_PORT` | P2P port | `33333` |
| `RPC_PORT` | HTTP RPC port | `8545` |
| `WS_PORT` | WebSocket port | `8546` |
| `EXTRA_FLAGS` | Additional geth flags | (empty) |

### Compose File Overlays

```bash
# Expose RPC ports locally
COMPOSE_FILE=ab.yml:rpc-shared.yml

# Connect to external Traefik network
COMPOSE_FILE=ab.yml:ext-network.yml
```

## Sync Check

```bash
# Uses public AB RPC by default
./abd check-sync

# Custom public RPC
./abd check-sync --public-rpc https://rpc1.core.ab.org
```

Exit codes: 0=synced, 1=syncing, 2=diverged, 3-7=errors.

## License

Apache 2.0 - See [LICENSE](LICENSE)
