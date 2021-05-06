#!/bin/bash
echo 'deploy starting...' &
/usr/local/tomcat/bin/catalina.sh run &
/usr/sbin/sshd -D
