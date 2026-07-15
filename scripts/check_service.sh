#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://8.141.101.70}"
IMAGE_URL="${BASE_URL%/}/image-repair/"
TEMP_FILE="$(mktemp)"
trap 'rm -f "${TEMP_FILE}"' EXIT

image_status="$(curl -L -sS -o "${TEMP_FILE}" -w '%{http_code}' "${IMAGE_URL}")"
root_status="$(curl -L -sS -o /dev/null -w '%{http_code}' "${BASE_URL%/}/")"

if [[ "${image_status}" != "200" ]]; then
  echo "Image repair service failed: HTTP ${image_status} at ${IMAGE_URL}" >&2
  exit 1
fi

if [[ "${root_status}" != "200" ]]; then
  echo "Root service failed: HTTP ${root_status} at ${BASE_URL%/}/" >&2
  exit 1
fi

if ! grep -q '<div id="root"></div>' "${TEMP_FILE}"; then
  echo "Image repair page returned unexpected HTML." >&2
  exit 1
fi

echo "Image repair service: HTTP ${image_status}"
echo "Root service: HTTP ${root_status}"
