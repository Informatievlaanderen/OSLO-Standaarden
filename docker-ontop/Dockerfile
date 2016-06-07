FROM java:openjdk-8-jre

MAINTAINER Bert Van Nuffelen <bert.van.nuffelen@tenforce.com>
# based on the work in docker definition of maluuba/tomcat7-java8
# but starting from a specific java version docker image

EXPOSE 8080

# Required for apt-add-repository
RUN apt-get update
RUN apt-get install -y tomcat7
RUN apt-get install -y tomcat7-admin
RUN apt-get install -y bash
RUN apt-get install -y logrotate
RUN apt-get install -y zip

ADD startup-tomcat.sh /opt/startup-tomcat.sh
RUN chmod +x /opt/startup-tomcat.sh

RUN mv /etc/cron.daily/logrotate /etc/cron.hourly/logrotate

ADD logrotate /etc/logrotate.d/tomcat7
RUN chmod 644 /etc/logrotate.d/tomcat7

ADD tomcat-setenv.sh /usr/share/tomcat7/bin/setenv.sh
ADD tomcat-users.xml /var/lib/tomcat7/conf/tomcat-users.xml
RUN chmod +x /usr/share/tomcat7/bin/setenv.sh
RUN chown root:tomcat7 /var/lib/tomcat7/conf/tomcat-users.xml

# use the build-in deployment support of tomcat to deploy a service
# 1. create a context file in the contexts 
# 2. the webapps directory contains the war one likes to deploy
#ADD unifiedviews.xml /etc/tomcat7/Catalina/localhost/unifiedviews.xml
ADD contexts /contexts
RUN cp /contexts/* /etc/tomcat7/Catalina/localhost/
ADD webapps /webapps

ADD deployment /deployment

# Ontop spefic requirements
# covered in deployment/init.sh
# add a volume which will contain all locally created files by the webapp
ADD ontopdisk /ontopdisk
RUN chown -R tomcat7:tomcat7 ontopdisk
RUN chmod 777 ontopdisk
VOLUME ontopdisk
EXPOSE 1433

RUN wget https://sourceforge.net/projects/ontop4obda/files/ontop-1.17.0/ontop-sesame-webapps-1.17.0.zip/download
RUN mv download /webapps/ontop.zip
RUN unzip /webapps/ontop.zip

ENTRYPOINT ["/opt/startup-tomcat.sh"]

