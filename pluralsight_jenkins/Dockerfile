# https://hub.docker.com/r/jenkins/jenkins/tags
# built as thanujtk/jenkins:lts-jdk11
FROM jenkins/jenkins:lts-jdk11
USER root
#Below command installs very old version so get download link from maven.apache.org and install manually
#RUN apt-get update && apt-get install -y maven
RUN wget http://apachemirror.wuchna.com/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
RUN tar xf /tmp/apache-maven-*.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.6.3 /opt/maven
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV  PATH=${M2_HOME}/bin:${PATH}
USER jenkins
