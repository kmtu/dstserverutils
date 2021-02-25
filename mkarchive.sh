world=$1  # Seal
shard=$2  # master, cave
dst_user=steam
world_dir=/home/${dst_user}/.klei/DoNotStarveTogether/
output_file=${world}.${shard}.$(date -u +"%Y%m%d%H%M").tgz
backup_dir=/home/${dst_user}/dst_backup

mkdir -p ${backup_dir}
if [[ "$shard" == "master" ]]; then
  tar --exclude="Caves" -C ${world_dir} -zcf ${backup_dir}/${output_file} ${world}
elif [[ "$shard" == "cave" ]]; then
  tar --exclude="Master" -C ${world_dir} -zcf ${backup_dir}/${output_file} ${world}
else
  echo "unknown shard: '${shard}'"
  exit 1
fi
echo ${backup_dir}/${output_file}

