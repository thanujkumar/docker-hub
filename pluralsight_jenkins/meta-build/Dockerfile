## built as thanujtk/jenkins:lts-jdk11-v1
FROM thanujtk/jenkins:lts-jdk11

USER root
RUN apt-get update -qq && apt-get install -qqy apt-utils apt-transport-https ca-certificates curl lxc iptables
# Below installs docker with-in the jenkins
RUN curl -sSL https://get.docker.com | sh

RUN usermod -aG docker jenkins
CMD dockerd
