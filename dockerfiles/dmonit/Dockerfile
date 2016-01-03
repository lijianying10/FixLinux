FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list && apt-get update
RUN apt-get install -y curl telnet git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
RUN apt-get install -y vim-nox locales xfonts-utils fontconfig tmux openssh-server screen
COPY .tmux.conf /root/
COPY .bashrc /root/
COPY .vimrc /root/
COPY freem /bin/
COPY xdev /bin/
COPY e /bin/
RUN chmod +x /bin/e /bin/xdev /bin/freem
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
RUN mkdir /root/.ssh
CMD service ssh start && echo $PUBKEY > /root/.ssh/authorized_keys && /bin/bash
