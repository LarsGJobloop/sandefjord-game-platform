# Confidential Information Handling

This document describes our approach to managing confidential information using sealed secrets with SOPS and Age encryption.

## Overview

All confidential information is encrypted at rest and managed through version-controlled, sealed secrets files. This approach ensures that sensitive data never appears in plain text while maintaining full auditability and reproducibility of our infrastructure configurations.

## Our Method

### Sealed Secrets with SOPS and Age

We use **SOPS with Age encryption** for sealed secrets management:

- **Key-based encryption**: Each authorized person has their own Age key
- **SOPS workflow**: Handles encryption/decryption automatically, maintaining YAML structure
- **Encrypted at rest**: Secrets never stored in plain text in version control
- **Automatic decryption**: Secrets decrypted during deployment processes

### SOPS Configuration

Our SOPS configuration is defined in [`.sops.yaml`](/.sops.yaml).

### Age Key Management

Age keys provide key-based access control:

- **Personal keys**: Each team member has their own Age key
- **Key distribution**: Age keys are shared securely outside of version control
- **Access revocation**: Remove keys from SOPS configuration to revoke access
- **No shared secrets**: No master keys or shared passwords to manage

## Key Principles

- **Never store plain text secrets**: SOPS encrypts automatically before commits
- **Key-based access**: Each person has their own Age key, easy to revoke
- **Full auditability**: All changes tracked in Git history

## Getting Started

SOPS and Age are available in our Nix development environment. To manage secrets:

1. Edit `secrets.yaml` files with `sops`
2. SOPS automatically encrypts values
3. Commit encrypted files
4. Deploy with automatic decryption

### Basic Operations

```sh
# Edit secrets (SOPS handles encryption automatically)
nix develop --command sops path/to/secrets.yaml

# Deploy with automatic decryption
nix develop --command tofu plan
```

## Generating New Age Key

Each team member should generate their own Age key:

```sh
# Generate new Age key
nix develop --command age-keygen -o age-key.txt

# The public key (starts with age1...) goes in .sops.yaml
# The private key (age-key.txt) stays with the individual
```

**Important**: Each person must generate their own Age key. Only the public key should be shared - the private key never leaves the individual's possession. Add the public key to the appropriate section in [`.sops.yaml`](/.sops.yaml) and create a pull request to update the configuration.

## Benefits

This sealed secrets approach provides enterprise-grade secret management while maintaining the simplicity and reproducibility of our infrastructure-as-code approach.

## Links

- [SOPS Documentation](https://github.com/mozilla/sops) - Secrets management tool documentation
- [Age Documentation](https://age-encryption.org/) - Modern encryption tool documentation
- [OpenTofu Documentation](https://opentofu.org/docs/) - Infrastructure as Code tool documentation
