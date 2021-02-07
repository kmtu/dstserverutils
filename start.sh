for shard in master cave;
do
    echo "starting ${shard}"
    host=dst${shard}
    ssh steam@${host} 'tmux new -d -s dst ./run_dedicated_servers.sh'
done

