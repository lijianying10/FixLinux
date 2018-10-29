FROM ubuntu:16.04

ENV GOPATH="/go" PATH="/go/bin:/usr/local/go/bin:$PATH:/usr/local/node/bin/"

RUN apt-get update &&\
apt-get install -y --no-install-recommends telnet dnsutils mercurial build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip unzip rubygems locales xfonts-utils fontconfig ctags ruby-dev cmake python-dev libc6-dev pkg-config libelf1 wget iputils-ping software-properties-common ninja-build gettext libtool libtool-bin autotools-dev automake 
RUN wget https://github.com/neovim/neovim/archive/v0.3.1.tar.gz && tar xf v0.3.1.tar.gz && rm v0.3.1.tar.gz && cd neovim-0.3.1 && mkdir .deps && cd .deps && cmake ../third-party/ && make -j4 && cd .. && mkdir build && cd build && cmake .. && make -j4 && make install && cd / && rm -rf /neovim-0.3.1/ 
RUN curl -fsSL "https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz" -o golang.tar.gz \
	&& echo "2871270d8ff0c8c69f161aaae42f9f28739855ff5c5204752a8d92a1c9f63993 golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz &&\
curl http://beyondgrep.com/ack-2.24-single-file > /bin/ack &&\
chmod 0755 /bin/ack &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/neovim/dotfile/.vimrc -o ~/.vimrc &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/neovim/dotfile/.bashrc -o ~/.bashrc &&\
mkdir -p ~/.vim/colors/ &&\
curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim &&\
nvim "+PluginInstall" "+qall" &&\
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen &&\
locale-gen "en_US.UTF-8"&& mkdir ~/.fonts/ &&\
cd ~/.fonts/ &&\
git clone https://github.com/eugeii/consolas-powerline-vim.git &&\
cd consolas-powerline-vim/ &&\
cp *.ttf .. &&\
cd .. &&\
rm -rf consolas-powerline-vim/ &&\
mkfontscale &&\
mkfontdir &&\
fc-cache -vf &&\
gocode set unimported-packages true &&\
cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t/ &&\
ruby extconf.rb &&\
cd /root/.vim/bundle/fzf && ./install --all &&\
cp /root/.vim/bundle/fzf/bin/* /bin
