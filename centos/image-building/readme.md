Images can be build by two ways 

1. Using Dockerfile 
2. Making changes to running container and saving as image

Step 2 (Making changes to running container and saving as image):
------------
1. docker pull thanujtk/centos
2. docker run -it thanujtk/centos (should take you bash shell)
3. yum install java-11-openjdk-devel (installs jdk at /usr/lib/jvm
   [check symbolic links], use this to set JAVA_HOME location)
4. yum install java-11-openjdk (to install only JRE)
5. change to /opt and wget
   http://mirrors.estointernet.in/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
   .
6. tar -xf apache-maven-3.6.3-bin.tar.gz
7. chmod -R 777 apache-maven-3.6.3
8. Modify settings.xml to point to /MAVEN_REPO
9. cd /etc/profile.d/ and add maven.sh with below content
```
export M2_HOME=/opt/apache-maven-3.6.3
export PATH=${M2_HOME}/bin:${PATH}
```

10. chmod +x maven.sh
11. source /etc/profile.d/maven.sh
12. setting JAVA_HOME at /etc/profie.d/java.sh and then run source
   /etc/profile.d/java.sh

```
export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export PATH=$PATH:$JAVA_HOME/bin
export JRE_HOME=/usr/lib/jvm/jre
 ```
13. Installing docker-ce, docker-ce-cli
    [https://www.techrepublic.com/article/how-to-install-docker-ce-on-centos-8/](docker-ce)
    
    [https://linuxconfig.org/how-to-install-docker-in-rhel-8](container.io issue)
    
    [https://itnext.io/docker-in-docker-521958d34efd](docker can't be
    run in a docker - issue)
    
    Always run as below to avoid above issue, however host should be
    running docker daemon
    
    **docker run -v /var/run/docker.sock:/var/run/docker.sock -ti thanujtk/centos:1.2**

14. Installing jenkins -
    [https://computingforgeeks.com/how-to-install-jenkins-on-centos-rhel-8/](Jenkins)

