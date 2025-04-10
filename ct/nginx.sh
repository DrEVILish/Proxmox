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
    _   __      _
   / | / /___ _(_)___  _  __
  /  |/ / __  / / __ \| |/_/
 / /|  / /_/ / / / / />  <
/_/ |_/\__, /_/_/ /_/_/|_|
      /____/
EOF
}
header_info
echo -e "Loading..."
APP="Nginx"
var_disk="2"
var_cpu="1"
var_ram="512"
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
if [[ ! -f /lib/systemd/system/nginx.service ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP}"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable.\n
          Create a new Nginx virtual host configuration file at /etc/nginx/conf.d/[domain].conf
          \n"
