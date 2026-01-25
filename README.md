# Lazy CloudStack

Quick deployments of Apache CloudStack 4.20 on Ubuntu 24.04 LTS for local tests.

There is also an upgrade path from 4.20 to 4.22.

# Ubuntu 24.04 LTS - ACS Fresh Install

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-install.sh | sudo bash
```

# Ubuntu 24.04 LTS - ACS Nuke

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-nuke.sh | sudo bash
```

# Ubuntu 24.04 LTS - ACS Pave

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-pave.sh | sudo bash
```

# Ubuntu 24.04 LTS - ACS Upgrade to 4.22

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-up-4.22.sh | sudo bash
```

# Docker Container

```bash
docker build -t lazy-cloudstack .
docker run --rm -d --name acs.local --hostname acs.local --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw -p 8080:8080 -p 8250:8250 --cgroupns=host lazy-cloudstack
docker exec -it acs.local tail -n 200 -f /var/log/cloudstack/management/management-server.log
```

