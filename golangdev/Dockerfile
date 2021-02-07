FROM ubuntu:20.04

ENV GOPATH="/go" PATH="/go/bin:/usr/local/go/bin:$PATH:/usr/local/node/bin/" TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone &&\
apt-get update &&\
apt-get install -y --no-install-recommends telnet dnsutils mercurial build-essential curl git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev zip unzip locales xfonts-utils fontconfig ctags cmake libc6-dev pkg-config libelf1 wget iputils-ping software-properties-common ninja-build gettext libtool libtool-bin autotools-dev automake sudo python3-pip python3-setuptools ssh-client supervisor nginx tmux screen openssh-server ack-grep python3-dev &&\
mkdir /go && mkdir /var/run/sshd && chmod 0755 /var/run/sshd &&\
wget https://nodejs.org/dist/v14.15.4/node-v14.15.4-linux-x64.tar.xz && tar xf node-v14.15.4-linux-x64.tar.xz && mv node-v14.15.4-linux-x64 /usr/local/node && rm node-v14.15.4-linux-x64.tar.xz && \
wget https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 -O /bin/tini && chmod +x /bin/tini &&\
wget https://github.com/neovim/neovim/archive/v0.4.4.tar.gz && tar xf v0.4.4.tar.gz && rm v0.4.4.tar.gz && cd neovim-0.4.4 && mkdir .deps && cd .deps && cmake ../third-party/ && make -j8 && cd .. && mkdir build && cd build && cmake .. && make -j8 && make install && cd / && rm -rf /neovim-0.4.4/ &&\
curl -fsSL "https://dl.google.com/go/go1.15.8.linux-amd64.tar.gz" -o golang.tar.gz \
        && echo "d3379c32a90fdf9382166f8f48034c459a8cc433730bc9476d39d9082c94583b golang.tar.gz" | sha256sum -c - \
        && tar -C /usr/local -xzf golang.tar.gz \
        && rm golang.tar.gz &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc &&\
mkdir -p ~/.config && mkdir -p /root/.vim/ &&\
ln -s /root/.vim /root/.config/nvim &&\
ln -s /root/.vimrc /root/.vim/init.vim &&\
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/coc-settings.json -o /root/.config/nvim/coc-settings.json &&\
mkdir -p ~/.vim/colors/ &&\
npm install --global yarn &&\
npm install -g neovim &&\
pip3 install neovim --upgrade && nvim -i NONE -c PlugInstall! -c quitall &&\
nvim +GoInstallBinaries +qall &&\
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

ENTRYPOINT ["/bin/tini", "--"]
CMD ["/usr/bin/sleep", "200d"]
