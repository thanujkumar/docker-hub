#This file from Docker-Monitoring project
#https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how?utm_source=blog&utm_medium=BM_blog&utm_campaign=top-6-docker-images-for-jmeter-users-and-performance-testers
# sliming the image - https://semaphoreci.com/blog/2016/12/13/lightweight-docker-images-in-5-steps.html
#building from official openjdk
#docker image build  -f jmeter.Dockerfile -t thanujtk/jmeter .
FROM adoptopenjdk:11-jre-hotspot
LABEL maintainer="THANUJ KUMAR S C <thanuj_tk@yahoo.com>"
#Adding — no-install-recommends to apt-get install can drastically bring down the size of the image by avoiding installing packages that aren’t required to run the image
RUN apt-get update -qq && apt-get install -qqy  --no-install-recommends apt-utils apt-transport-https ca-certificates lxc iptables unzip && \
   # Remove apt cache to make the image smaller
   rm -rf /var/lib/apt/lists/* /var/cache/apt /tmp/* /var/tmp/*


ARG JMETER_VERSION="5.4"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
RUN mkdir -p ${JMETER_HOME}

RUN groupadd -r jmeter -g 500  && useradd  -d $JMETER_HOME -r -u 500 -g jmeter jmeter

# download and extract
RUN curl -L --silent ${JMETER_DOWNLOAD_URL} | tar -xz --strip=1 -C ${JMETER_HOME} && \
# installing plugins required
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-graphs-basic-2.0.zip -o /tmp/jpgc-graphs-basic-2.0.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-graphs-additional-2.0.zip -o /tmp/jpgc-graphs-additional-2.0.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-casutg-2.9.zip -o /tmp/jpgc-casutg-2.9.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-graphs-vs-2.0.zip -o /tmp/jpgc-graphs-vs-2.0.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-functions-2.1.zip -o /tmp/jpgc-functions-2.1.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-ffw-2.0.zip -o /tmp/jpgc-ffw-2.0.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-ggl-2.0.zip -o /tmp/jpgc-ggl-2.0.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-fifo-0.2.zip -o /tmp/jpgc-fifo-0.2.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-tst-2.5.zip -o /tmp/jpgc-tst-2.5.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-cmd-2.2.zip -o /tmp/jpgc-cmd-2.2.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-filterresults-2.2.zip -o /tmp/jpgc-filterresults-2.2.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-mergeresults-2.1.zip -o /tmp/jpgc-mergeresults-2.1.zip && \
    #curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-perfmon-2.1.zip -o /tmp/jpgc-perfmon-2.1.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-plancheck-2.4.zip -o /tmp/jpgc-plancheck-2.4.zip && \
    curl -L --silent https://jmeter-plugins.org/files/packages/jpgc-synthesis-2.2.zip -o /tmp/jpgc-synthesis-2.2.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-graphs-basic-2.0.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-graphs-additional-2.0.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-casutg-2.9.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-graphs-vs-2.0.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-functions-2.1.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-ffw-2.0.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-ggl-2.0.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-fifo-0.2.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-tst-2.5.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-cmd-2.2.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-filterresults-2.2.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-mergeresults-2.1.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-plancheck-2.4.zip && \
    unzip -o -d  ${JMETER_HOME} /tmp/jpgc-synthesis-2.2.zip && \
    rm /tmp/*.zip && \
    #remove docs to reduce size
    rm -rf ${JMETER_HOME}/docs

COPY jmeter.properties $JMETER_HOME/bin
RUN chmod -R ${UID} a+rwx $JMETER_HOME
ENV PATH $PATH:$JMETER_BIN
WORKDIR $JMETER_HOME
CMD ["/bin/bash"]
#docker run --rm --name jmeter --volume C://DEVELOPMENT/GIT_HUB/jmeter-automation:/tmp/ thanujtk/jmeter jmeter -n -t /tmp/TK_Jmeter_Perf.jmx -j /tmp/jmeter.log