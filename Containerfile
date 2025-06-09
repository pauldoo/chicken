FROM quay.io/fedora/fedora-bootc:41

# Configure DNF with external repos.
RUN dnf install -y 'dnf5-command(config-manager)'
RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# DNF installs.
RUN dnf install -y \
  micro \
  tailscale

# Cleanup
RUN dnf clean all

# Enable services
RUN systemctl enable tailscaled

# Lint should be final step.
RUN bootc container lint
