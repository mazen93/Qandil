#!/bin/sh
set -e

ENV_NAME="${1:-dev}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IOS_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"
PROJECT_ROOT="$(cd "${IOS_DIR}/.." && pwd)"
ENV_FILE="${PROJECT_ROOT}/config/env.${ENV_NAME}.json"
GENERATED_XCCONFIG="${IOS_DIR}/Flutter/Generated.xcconfig"
EXPORT_ENV_SH="${IOS_DIR}/Flutter/flutter_export_environment.sh"

if [ ! -f "${ENV_FILE}" ]; then
  echo "error: Environment file not found: ${ENV_FILE}" >&2
  exit 1
fi

NEW_DART_DEFINES=$(python3 - "${ENV_FILE}" "${GENERATED_XCCONFIG}" <<'PYEOF'
import base64
import json
import os
import sys

env_file = sys.argv[1]
xcconfig_path = sys.argv[2]

with open(env_file, "r", encoding="utf-8") as f:
    env_data = json.load(f)

ordered_keys = []
kv_map = {}

def add_kv(k, v):
    if k not in kv_map:
        ordered_keys.append(k)
    kv_map[k] = v

for k, v in env_data.items():
    val_str = "true" if v is True else ("false" if v is False else str(v))
    add_kv(k, val_str)

# Preserve FLUTTER_* metadata defines if already present in Generated.xcconfig
if os.path.exists(xcconfig_path):
    with open(xcconfig_path, "r", encoding="utf-8") as f:
        for line in f:
            if line.startswith("DART_DEFINES="):
                raw = line.strip().split("=", 1)[1]
                for item in raw.split(","):
                    if not item:
                        continue
                    try:
                        decoded = base64.b64decode(item).decode("utf-8")
                        if "=" in decoded:
                            k, v = decoded.split("=", 1)
                            if k.startswith("FLUTTER_"):
                                add_kv(k, v)
                    except Exception:
                        pass

encoded = [
    base64.b64encode(f"{k}={kv_map[k]}".encode("utf-8")).decode("ascii")
    for k in ordered_keys
]
print(",".join(encoded))
PYEOF
)

update_var_in_file() {
  file_path="$1"
  prefix="$2"
  new_line="$3"
  if [ ! -f "$file_path" ]; then
    return 0
  fi
  python3 - "$file_path" "$prefix" "$new_line" <<'PYEOF'
import sys

path, prefix, new_line = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path, "r", encoding="utf-8") as f:
    lines = f.read().splitlines()

replaced = False
out = []
for line in lines:
    if line.startswith(prefix):
        out.append(new_line)
        replaced = True
    else:
        out.append(line)

if not replaced:
    out.append(new_line)

with open(path, "w", encoding="utf-8") as f:
    f.write("\n".join(out) + "\n")
PYEOF
}

update_var_in_file "${GENERATED_XCCONFIG}" "DART_DEFINES=" "DART_DEFINES=${NEW_DART_DEFINES}"
update_var_in_file "${EXPORT_ENV_SH}" 'export "DART_DEFINES=' "export \"DART_DEFINES=${NEW_DART_DEFINES}\""
echo "Synced iOS environment '${ENV_NAME}' from ${ENV_FILE}"
