FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list && apt-get update
RUN apt-get install -y curl git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
RUN apt-get install -y vim-nox locales xfonts-utils fontconfig tmux openssh-server screen
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.tmux.conf -o ~/.tmux.conf
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/freem -o /bin/freem 
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/xdev -o /bin/xdev 
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/e -o /bin/e
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
CMD service ssh start && /bin/bash
