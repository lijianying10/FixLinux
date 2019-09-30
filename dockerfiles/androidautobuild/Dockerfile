FROM ubuntu:18.04

MAINTAINER lijianying12@gmail.com

RUN apt-get update && apt-get install -y sudo unzip openjdk-8-jdk gcc-multilib lib32z1 lib32stdc++6 git wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ANDROID_HOME /opt/android-sdk-linux/
ENV ANDROID_SDK_FILENAME sdk-tools-linux-4333796.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin/

RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} && \
    rm ${ANDROID_SDK_FILENAME} &&\
    echo y | sdkmanager "build-tools;26.0.0" \
        "build-tools;26.0.1" \
        "build-tools;26.0.2" \
        "build-tools;26.0.3" \
        "build-tools;27.0.0" \
        "build-tools;27.0.1" \
        "build-tools;27.0.2" \
        "build-tools;27.0.3" \
        "build-tools;28.0.0" \
        "build-tools;28.0.1" \
        "build-tools;28.0.2" \
        "build-tools;28.0.3" \
        "build-tools;29.0.0" \
        "build-tools;29.0.1" \
        "cmake;3.10.2.4988404" \
        "cmake;3.6.4111459" \
        "extras;android;gapid;1" \
        "extras;android;gapid;3" \
        "extras;android;m2repository" \
        "extras;google;auto" \
        "extras;google;google_play_services" \
        "extras;google;instantapps" \
        "extras;google;m2repository" \
        "extras;google;market_apk_expansion" \
        "extras;google;market_licensing" \
        "extras;google;simulators" \
        "extras;google;webdriver" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-alpha4" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-alpha8" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta1" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta2" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta3" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta4" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.0-beta5" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.1" \
        "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-alpha4" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-alpha8" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-beta1" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-beta2" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-beta3" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-beta4" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.0-beta5" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" \
        "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
        "lldb;2.0" \
        "lldb;2.1" \
        "lldb;2.2" \
        "lldb;2.3" \
        "lldb;3.0" \
        "lldb;3.1" \
        "ndk-bundle" \
        "ndk;20.0.5594570" \
        "patcher;v4" \
        "platform-tools" \
        "platforms;android-26" \
        "platforms;android-27" \
        "platforms;android-28" \
        "platforms;android-29" \
        "tools"

ENV PATH ${PATH}:/opt/gradle/gradle-current/bin/
RUN mkdir -p /opt/gradle && cd /opt/gradle && wget http://127.0.0.1:8000/gradle-4.8.1-bin.zip && wget http://127.0.0.1:8000/gradle-4.9-bin.zip && wget http://127.0.0.1:8000/gradle-5.5.1-bin.zip && unzip gradle-4.8.1-bin.zip &&\
unzip gradle-4.9-bin.zip &&\
unzip gradle-5.5.1-bin.zip &&\
rm *.zip
