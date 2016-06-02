FROM golang:1.6.2

MAINTAINER Philo <lijianying12@gmail.com>

RUN apt-get update
RUN apt-get install -y telnet build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip
RUN apt-get install -y rubygems vim-nox vim-gtk locales xfonts-utils fontconfig ctags ruby-dev && curl http://beyondgrep.com/ack-2.14-single-file > /bin/ack && chmod 0755 /bin/ack
RUN mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc
RUN mkdir ~/.vim/colors/ && curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim
RUN vim "+PluginInstall" "+GoInstallBinaries" "+qall"
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
RUN mkdir ~/.fonts/ && cd ~/.fonts/ && git clone https://github.com/eugeii/consolas-powerline-vim.git && cd consolas-powerline-vim/ && cp *.ttf .. && cd .. && rm -rf consolas-powerline-vim/ && mkfontscale && mkfontdir && fc-cache -vf 
RUN cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make 
