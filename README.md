<div align="center">
  <a href="https://larsgunnar.no">
    <img alt="Logo" src="./docs/assets/logo.svg" height="128">
  </a>
  <h1>Sandefjord Game Platform</h1>

  <div>
    <a href="https://github.com/zabronax/sandefjord-game-platform/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/LarsGJobloop/sandefjord-game-platform?style=for-the-badge&labelColor=000000&color=000000"></a>
    <a href="https://opentofu.org/"><img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-000000?style=for-the-badge&logo=opentofu"></a>
    <a href="https://nixos.org/"><img alt="Nix" src="https://img.shields.io/badge/Nix_Flake-000000?style=for-the-badge&logo=nixos"></a>
  </div>
</div>

> [!NOTE]
> This project is in early development - there's much to yet figure out

Infrastructure as Code platform for managing game servers for social purposes.

## Overview

This repository is intended to manage the infrastructure for game servers used in social settings. The project is in early development and will evolve to meet the specific needs of the class and gaming requirements.

As we explore the requirements and technical approaches, this platform may include:

- Game server provisioning and management
- Infrastructure automation for various game types
- Monitoring and maintenance tools
- User access and permission management
- Integration with existing gaming platforms

The exact scope and features will be determined through collaborative development and experimentation.

## Project Structure

```
.
├── .github/          # GitHub workflows and templates
├── docs/             # Documentation and assets
├── project/          # GitHub repository and collaborator management
├── flake.nix         # Nix development environment
└── README.md         # This file
```

## Future Direction

We're currently considering a couple of architectural approaches for the game server infrastructure:

### Common Foundation

These initial ideas would use:

- **Hetzner** as the cloud provider
- **OpenTofu** for infrastructure provisioning and management
- **Delegated subdomain** from an external repository (full NS and complete DNSSEC chains)
- Full "everything-as-code" approach with GitOps workflows
- Our existing technology stack (SOPS, Age, Nix)

### Option 1: Simple IaC Push-Based Setup

- **CI/CD** as the reconciler for changes
- Simpler architecture with push-based deployment

### Option 2: Single-Node Kubernetes Cluster

- **Kubernetes** with **Cluster API (CAPI)** for continuous observation and reconciliation
- More complex but provides better observability and self-healing capabilities

## Development Environment

> [!NOTE]
> Development requires [Nix](https://nixos.org/). No individual tool installation instructions are provided.

This project uses Nix for reproducible development environments:

```sh
nix develop
```

The development shell includes:

- OpenTofu for infrastructure management
- SOPS for secrets handling
- Age for encryption

> [!NOTE]
> This project is designed to work well with AI-augmented IDEs like Cursor, GitHub Copilot, and similar tools to enhance the development experience.

## Technologies

This project leverages several key technologies:

- **[OpenTofu](https://opentofu.org/)** - Infrastructure as Code provisioning and management
- **[SOPS](https://github.com/getsops/sops)** - Secrets management and encryption
- **[Age](https://age-encryption.org/)** - Encryption tool for SOPS
- **[Nix](https://nixos.org/)** - Reproducible development environments and package management
- **[GitHub Actions](https://github.com/features/actions)** - Continuous integration and deployment

## External Links

- **[Source Repository](https://github.com/LarsGJobloop/sandefjord-game-platform)** - Main project repository
