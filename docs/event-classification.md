# Event Classification Flow

This project uses automated event classification to categorize changes and provide structured signals for downstream systems. All changes are automatically analyzed and labeled based on their characteristics.

1. **Create a branch** for your changes
2. **Submit a pull request** to merge into `main`
3. **Classification runs automatically** and analyzes your changes
4. **Labels are applied** based on file patterns and change characteristics
5. **Downstream systems consume** the classification signals

## Implementation

**GitHub Labeler**: The classification is implemented using [srvaroa/labeler](https://github.com/srvaroa/labeler) with patterns defined in [`.github/event-categories.yaml`](../.github/event-categories.yaml). The labeler analyzes changed files against predefined patterns to determine appropriate categories.

**GitHub Actions Workflow**: The classification workflow is defined in [`.github/workflows/classify-event.yaml`](../.github/workflows/classify-event.yaml). It runs automatically on events and applies labels based on the classification rules.

**Classification Categories**:

**File-based Categories**:

- `automation`: CI/CD workflows, GitHub Actions, automation scripts
- `documentation`: Documentation files, README, license files  
- `project`: Repository configuration, collaborator management, project settings
- `dev-environment`: Development environment setup (Nix flakes, tooling)
- `dependencies`: Dependency updates, lockfiles, version bumps
- `security`: Security-sensitive files, secrets, policies

**Commit Message Type Categories**:

- `feat`: New features and functionality
- `fix`: Bug fixes and corrections
- `refactor`: Code changes that neither fix bugs nor add features
- `docs`: Documentation-only changes
- `decision`: Project guidelines, standards, or architectural decisions

**Note**: Commit message type categories must be kept synchronized between:

1. The authoritative definitions in [`.cursor/rules/commit-messages.mdc`](../.cursor/rules/commit-messages.mdc)
2. The labeling patterns in [`.github/event-categories.yaml`](../.github/event-categories.yaml)

**Multiple Labels**: Changes can receive multiple labels when they affect different categories, enabling downstream systems to make appropriate routing decisions based on the full context of the change.

**Multi-Commit Pull Request Labeling**: When a pull request contains multiple commits with different message types, all relevant commit-type labels are applied. This provides transparency about the full scope of changes and enables quality control:

- **Transparency**: All commit types in a PR are visible, preventing "sneaky" changes
- **Quality Control**: CI systems can detect mixed-purpose PRs (e.g., `feat` + `fix` + `docs`) and require review or splitting
- **Trunk-Based Development**: Supports TDD-style development where PRs often contain related commits for features, tests, and documentation
- **Alerting**: Downstream systems can warn when PRs mix different types of changes that might need separate review cycles

## Commit Message Classification

In addition to file-based classification, this project uses structured commit messages to provide semantic signals about the nature of changes. All commit messages follow a standardized format that enables automated processing and downstream system integration.

**Commit Message Rules**: See [`.cursor/rules/commit-messages.mdc`](../.cursor/rules/commit-messages.mdc) for the complete commit message format and type definitions.

**Integration**: The commit message type provides semantic context that complements the file-based classification, enabling downstream systems to understand both what files changed and the intent behind those changes.
