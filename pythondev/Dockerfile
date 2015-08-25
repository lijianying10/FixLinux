FROM python:1.7.10

RUN apt-get update
RUN apt-get install -y build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
RUN apt-get install -y rubygems vim-nox locales xfonts-utils fontconfig ctags ruby-dev
RUN mkdir -p ~/.vim/bundle && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/pythondev/.vimrc -o ~/.vimrc
RUN curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc
RUN mkdir ~/.vim/colors/ && curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim
RUN vim "+PluginInstall" "+GoInstallBinaries" "+qall"
RUN go get github.com/go-sql-driver/mysql && go get github.com/garyburd/redigo/redis && go get github.com/jmoiron/sqlx && go get code.google.com/p/go.net/websocket &&go get github.com/ActiveState/tail && go get gopkg.in/yaml.v2
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen "en_US.UTF-8"
RUN mkdir ~/.font/ && cd ~/.font/ && git clone https://github.com/eugeii/consolas-powerline-vim.git && cd consolas-powerline-vim/ && cp *.ttf .. && cd .. && rm -rf consolas-powerline-vim/ && mkfontscale && mkfontdir && fc-cache -vf 
RUN cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make 
RUN pip install jedi && cd ~/.vim/bundle/ && git clone --recursive https://github.com/davidhalter/jedi-vim.git

