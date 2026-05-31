FROM ghcr.io/ublue-os/ucore-hci:lts

# DNF installs.
RUN dnf install -y \
  fish \
  micro \
  miniupnpc \
  wget

# Cleanup
RUN dnf clean all

# Copy custom files.
COPY content /

# Enable system services
RUN \
  systemctl enable cockpit.service && \
  systemctl enable docker.service && \
  systemctl enable nfs-server.service && \
  systemctl enable tailscaled.service && \
  systemctl enable tuned.service

# Enable custom services
RUN \
  systemctl enable bootc-auto-reboot.timer && \
  systemctl disable restic-backups.timer && \
  systemctl enable upnp-ssh-forward.timer

# Enable sshd to listen on the additional port
RUN semanage port -a -t ssh_port_t -p tcp 122

# Lint should be final step.
RUN bootc container lint
