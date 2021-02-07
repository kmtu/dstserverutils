for shard in cave master;
do
    host=dst${shard}
    scriptdir=/home/kmtu/dst

    ssh steam@${host} 'tmux has-session -t dst'
    while [[ "$?" == 0 ]]; do
        echo "waiting for ${shard} to stop..."
        sleep 5
        ssh steam@${host} 'tmux has-session -t dst'
    done
    echo "${shard} stopped"
done
