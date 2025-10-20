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

- `automation`: CI/CD workflows, GitHub Actions, automation scripts
- `documentation`: Documentation files, README, license files  
- `project`: Repository configuration, collaborator management, project settings
- `dev-environment`: Development environment setup (Nix flakes, tooling)
- `dependencies`: Dependency updates, lockfiles, version bumps
- `security`: Security-sensitive files, secrets, policies

**Multiple Labels**: Changes can receive multiple labels when they affect different categories, enabling downstream systems to make appropriate routing decisions based on the full context of the change.

## Commit Message Classification

This project uses structured commit messages to provide semantic signals about the nature of changes. All commit messages follow a standardized format that enables automated processing and downstream system integration.

**Commit Message Rules**: See [`.cursor/rules/commit-messages.mdc`](../.cursor/rules/commit-messages.mdc) for the complete commit message format and type definitions.

**Note**: Commit message classification is separate from the automated file-based labeling system. While commit messages provide semantic context about the intent of changes, the automated labeling focuses on the technical aspects of what files were modified.

**Implementation Limitation**: No existing labeler actions support commit message or PR title matching. While this would provide valuable semantic signals, the maintenance burden of implementing and maintaining a custom solution outweighs the current need for this functionality.
