#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/DrEVILish/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Copyright (c) 2025 Ryan Freeman
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
 _       ____    _                           
| |     / / /_  (_)________  ____  __________
| | /| / / __ \/ / ___/ __ \/ __ `/ ___/ ___/
| |/ |/ / / / / (__  ) /_/ / /_/ / /  / /    
|__/|__/_/ /_/_/____/ .___/\__,_/_/  /_/     
                   /_/                       
 
EOF
}
header_info
echo -e "Loading..."
APP="Whisparr"
var_disk="4"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /var/lib/whisparr ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating LXC OS"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_info "Updating $APP"
systemctl stop whisparr.service
cd /var/lib/whisparr/
curl -fsSL 'https://whisparr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64' -o whisparr.tar.gz
tar -xvzf whisparr.tar.gz
rm -rf /opt/Whisparr
mv Whisparr /opt
chmod 775 /opt/Whisparr
systemctl start whisparr.service
msg_ok "Updated $APP and LXC OS"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}:6969${CL} \n"
