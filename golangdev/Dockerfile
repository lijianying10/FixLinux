FROM ubuntu:16.04

ENV GOPATH="/go" PATH="/go/bin:/usr/local/go/bin:$PATH:/usr/local/node/bin/"

RUN apt-get update &&\
apt-get install -y --no-install-recommends telnet mercurial build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip rubygems vim-nox vim-gtk locales xfonts-utils fontconfig ctags ruby-dev cmake python-dev libc6-dev pkg-config libelf1 wget iputils-ping && \
curl -fsSL "https://golang.org/dl/go1.7.5.linux-amd64.tar.gz" -o golang.tar.gz \
	&& echo "2e4dd6c44f0693bef4e7b46cc701513d74c3cc44f2419bf519d7868b12931ac3  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz &&\
curl http://beyondgrep.com/ack-2.14-single-file > /bin/ack &&\
chmod 0755 /bin/ack &&\
mkdir -p ~/.vim/bundle &&\
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc &&\
mkdir ~/.vim/colors/ &&\
curl -Ssl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim &&\
vim "+PluginInstall" "+qall" &&\
go get github.com/nsf/gocode &&\
go get github.com/alecthomas/gometalinter &&\
go get golang.org/x/tools/cmd/goimports &&\
go get golang.org/x/tools/cmd/guru &&\
go get golang.org/x/tools/cmd/gorename &&\
go get github.com/golang/lint/golint &&\
go get github.com/rogpeppe/godef &&\
go get github.com/kisielk/errcheck &&\
go get github.com/jstemmer/gotags &&\
go get github.com/klauspost/asmfmt/cmd/asmfmt &&\
go get github.com/fatih/motion &&\
go get -u github.com/haya14busa/gopkgs/cmd/gopkgs &&\
go get github.com/zmb3/gogetdoc &&\
go get github.com/josharian/impl &&\
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
cd ~/.vim/bundle/command-t/ruby/command-t &&\
ruby extconf.rb &&\
make && cd /root/.vim/bundle/YouCompleteMe &&\
./install.py --gocode-completer --clang-completer &&\
gocode set unimported-packages true &&\
cd /root/.vim/bundle/fzf && ./install --all &&\
cp /root/.vim/bundle/fzf/bin/* /bin &&\
wget https://nodejs.org/dist/v6.10.0/node-v6.10.0-linux-x64.tar.xz &&\
tar -xJf node-v6.10.0-linux-x64.tar.xz -C /usr/local --strip-components=1 &&\
rm -rf node-v6.10.0-linux-x64.tar.xz &&\
ln -s /usr/local/bin/node /usr/local/bin/nodejs &&\
npm install --global flow-bin
