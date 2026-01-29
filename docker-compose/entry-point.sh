#!/bin/bash

#sed -i "s_<AppenderRef ref="APISERVER"/>_<AppenderRef ref="CONSOLE"/>_g" /etc/cloudstack/management/log4j-cloud.xml

if [ ! -f /acs_setup_complete ]; then
  cloudstack-setup-databases cloud:dft.wiki@acs-db --schema-only
  cloudstack-setup-management --no-start
  touch /acs_setup_complete
fi

/usr/bin/java -Djava.net.preferIPv4Stack=true \
  -Djava.security.properties=/etc/cloudstack/management/java.security.ciphers \
  -Djava.awt.headless=true \
  -Xmx2G \
  -XX:+UseParallelGC \
  -XX:MaxGCPauseMillis=500 \
  -XX:+HeapDumpOnOutOfMemoryError \
  -XX:HeapDumpPath=/var/log/cloudstack/management/ \
  -XX:ErrorFile=/var/log/cloudstack/management/cloudstack-management.err \
  --add-opens=java.base/java.lang=ALL-UNNAMED \
  --add-exports=java.base/sun.security.x509=ALL-UNNAMED \
  -cp /usr/share/cloudstack-management/lib/*:/etc/cloudstack/management:/usr/share/cloudstack-common:/usr/share/cloudstack-management/setup:/usr/share/cloudstack-management:/usr/share/java/mysql-connector-java.jar:/usr/share/cloudstack-mysql-ha/lib/* \
  org.apache.cloudstack.ServerDaemon

while true; do echo "ACS has crashed!"; sleep 30; done

