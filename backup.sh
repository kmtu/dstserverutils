world=Seal
bkdir=/home/kmtu/dst/backup
mode="allinone" # or "separate"

for shard in master cave;
do
  if [[ "$mode" == "separate" ]]; then
    host=dst${shard}
  elif [[ "$mode" == "allinone" ]]; then
    host=tuserver
  fi
  archive=$(ssh steam@${host} "bash -s ${world} ${shard}" < /home/kmtu/dst/mkarchive.sh)
  #rsync -avh --remove-source-files steam@${host}:${archive} ${bkdir}/
  rsync -avh steam@${host}:${archive} ${bkdir}/
  cd ${bkdir}
  ln -sf $(basename ${archive}) ${world}.${shard}.latest.tgz
done

