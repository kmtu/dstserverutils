#!/bin/bash

keyuser="<pub_keys_source_user>"
dstuser="<dst_install_user>"
shard="all"  # all, master, cave
world="<world_folder_name>"
savehost="http://<host>"  # contains ${world}.master.latest.tgz and ${world}.cave.latest.tgz
install_dir="/home/${dstuser}/dontstarvetogether_dedicated_server"
world_dir="/home/${dstuser}/.klei/DoNotStarveTogether"

dpkg --add-architecture i386
apt-get update
apt-get -y install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386

# create new user
adduser --disabled-password --gecos "" ${dstuser}

# prepare pub key for ssh access 
mkdir -m 700 -p /home/${dstuser}/.ssh
cat /home/${keyuser}/.ssh/authorized_keys >> /home/${dstuser}/.ssh/authorized_keys

# install steamcmd
mkdir -p /home/${dstuser}/steamcmd/
cd /home/${dstuser}
wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
tar -C /home/${dstuser}/steamcmd/ -xvzf steamcmd_linux.tar.gz

# download dst world
rm -rf ${world_dir}/${world}
cd /home/${dstuser}
mkdir -p ${world_dir}
for sd in master cave;
do
  if [[ "${shard}" == "${sd}"  || "${shard}" == "all" ]]; then
    wget "${savehost}/${world}.${sd}.latest.tgz" -O /home/${dstuser}/${world}.${sd}.latest.tgz
    tar -C /home/${dstuser}/.klei/DoNotStarveTogether/ -zxvf ${world}.${sd}.latest.tgz
  fi
done

# download dst server running script
cd /home/${dstuser}
wget https://raw.githubusercontent.com/kmtu/dstserverutils/main/server_scripts/run_dedicated_servers-${shard}.sh
chmod u+x run_dedicated_servers-${shard}.sh

chown -R ${dstuser}:${dstuser} /home/${dstuser}
sudo -H -u ${dstuser} -s bash -c "tmux new -d -s dst-${shard} /home/${dstuser}/run_dedicated_servers-${shard}.sh"

