FROM golang:1.4.2

RUN apt-get update
RUN apt-get install -y build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
RUN apt-get install -y rubygems vim-nox
RUN mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/vimrc -o ~/.vimrc
RUN mkdir ~/.vim/colors/ && curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim
