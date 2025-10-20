# Version-Controlled Vendors

This document explains our approach to managing vendor services through declarative configuration and automated workflows.

## Overview

All vendor resources are defined as code in version-controlled files, creating consistent infrastructure and SaaS setups across environments.

## Our Method

### Declarative Infrastructure

- **Code-defined resources**: Every vendor service specified in configuration files
- **Git tracking**: Complete change history maintained in version control
- **Environment parity**: Same configurations everywhere
- **Automated workflows**: Changes via pull requests and CI/CD deployment

### Advantages over Manual Setup

- **Eliminates manual work**: No more clicking through vendor interfaces
- **Complete visibility**: Full audit trail of who changed what and when
- **Uniform setups**: Identical vendor configurations across all environments
- **Automated management**: CI/CD handles updates and drift correction
- **Easy recovery**: Simple rollback to previous working states

**The difference**: Declarative approaches use configuration files and version control, while manual methods rely on vendor web interfaces. Declarative setups prevent configuration drift and ensure consistency, while manual approaches create unpredictable, inconsistent environments.

**The critical question**: "Who changed this, when and why?" - Declarative management provides complete answers through Git history, while manual changes leave no trace.

## Key Points

Think about what data the vendor resource stores, and make sure you have monitoring and validation to confirm changes work correctly after deployment.

## Workflow

Vendor management follows our standard automated process:

1. **Create resources** in configuration files (OpenTofu/Terraform)
2. **Open pull request** with your changes
3. **Review and approve** the changes
4. **Automatic deployment** applies the changes
5. **Verify and monitor** that everything works as expected

## Resources

- [OpenTofu Documentation](https://opentofu.org/docs/) - Infrastructure as Code tool documentation
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs) - Learning resources applicable to OpenTofu
