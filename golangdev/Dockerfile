FROM ubuntu:16.04

ENV GOPATH="/go" PATH="/go/bin:/usr/local/go/bin:$PATH:/usr/local/node/bin/"

RUN apt-get update &&\
apt-get install -y --no-install-recommends telnet dnsutils mercurial build-essential curl git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip unzip locales xfonts-utils fontconfig ctags cmake libc6-dev pkg-config libelf1 wget iputils-ping software-properties-common ninja-build gettext libtool libtool-bin autotools-dev automake sudo python3-pip python3-setuptools ssh-client supervisor nginx tmux screen openssh-server ack-grep &&\
mkdir /var/run/sshd && chmod 0755 /var/run/sshd &&\
wget https://github.com/krallin/tini/releases/download/v0.18.0/tini-amd64 -O /bin/tini && chmod +x /bin/tini &&\
wget https://github.com/neovim/neovim/archive/v0.3.1.tar.gz && tar xf v0.3.1.tar.gz && rm v0.3.1.tar.gz && cd neovim-0.3.1 && mkdir .deps && cd .deps && cmake ../third-party/ && make -j4 && cd .. && mkdir build && cd build && cmake .. && make -j4 && make install && cd / && rm -rf /neovim-0.3.1/ &&\
curl -fsSL "https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz" -o golang.tar.gz \
	&& echo "2871270d8ff0c8c69f161aaae42f9f28739855ff5c5204752a8d92a1c9f63993 golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz &&\
chmod 0755 /bin/ack &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc &&\
mkdir -p ~/.config && mkdir -p /root/.vim/ &&\
ln -s /root/.vim /root/.config/nvim &&\
ln -s /root/.vimrc /root/.vim/init.vim &&\
mkdir -p ~/.vim/colors/ &&\
curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim &&\
pip3 install neovim --upgrade && nvim -i NONE -c PlugInstall -c quitall &&\
go get -u github.com/klauspost/asmfmt/cmd/asmfmt &&\
go get -u github.com/derekparker/delve/cmd/dlv &&\
go get -u github.com/kisielk/errcheck &&\
go get -u github.com/davidrjenni/reftools/cmd/fillstruct &&\
go get -u github.com/mdempsky/gocode &&\
go get -u github.com/stamblerre/gocode &&\
go get -u github.com/rogpeppe/godef &&\
go get -u github.com/zmb3/gogetdoc &&\
go get -u golang.org/x/tools/cmd/goimports &&\
go get -u golang.org/x/lint/golint &&\
go get -u github.com/alecthomas/gometalinter &&\
go get -u github.com/fatih/gomodifytags &&\
go get -u golang.org/x/tools/cmd/gorename &&\
go get -u github.com/jstemmer/gotags &&\
go get -u golang.org/x/tools/cmd/guru &&\
go get -u github.com/josharian/impl &&\
go get -u honnef.co/go/tools/cmd/keyify &&\
go get -u github.com/fatih/motion &&\
go get -u github.com/koron/iferr &&\
go get -u github.com/golang/dep/cmd/dep &&\
go get -u github.com/derekparker/delve/cmd/dlv &&\
go get -u github.com/haya14busa/gopkgs/cmd/gopkgs &&\
go get -u github.com/fullstorydev/grpcurl &&\
go get -u github.com/gopherjs/gopherjs &&\
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
