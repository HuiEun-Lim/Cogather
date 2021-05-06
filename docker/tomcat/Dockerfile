FROM ubuntu:latest
LABEL maintainer="5STARJeongHee <qhxmaoflr@gmail.com>"

ENV LANG=C.UTF-8
ENV TOMCAT_MAJOR=9
ENV TOMCAT_VERSION=9.0.45
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=/usr/local/tomcat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV HOME_DIR /usr/local
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH=$PATH:$JAVA_HOME/bin
RUN apt-get update
RUN apt-get install -y openssh-server vim net-tools telnet iputils-ping
RUN mkdir /var/run/sshd

#set password
RUN echo 'root:root' |chpasswd

#replace sshd_config
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /.ssh

RUN apt-get update && apt-get install -y wget tar openjdk-8-jre openjdk-8-jdk

WORKDIR ${HOME_DIR}
#install tomcat
RUN wget http://apache.mirror.cdnetworks.com/tomcat/tomcat-9/v9.0.45/bin/apache-tomcat-9.0.45.tar.gz 
RUN tar -xzf apache-tomcat-9.0.45.tar.gz && rm apache-tomcat-9.0.45.tar.gz && mv apache-tomcat-9.0.45 tomcat

WORKDIR ${CATALINA_HOME}
ADD start.sh .
RUN chmod +x start.sh

# replace tomcat server.xml config
ADD server.xml ./config 

EXPOSE 22 8080

CMD ["/bin/bash","start.sh"]