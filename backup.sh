world=Seal
bkdir=/home/kmtu/dst/backup
for shard in master cave;
do
    host=dst${shard}
    archive=$(ssh steam@${host} "bash -s ${world} ${shard}" < /home/kmtu/dst/mkarchive.sh)
    rsync -avh --remove-source-files steam@${host}:${archive} ${bkdir}/
done

