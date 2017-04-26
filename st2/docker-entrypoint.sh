echo generate ssh key
ssh-keygen -f /root/.ssh/id_rsa -P "" && cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

echo generate user
printf "%s\n" "${USER_NAME:?Need to set USER_NAME non-empty}"
printf "%s\n" "${USER_PASSWORD:?Need to set USER_PASSWORD non-empty}"
echo $USER_PASSWORD | sudo htpasswd -i /etc/st2/htpasswd $USER_NAME

echo generate cert
sudo mkdir -p /etc/ssl/st2
sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/st2/st2.key -out /etc/ssl/st2/st2.crt \
-days 365 -nodes -subj "/C=US/ST=California/L=Palo Alto/O=StackStorm/OU=Information \
Technology/CN=$(hostname)"

printf "%s\n" "${CONN_RMQ:?Need to set CONN_RMQ non-empty}"
printf "%s\n" "${MONGO_HOST:?Need to set MONGO_HOST non-empty}"
printf "%s\n" "${MONGO_DB:?Need to set MONGO_DB non-empty}"
printf "%s\n" "${MONGO_PORT:?Need to set MONGO_PORT non-empty}"
cat >> /etc/st2/st2.conf <<EOF
[system_user]
user = root
ssh_key_file = /root/.ssh/id_rsa

[messaging]
url = $CONN_RMQ

[ssh_runner]
remote_dir = /tmp

[database]
host = $MONGO_HOST
port = $MONGO_PORT
db_name = $MONGO_DB
EOF

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf