# Change Integration Flow

This project uses a pull request workflow with automated CI checks and branch protection. All changes must go through this process:

1. **Create a branch** for your changes
2. **Submit a pull request** to merge into `main`
3. **CI runs automatically** and validates your changes
4. **Review and merge** once CI passes

## Implementation

**GitHub Actions CI**: The workflow is defined in [`.github/workflows/continuous-integration.yaml`](../.github/workflows/continuous-integration.yaml). A workflow defines a DAG (Directed Acyclic Graph) of tasks that run either sequentially or in parallel, depending on their dependencies.

**GitHub Branch Protection**: The `main` branch is protected using GitHub's branch protection rules, configured in [`project/github-continuous-integration-policies.tf`](../project/github-continuous-integration-policies.tf).
