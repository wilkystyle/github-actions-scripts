#!/bin/bash
set -euo pipefail

GH_ORGANIZATION=${1:-$GH_ORGANIZATION}
GH_REPOSITORY=${2:-$GH_REPOSITORY}
GH_WORKFLOW_ID=${3:-$GH_WORKFLOW_ID}

run_ids=( $(gh api repos/$GH_ORGANIZATION/$GH_REPOSITORY/actions/workflows/$GH_WORKFLOW_ID/runs --paginate | jq '.workflow_runs[].id') )

echo "Done."

for run_id in "${run_ids[@]}"
do
    echo "Deleting run $run_id for workflow $GH_WORKFLOW_ID"
    gh api repos/$GH_ORGANIZATION/$GH_REPOSITORY/actions/runs/$run_id -X DELETE >/dev/null
done

echo "All runs deleted for workflow $GH_WORKFLOW_ID."
