# Lazy CloudStack

Quick deployment of Apache CloudStack 4.20 on Ubuntu and Docker for local testing.

There is also an upgrade script for version 4.22, required due to a bug that prevented direct deployment of the latest version.

# On Ubuntu 24.04

## ACS Fresh Install

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-install.sh | sudo bash
```

## ACS Nuke

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-nuke.sh | sudo bash
```

## ACS Pave

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-pave.sh | sudo bash
```

## ACS Upgrade to 4.22

```bash
curl -s https://raw.githubusercontent.com/davift/lazy-cloudstack/refs/heads/main/u24-up-4.22.sh | sudo bash
```

# On Docker

## ACS Build

```bash
docker build -t lazy-cloudstack:4.20 .
```

## ACS Run

```bash
docker run --rm -d --name acs.local --hostname acs.local --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:rw -p 8080:8080 -p 8250:8250 --cgroupns=host lazy-cloudstack:4.20
```

## ACS Live Logs

```bash
docker exec -it acs.local tail -n 200 -f /var/log/cloudstack/management/management-server.log
```

# Troubleshooting

- Static IP requirement
  - It is strongly recommended to assign a static IP address to the instance where ACS is installed. If the IP changes, ACS will not fail gracefully, because the newly assigned IP will not match the address stored in its database.

- Running ACS in containers (LXC / Docker)
  - Although ACS can run inside LXC or Docker, the hostname is typically managed by the container runtime. This can prevent ACS from starting correctly.
  - To avoid this issue, ensure that the hostname resolves to the network IP address, not the loopback address, by adjusting /etc/hosts.

- The `Dockerfile` on the root of the repository build a container that runs `systemd` and that is why it needs to be privileged.
  - Inside the container, check what is the process number 1: `ps -p 1 -o comm=`
  - If it returns anything other that `systemd`, like `bash` for example, it is not working.
