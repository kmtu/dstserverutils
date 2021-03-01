mode="allinone" # or "separate"

if [[ "$mode" == "separate" ]]; then
  for shard in cave master;
  do
    host=dst${shard}
    ssh steam@${host} 'tmux has-session -t dst'
    while [[ "$?" == 0 ]]; do
        echo "waiting for ${shard} to stop..."
        sleep 5
        ssh steam@${host} 'tmux has-session -t dst'
    done
    echo "${shard} stopped"
  done
elif [[ "$mode" == "allinone" ]]; then
  host=dsttuserver
  ssh steam@${host} 'tmux has-session -t dst-all'
  while [[ "$?" == 0 ]]; do
      echo "waiting for ${host} to stop..."
      sleep 5
      ssh steam@${host} 'tmux send-keys -t dst-all.0 "c_shutdown()" ENTER'
      sleep 5
      ssh steam@${host} 'tmux has-session -t dst-all'
  done
  echo "${host} stopped"
fi
