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

> If you're deploying a bunch of systems, definitely spend time on the kickstart. What I do these days for one-off systems is only use `ostreecontainer --url [registry]/[image]/[tag]` in the ks file. This will give you a completely interactive install and is nice for doing one-offs


Install via Anaconda using e.g. Fedora Server 41 ISO:
```
inst.ks=http://192.168.x.x:8000/install.ks
```


