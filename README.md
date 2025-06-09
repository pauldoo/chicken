# Intro

My custom image for my home NAS.

## Docs

https://docs.fedoraproject.org/en-US/bootc/

## Cheatsheet

Build:
```
podman -c podman-machine-default-root build -t chicken/test .
```

List builds:
```
podman -c podman-machine-default-root images
```

Run:
```
podman-bootc run --filesystem=btrfs chicken/test
```

List running VMs:
```
podman-bootc list
```

Poke at Fedora non-bootc container:
```
podman run -it --rm 'registry.fedoraproject.org/fedora-minimal:41'
```

See locally changed config.
```
sudo ostree admin config-diff
```