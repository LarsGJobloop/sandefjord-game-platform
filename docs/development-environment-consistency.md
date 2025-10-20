# Development Environment Consistency

This document describes how we achieve reproducible development environments using Nix flakes for external binaries and OpenTofu for infrastructure.

## Overview

We use a minimal Nix setup to track external binaries and OpenTofu with lockfiles for infrastructure reproducibility.

## Important Caveat

This approach is **fully declarative** - everything is defined in configuration files rather than through imperative commands. This contrasts with most tutorials and guides that use imperative approaches.

The declarative nature means:

- **No manual setup steps** - Everything is captured in version-controlled files
- **No "run this command" workflows** - Configuration files define the desired state
- **Reproducible by design** - The same files produce identical results everywhere
- **Learning through VCS** - Declarative setups generally lack guides as users rely heavily on VCS and changelog tracking rather than bespoke articles

## Development Environment Reproducibility

### Nix Flake Setup

- **Definition**: [`flake.nix`](../flake.nix) - Minimal setup for external binaries only
- **Lock file**: [`flake.lock`](../flake.lock) - Pinned dependency versions
- **Cross-platform**: Supports Linux and macOS (Windows via WSL)

### Key Principle

We keep the Nix setup extremely minimal, using it only for tracking external binaries rather than writing custom derivations.

## Secret Management Reproducibility

### SOPS Configuration

- **SOPS config**: [`.sops.yaml`](../.sops.yaml) - Encryption keys and rules configuration
- **Secrets**: All sealed secrets managed through SOPS with Age encryption
- **Age encryption**: Modern encryption for secret handling

## Getting Started

### Prerequisites

- Nix package manager with flakes enabled (Nix 2.4+)

### Entering the Development Environment

```bash
nix develop
```

## Benefits

- **Instant setup**: New developers start contributing immediately
- **Identical environments**: No "works on my machine" issues
- **Version consistency**: Everyone uses the same tool versions
- **Cross-platform**: Works on Linux, macOS, and Windows (via WSL)

## Maintenance

### Adding New Tools

1. Find packages at [Nixpkgs Search](https://search.nixos.org/packages)
2. Add package to [`flake.nix`](../flake.nix)
3. Test: `nix develop`
4. Commit changes

**Note**: While it's possible to create bespoke Nix derivations for any package (whether from source code or binaries), this should be avoided when possible to maintain simplicity.

This minimal setup ensures reproducible external binaries while keeping complexity low.

## Links

- [Nix Documentation](https://nixos.org/learn/) - Official Nix package manager documentation
- [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) - Nix on Windows via WSL
- [OpenTofu Documentation](https://opentofu.org/docs/) - Infrastructure as Code tool documentation
- [SOPS Documentation](https://github.com/mozilla/sops) - Secrets management tool documentation
