curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.vimrc -o ~/.vimrc
curl -Ssl https://raw.githubusercontent.com/lijianying10/FixLinux/master/dotfile/.bashrc -o ~/.bashrc
cat > ~/.gitconfig << EOF
[push]
    default = simple
[credential]
    helper = store
[user]
    name = 李建赢
    email = lijianying12@gmail.com
EOF



