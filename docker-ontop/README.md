# Docker-Ontop

This docker deploys the Ontop system. 


The [-ontop-](http://ontop.inf.ubibz.it) framework is an open source project available under the terms of the 
[Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0.txt). 
The usage of the this docker implies the agreement with this license. 

## version

The version is 1.17.0 as the most recent version (1.18.0) showed several problems.
For more information on the release and status of the project see https://github.com/ontop/ontop/wiki/OntopReleases 
Official Website Ontop: http://ontop.inf.unibz.it/


## Running the docker

```
vagrant@vagrant:~/OSLO/docker-ontop$ sudo docker run  -i -p 8080:8080 --name ontop-webapp -v /home/vagrant/OSLO/docker-ontop/ontopdisk:/ontopdisk    docker-ontop
```

note: temporary this has to be run in interactive mode because the startup-script finishes

note: port 8080 must be used otherwith the 2 deployed webapps do not find each other


