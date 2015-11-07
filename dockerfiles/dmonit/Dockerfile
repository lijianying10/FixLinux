FROM ubuntu:14.04

RUN sed -i 's/archive.ubuntu/mirrors.aliyun/g' /etc/apt/sources.list && apt-get update
RUN apt-get install -y build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
RUN apt-get install -y rubygems vim-nox locales xfonts-utils fontconfig ctags ruby-dev tmux awk
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.tmux -o ~/.tmux
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/freem -o /bin/freem && chmod +x /bin/freem
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/xdev -o /bin/xdev && chmod +x /bin/xdev
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/script/e -o /bin/e && chmod +x /bin/e
RUN curl -sSL -O https://get.daocloud.io/docker/builds/Linux/x86_64/docker-1.9.0 && chmod +x docker-1.9.0 && sudo mv docker-1.9.0 /usr/local/bin/docker
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
CMD ["/bin/bash"]
