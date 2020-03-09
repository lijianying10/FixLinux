FROM ubuntu:18.04

ENV GOPATH="/go" PATH="/go/bin:/usr/local/go/bin:$PATH:/usr/local/node/bin/"
RUN apt-get update &&\
apt-get install -y --no-install-recommends telnet dnsutils mercurial build-essential curl git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip unzip locales xfonts-utils fontconfig ctags cmake libc6-dev pkg-config libelf1 wget iputils-ping software-properties-common ninja-build gettext libtool libtool-bin autotools-dev automake sudo python3-pip python3-setuptools ssh-client supervisor nginx tmux screen openssh-server ack-grep python3-dev &&\
mkdir /var/run/sshd && chmod 0755 /var/run/sshd &&\
wget https://github.com/krallin/tini/releases/download/v0.18.0/tini-amd64 -O /bin/tini && chmod +x /bin/tini &&\
wget https://github.com/neovim/neovim/archive/v0.4.3.tar.gz && tar xf v0.4.3.tar.gz && rm v0.4.3.tar.gz && cd neovim-0.4.3 && mkdir .deps && cd .deps && cmake ../third-party/ && make -j8 && cd .. && mkdir build && cd build && cmake .. && make -j8 && make install && cd / && rm -rf /neovim-0.4.3/ &&\
curl -fsSL "https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz" -o golang.tar.gz \
	&& echo "0567734d558aef19112f2b2873caa0c600f1b4a5827930eb5a7f35235219e9d8 golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc &&\
mkdir -p ~/.config && mkdir -p /root/.vim/ &&\
ln -s /root/.vim /root/.config/nvim &&\
ln -s /root/.vimrc /root/.vim/init.vim &&\
mkdir -p ~/.vim/colors/ &&\
curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim &&\
pip3 install neovim --upgrade && nvim -i NONE -c PlugInstall! -c quitall &&\
pip3 install neovim --upgrade && nvim -i NONE -c GoInstallBinaries! -c quitall &&\
go get -u -v github.com/fullstorydev/grpcurl &&\
go get -u -v github.com/gopherjs/gopherjs &&\
go get -u -v github.com/lijianying10/react &&\
go get -u -v myitcv.io/gogenerate &&\
cd /go/src/github.com/lijianying10/react/cmd/reactGen && go install &&\
cd /go/src/github.com/lijianying10/react/cmd/stateGen && go install &&\
go install github.com/fullstorydev/grpcurl/cmd/grpcurl &&\
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
fc-cache -vf
