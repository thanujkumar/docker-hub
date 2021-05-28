#verfication
#docker run --rm thanujtk/jmeter-alpine mvn -version
#docker run --rm thanujtk/jmeter-alpine jmeter -v
#docker run --rm thanujtk/jmeter-alpine java -version

#docker scan thanujtk/jmeter-alpine --file=jmeter.alpine.Dockerfile

# in few cases where maven is used jdk is required for compiler to work

#docker image build  -f jmeter.alpine.Dockerfile -t thanujtk/jmeter-alpine .
#FROM adoptopenjdk/openjdk11:jre-11.0.9.1_1-alpine
FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine-slim
#FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine
LABEL maintainer="THANUJ KUMAR S C <thanuj_tk@yahoo.com>"

ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV TMP_M2_HOME=/opt/maven

ARG JMETER_VERSION="5.4.1"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN apk update && apk upgrade && apk add curl unzip && \
    wget http://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-maven-*.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.8.1 /opt/maven && \
    mkdir -p ${JMETER_HOME} && \
    addgroup -g 500 jmeter && adduser --disabled-password --home $JMETER_HOME --ingroup jmeter --uid 500 -G jmeter jmeter && \
    # installing jmeter
    curl -L --silent ${JMETER_DOWNLOAD_URL} | tar -xz --strip=1 -C ${JMETER_HOME} && \
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
        #remove docs to reduce size
        rm -rf ${JMETER_HOME}/docs /var/lib/apk/* /var/cache/apk/* /tmp/* /var/tmp/* && \
        apk del curl unzip && \
        chmod -R ${UID} a+rwx $JMETER_HOME

COPY jmeter.properties $JMETER_HOME/bin
ENV PATH $JMETER_BIN:${TMP_M2_HOME}/bin:$PATH

WORKDIR $JMETER_HOME
CMD ["/bin/sh"]



