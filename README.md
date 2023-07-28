# github-actions-scripts

A collection of helper scripts for managing GitHub Actions workflows in ways
that the GitHub Actions UI does not lend itself to easily.

## Why?

I have run into circumstances where I have removed a workflow file from my
`.github/workflows/` directory, but the old workflow name still appears in the
sidebar in the Actions web UI.

Unfortunately, the only way to remove the workflow entry from the GitHub
Actions sidebar is to additionally delete *all* workflow runs for that
workflow. This is cumbersome and super-tedious via the web UI, but much quicker
to do via the API.

The scripts here are just helpers to streamline and simplify
the required API calls and parsing of HTTP responses.

## Prerequisites

- `gh`: The GitHub API CLI tool. Used for easy authentication against and usage
  of the GitHub Actions API. See https://github.com/cli/cli#installation for
  installation instructions.
- `jq`: Used for filtering JSON responses from GitHub Actions. See
  https://jqlang.github.io/jq/download/ for installation instructions.

## Usage

### Authenticating

First, make sure you've authenticated against the API run the following, and
use the appropriate account credentials to log in:

```bash
gh auth login
```

You can check the status at any time via the following:

```bash
gh auth status
```

### Configuration

When using the scripts in this repository, you can either set the following
environment variables or pass them as positional arguments to the scripts.
Order of precedent is that positional arguments to the script override
environment variables.

### List all GitHub Actions workflows

When working with the GitHub Actions API, it is not enough to know the
UI-friendly name of your workflow, you must use the workflow ID in all API
calls.

`gh-list.sh` will list all workflows for a given username and repository:

```bash
./gh-list.sh [USERNAME_OR_ORG] [REPO_NAME]
```

You can also set the following environment variables if you don't want to pass
positional arguments to the script:

- `GH_ORGANIZATION`: The GitHub username or organization
  name, e.g. `wilkystyle` for this repository.
- `GH_REPOSITORY`: The GitHub repository containing the
  actions you wish to operate on, e.g. `github-actions-scripts` for this
  repository.

**Example output:**

```
"WORKFLOW_ID_1: Workflow 1 name"
"WORKFLOW_ID_2: Workflow 2 name"
"WORKFLOW_ID_3: Workflow 3 name"
```

### Delete all runs for a given workflow

> **WARNING:** The execution of this script will result in the deletion of all
> workflow runs for a given workflow ID. This includes the deletion of any logs
> or artifacts associated with any of the workflow runs that are deleted.

Once you have obtained the ID for a workflow you wish to delete (see above),
you can then use the ID to query for all run IDs and delete them one by one.
The `gh-delete.sh` script automates this for you:

```bash
./gh-list.sh [USERNAME_OR_ORG] [REPO_NAME] [WORKFLOW_ID]
```

You can also set the following environment variables if you don't want to pass
positional arguments to the script:

- `GH_ORGANIZATION`: The GitHub username or organization
  name, e.g. `wilkystyle` for this repository.
- `GH_REPOSITORY`: The GitHub repository containing the
  actions you wish to operate on, e.g. `github-actions-scripts` for this
  repository.
- `GH_WORKFLOW_ID`: The ID of the workflow for which you wish to delete all runs.
