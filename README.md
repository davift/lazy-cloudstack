# Lazy CloudStack

Quick deployments of Apache CloudStack 4.20 on Ubuntu 24.04 LTS for local tests.

# Ubuntu 24.04 LTS - Fresh Install

```
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-install.sh | sudo bash
```

# Ubuntu 24.04 LTS - Nuke

```
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-nuke.sh | sudo bash
```

# Ubuntu 24.04 LTS - Pave

```
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-pave.sh | sudo bash
```

# Docker Container

```
docker build -t lazy-cloudstack .
docker run --rm -d --name acs.local --hostname acs.local --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw -p 8080:8080 -p 8250:8250 --cgroupns=host lazy-cloudstack
docker exec -it acs.local tail -n 200 -f /var/log/cloudstack/management/management-server.log
```