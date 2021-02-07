world=$1  # Seal
shard=$2  # Master, Cave
world_dir=.klei/DoNotStarveTogether/
output_file=${world}.${shard}.$(date +"%Y%m%d%H%M").tgz
backup_dir=/home/steam/dst_backup

tar -C ${world_dir} -zcf ${backup_dir}/${output_file} ${world}
echo ${backup_dir}/${output_file}

