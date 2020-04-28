FROM thanujtk/jenkins:lts-jdk11

USER root
RUN apt-get update -qq && apt-get apt-utils install -qqy apt-transport-https ca-certificates curl lxc iptables
# Below installs docker with-in the jenkins
RUN curl -sSL https://get.docker.com | sh

RUN usermod -aG docker jenkins
CMD dockerd