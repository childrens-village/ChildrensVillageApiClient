#!/usr/bin/env bash

set -eu

cd "$(dirname "$0")"

swift package describe --type json > project.json

.build/checkouts/mockingbird/mockingbird generate \
  --project project.json \
  --targets JwtApiClient \
  --testbundle ChildrensVillageApiClientTests \
  --output-dir Tests/ChildrensVillageApiClientTests/Mocks \

exit 0
