#!/usr/bin/env bash
set -euo pipefail

NETWORK="${NETWORK:-mainnet}"
NETWORK_ROOT="/data/abcore/${NETWORK}"
CHAINDATA_DIR="${NETWORK_ROOT}/nodedata/geth/chaindata"

if [ ! -f "${NETWORK_ROOT}/conf/node.toml" ] || [ ! -f "${NETWORK_ROOT}/share/abcore${NETWORK}.json" ]; then
    echo "Extracting deploy package to /data"
    mkdir -p /data
    cp -a /opt/ab-deploy/* /data/
fi

mkdir -p "${NETWORK_ROOT}/nodedata"

if [ ! -d "${CHAINDATA_DIR}" ]; then
    echo "Initializing genesis"
    geth \
        --config "${NETWORK_ROOT}/conf/node.toml" \
        --datadir "${NETWORK_ROOT}/nodedata" \
        init "${NETWORK_ROOT}/share/abcore${NETWORK}.json"
fi

echo "Starting AB Core ${NETWORK}"
# shellcheck disable=SC2086
exec geth \
    --config "${NETWORK_ROOT}/conf/node.toml" \
    --datadir "${NETWORK_ROOT}/nodedata" \
    --http \
    --http.addr=0.0.0.0 \
    --http.port=8545 \
    --http.vhosts='*' \
    --ws \
    --ws.addr=0.0.0.0 \
    --ws.port=8546 \
    --ws.origins='*' \
    --metrics \
    --metrics.addr=0.0.0.0 \
    --metrics.port=6060 \
    ${EXTRA_FLAGS:-}
