FROM ubuntu:14.04

COPY sources.list /etc/apt/sources.list
ENV LANG en_US.UTF-8
RUN apt-get update && apt-get install -y mitmproxy locales xfonts-utils fontconfig &&  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8" 


