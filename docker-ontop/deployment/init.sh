#!/bin/bash
ONTOPVOLUME=/ontopdisk

chmod 777 $ONTOPVOLUME
cd /var/lib/tomcat7
ln -s $ONTOPVOLUME .aduna
cd /usr/share/tomcat7
ln -s $ONTOPVOLUME .aduna

mkdir -p $ONTOPVOLUME/openrdf-sesame
mkdir -p $ONTOPVOLUME/openrdf-workbench

chown -R tomcat7:tomcat7 $ONTOPVOLUME

if [ -f /deployment/sqljdbc4.jar ] ; then
	# make the jdbc driver globably available for all webapps
	cd /usr/share/tomcat7/lib
	ln -s /deployment/sqljdbc4.jar
else 
	echo "WARNING: missing Microsoft JDBC driver"
        echo "See https://msdn.microsoft.com/en-us/library/mt683464%28v=sql.110%29.aspx"
        # redistribution is not possible on github: https://msdn.microsoft.com/en-us/sqlserver/jj589698
fi
