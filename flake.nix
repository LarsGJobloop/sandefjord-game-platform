{
  description = "Monorepo for Kodehode.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      # Helper functions for creating package sets.
      withSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );
    in
    {
      # Development Environments
      devShells = withPkgs (pkgs: {
        default = pkgs.mkShell {
          # Project Dependencies
          packages = with pkgs; [
            # Toolchains
            k3d # k3s in Docker
            nodejs_22 # Frontend
            dotnetCorePackages.sdk_9_0 # Backend
            just # Task runner

            # Platform
            terraform # Infrastructure as Code CLI
            kubectl # Kubernetes CLI
            k9s # k8s TUI
            fluxcd # GitOps CLI
            natscli # Message Bus CLI
            minio-client # Object Store CLI
            bento # Message Bus Stream Processor
            jq # JSON CLI stream processor
          ];

          # Development Environment Variables
          env = {
            # Required for VS Code extensions .NET
            DOTNET_ROOT = builtins.toString pkgs.dotnetCorePackages.sdk_9_0;
          };
        };
      });

      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
