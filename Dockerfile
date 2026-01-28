FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV container docker
ENV HOSTNAME=acs.local

RUN apt update && apt install -y \
    systemd \
    systemd-sysv \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg \
    lsb-release \
    sudo \
    net-tools \
    iputils-ping \
    iproute2 \
    mysql-server && \
    apt clean -y

RUN echo "deb http://download.cloudstack.org/ubuntu noble 4.20" | tee /etc/apt/sources.list.d/cloudstack.list && \
    wget -O /etc/apt/trusted.gpg.d/cloudstack.asc http://download.cloudstack.org/release.asc && \
    apt update && apt install -y cloudstack-management

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN service mysql start && sleep 5 && \
    mysql -e "CREATE DATABASE IF NOT EXISTS cloud;" && \
    mysql -e "CREATE DATABASE IF NOT EXISTS cloud_usage;" && \
    mysql -e "CREATE USER IF NOT EXISTS 'cloud'@'localhost' IDENTIFIED BY 'dft.wiki';" && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'cloud'@'localhost';" && \
    cloudstack-setup-databases cloud:dft.wiki@localhost --schema-only && \
    cloudstack-setup-management && \
    systemctl mask openipmi.service

RUN systemctl enable mysql
RUN systemctl enable cloudstack-management

EXPOSE 8080 8250

CMD ["/lib/systemd/systemd"]