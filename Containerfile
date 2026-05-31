#FROM quay.io/fedora/fedora-bootc:41
FROM ghcr.io/ublue-os/ucore-hci:lts

# Configure DNF with external repos.
#RUN dnf install -y 'dnf5-command(config-manager)'
#RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# DNF installs.
RUN dnf install -y \
  fish \
  micro \
  miniupnpc \
  tcpdump \
  wget

# Cleanup
RUN dnf clean all

# Copy custom files.
COPY content /

# Enable system services
RUN systemctl enable cockpit.service && \
  systemctl enable docker.service && \
  systemctl enable nfs-server.service && \
  systemctl enable tailscaled.service && \
  systemctl enable tuned.service

# Enable custom services
RUN systemctl enable bootc-auto-reboot.timer && \
  systemctl disable restic-backups.timer

# Enable sshd to listen on the additional port
RUN semanage port -a -t ssh_port_t -p tcp 122

# Lint should be final step.
RUN bootc container lint
