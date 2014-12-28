```bash
A "/etc/my.cnf" from another install may interfere with a Homebrew-built
server starting up correctly.

To connect:
    mysql -uroot

To have launchd start mysql at login:
    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
Then to load mysql now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
Or, if you don't want/need launchctl, you can just run:
    mysql.server start
==> /usr/local/Cellar/mysql/5.6.22/bin/mysql_install_db --verbose --user=developer --basedir=/us
==> Summary
🍺  /usr/local/Cellar/mysql/5.6.22: 9666 files, 339M
```
