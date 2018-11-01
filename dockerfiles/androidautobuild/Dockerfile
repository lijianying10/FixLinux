FROM ubuntu:14.04

MAINTAINER lijianying12@gmail.com

COPY sources.list /etc/apt/sources.list

ENV JAVA_HOME /jdk1.8.0_181
ENV ANDROID_HOME /opt/android-sdk-linux/
ENV ANDROID_SDK_FILENAME android-sdk_r24.4.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin/

RUN sudo apt-get update && sudo apt-get install -y gcc-multilib lib32z1 lib32stdc++6 git wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd / && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz -q &&\
    tar xf jdk-8u181-linux-x64.tar.gz \
    && rm -rf $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man /jdk-8u181-linux-x64.tar.gz

RUN cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    tar -xzf ${ANDROID_SDK_FILENAME} && \
    rm ${ANDROID_SDK_FILENAME} &&\
    echo y | android update sdk --no-ui --all --filter tools,platform-tools,extra-android-m2repository,android-21
RUN echo y | android update sdk --no-ui --all --filter android-22,build-tools-21.1.2,build-tools-22.0.1

