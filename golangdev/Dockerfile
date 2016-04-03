FROM golang:1.6.0

MAINTAINER Philo <lijianying12@gmail.com>

RUN apt-get update
RUN apt-get install -y telnet build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip
RUN apt-get install -y rubygems vim-nox locales xfonts-utils fontconfig ctags ruby-dev
RUN mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc
RUN mkdir ~/.vim/colors/ && curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim
RUN vim "+PluginInstall" "+GoInstallBinaries" "+qall"
RUN go get github.com/go-sql-driver/mysql && go get github.com/garyburd/redigo/redis && go get github.com/jmoiron/sqlx && go get gopkg.in/yaml.v2 && go get golang.org/x/crypto/bcrypt && go get -u google.golang.org/grpc && go get -u github.com/lib/pq && go get -u gopkg.in/mgo.v2 && go get -a github.com/golang/protobuf/protoc-gen-go
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
RUN mkdir ~/.fonts/ && cd ~/.fonts/ && git clone https://github.com/eugeii/consolas-powerline-vim.git && cd consolas-powerline-vim/ && cp *.ttf .. && cd .. && rm -rf consolas-powerline-vim/ && mkfontscale && mkfontdir && fc-cache -vf 
RUN cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make 
RUN go get -u github.com/benschw/dns-clb-go/clb && go get -u github.com/codegangsta/negroni && go get -u github.com/dgrijalva/jwt-go &&  go get -u github.com/elgs/gostrgen && go get -u github.com/gorilla/context && go get -u github.com/gorilla/mux && go get -u github.com/pborman/uuid && go get github.com/wothing/log && go get github.com/ylywyn/jpush-api-go-client && go get gopkg.in/doug-martin/goqu.v3 && go get github.com/hashicorp/consul/api && go get -u qiniupkg.com/api.v7
