#!/bin/sh


if [ -f /deployment/init.sh ];
then
        echo "Running custom init script"
        chmod +x /deployment/init.sh
	# add sync to avoid the bug "Text file busy" 
	sync
        /deployment/init.sh
fi

if [ -n "${Xmx}" ];
then
        sed -i s/Xmx.*\ /Xmx${Xmx}\ /g /etc/default/tomcat7
fi

if [ -n "${JAVA_OPTS}" ];
then
        # Add any Java opts that are set in the container
        echo "Adding JAVA OPTS"
        echo "JAVA_OPTS=\"\${JAVA_OPTS} ${JAVA_OPTS} \"" >> /etc/default/tomcat7
fi

if [ -n "${JAVA_HOME}" ];
then
	# Add java home if set in container
	echo "Adding JAVA_HOME"
	echo "JAVA_HOME=\"${JAVA_HOME}\"" >> /etc/default/tomcat7
fi

echo "Start the tomcat7 service" 
chown tomcat7:tomcat7 /deployment
service tomcat7 restart

#Override the exit command to prevent accidental container distruction 
echo 'alias exit="echo Are you sure? this will kill the container. use Ctrl + p, Ctrl + q to detach or ctrl + d to exit"' > ~/.bashrc

#Run bash to keep container running and pr
bin/bash
