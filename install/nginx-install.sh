#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Copyright (c) 2025 Ryan Freeman
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing NGINX"
$STD apt-get update
$STD apt-get install -y nginx

cat <<EOF >/etc/nginx/conf.d/www.example.com.conf
server {
    listen 80;
    listen [::]:80;
    server_name www.example.com; 

    root /var/www/html/www.example.com;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF
mkdir -p /var/www/html/www.example.com

cat <<EOF >/var/www/html/www.example.com/index.html
<!DOCTYPE html>
<html>
    <head></head>
    <body>
        <h1>Greetings from NGINX1</h1>
        <p>aka Hello World!</p>
    </body>
</html>
EOF

systemctl start nginx
systemctl enable --now -q nginx.service
msg_ok "Installed NGINX"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
