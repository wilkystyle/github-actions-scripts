#!/usr/bin/env bash
set -euo pipefail

GH_ORGANIZATION=${1:-$GH_ORGANIZATION}
GH_REPOSITORY=${2:-$GH_REPOSITORY}

gh api repos/$GH_ORGANIZATION/$GH_REPOSITORY/actions/workflows | jq '.workflows[] | select(.["state"]) | "\(.id): \(.name)"'
