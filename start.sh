#!/bin/bash
ln -sf /dev/stdout /var/log/docker
isRunning=1
start() {
  /etc/init.d/proftpd "start" >> /var/log/docker
  /etc/init.d/apache2 "start" >> /var/log/docker
  /etc/init.d/smbd "start" >> /var/log/docker
}

stop() {
  isRunning=0
  /etc/init.d/proftpd "stop" >> /var/log/docker
  /etc/init.d/apache2 "stop" >> /var/log/docker
  /etc/init.d/smbd "stop" >> /var/log/docker
}

trap stop SIGINT SIGTERM
start
while [ $isRunning -gt 0 ]
do
   sleep 1
done
