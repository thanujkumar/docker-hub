### plugin update URL
https://updates.jenkins.io/<jenkins-version>/latest/

https://updates.jenkins.io/2.222/latest/
https://plugins.jenkins.io/
###### List of plugins
- CloudBees Docker Build and Publish
- Slack Notification

In dockerfile when creating jenkins image we can have below commands to manually install plugins
```
RUN /usr/local/bin/install-plugins.sh greenballs
```
  
You can install docker in jenkins-master as below

```
>docker exec -it --privileged -u root jenkins-master /bin/bash

>curl -sSL https://get.docker.com | sh
>usermod -aG docker jenkins
>apt-get install docker-compose
>chmod 666 /var/run/docker.sock

login as jenkins and check is there access to run > docker version
>docker exec -it --privileged -u jenkins jenkins-master /bin/bash

After this run jenkis-master as below or after this command go back to container install docker and docker-compose

docker run --privileged -p 2112:8080 -p 50000:50000 -v C://DOCKER/Volumes/jenkins-master:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins-master thanujtk/jenkins:lts-jdk11

```