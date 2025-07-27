#FROM quay.io/fedora/fedora-bootc:41
FROM ghcr.io/ublue-os/ucore-hci:stable

# Configure DNF with external repos.
#RUN dnf install -y 'dnf5-command(config-manager)'
#RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# DNF installs.
RUN dnf install -y \
  micro

# Cleanup
RUN dnf clean all

# Enable services
RUN systemctl enable cockpit.service && \
  systemctl enable docker.service && \
  systemctl enable nfs-server.service && \
  systemctl enable tailscaled.service

# Copy config
COPY configuration/zram-generator.conf /usr/lib/systemd/zram-generator.conf

# Lint should be final step.
RUN bootc container lint
