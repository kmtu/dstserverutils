dstuser="steam"
shard="all"  # all, master, cave
world="Seal"
savehost="http://rakkopi.kmtu.info/public"  # contains ${world}.master/cave.latest.tgz
install_dir="/home/${dstuser}/dontstarvetogether_dedicated_server"
world_dir="/home/${dstuser}/.klei/DoNotStarveTogether"

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

chown -R ${dstuser}:${dstuser} /home/${dstuser}

