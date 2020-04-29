Installing docker with-in jenkins container and running as docker daemon

Look at Dockerfile how https://get.docker.com is used to install docker 

  ``` 
 > docker build -t thanujtk/jenkins:lts-jdk11-v1 - < Dockerfile

  OR from location where Dockerfile exits

 > docker build -t thanujtk/jenkins:lts-jdk11-v1

  This image should be run with --privileged 
  Using docker run --privileged ......
  https://blog.trendmicro.com/trendlabs-security-intelligence/why-running-a-privileged-container-in-docker-is-a-bad-idea/

 > docker run --rm --privileged --name docker-daemon thanujtk/jenkins:lts-jdk11-v1
  login to container as 'jenkins' user, docker-daemon is container name 
 > docker exec -it --user jenkins docker-daemon /bin/bash

  Now you can verify that docker is running inside the container (docker ps)
  Just to verify that i can build image in container, i will copy the meta-build/Dockerfile to this container and run it
  Open CMD window and run below command to copy to  docker-daemon container
  
  >  docker cp Dockerfile docker-daemon:/

  Next go into the docker-daemon container and from the /  execute the build in the container to check docker daemon is working fine
  
  jenkins@e1d9beda693e:/$ docker build -t thanujtk/jenkins:lts-jdk11-v2 - < Dockerfile
 ``` 

 Next is to create a Jenkinsfile (buildDeploy.Jenkinsfile) which will build a docker image from ./images/Dockerfile and move it to dockerhub
 
 We run thanujtk/jenkins:lts-jdk11 as jenkins server
 
 We run thanujtk/jenkins:lts-jdk11-v1 as docker daemon
 
 Then we configure jenkins server to point to this daemon to build docker images as below.
 
 
 
 
 https://k6.io/blog/bootstrap-your-ci-with-jenkins-and-github  (on how to have credentials for login to GitHub)
 
 Developer personal token - https://github.com/settings/tokens
 
 
 