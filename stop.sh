for shard in cave master;
do
    echo "stopping ${shard}"
    host=dst${shard}
    ssh steam@${host} 'tmux send-keys -t dst.0 "c_shutdown()" ENTER'
    ssh steam@${host} 'tmux send-keys -t dst.0 "c_shutdown()" ENTER'
done

