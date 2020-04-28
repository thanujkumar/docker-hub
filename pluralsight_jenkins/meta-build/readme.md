Installing docker with-in jenkins container

Look at Dockerfile how https://get.docker.com is used to install docker into jenkins

  ``` 
 > docker build -t thanujtk/jenkins:lts-jdk11-v1 - < Dockerfile

  OR from location where Dockerfile exits

 > docker build -t thanujtk/jenkins:lts-jdk11-v1

  This image should be run with --privileged 
  Using docker run --privileged ......
  https://blog.trendmicro.com/trendlabs-security-intelligence/why-running-a-privileged-container-in-docker-is-a-bad-idea/

 > docker run --rm --privileged thanujtk/jenkins:lts-jdk11-v1
  login to container as 'jenkins' user, pedantic_lehmann is container name generated
 > docker exec -it --user jenkins pedantic_lehmann /bin/bash

  Now you can verify that docker is running inside the container (docker ps)
  Just to verify that i can build image in container, i will copy the meta-build/Dockerfile to this container and run it
  Open CMD window and run below command to copy to  pedantic_lehmann container
  
  >  docker cp Dockerfile pedantic_lehmann:/

  Next go to the / and execute the build in the container to check
  
  jenkins@e1d9beda693e:/$ docker build -t thanujtk/jenkins:lts-jdk11-v2 - < Dockerfile
 ``` 

 Next is to create a Jenkinsfile (buildDeploy.Jenkinsfile) which will build a docker image from ./images/Dockerfile and move it to dockerhub

 ``` 
 ``` 
 
 