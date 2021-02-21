mode="allinone" # or "separate"

if [[ "$mode" == "separate" ]]; then
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
elif [[ "$mode" == "allinone" ]]; then
  host=tuserver
  scriptdir=/home/kmtu/dst
  ssh steam@${host} 'tmux has-session -t dst-all'
  while [[ "$?" == 0 ]]; do
      echo "waiting for ${shard} to stop..."
      sleep 5
      ssh steam@${host} 'tmux has-session -t dst-all'
  done
  echo "${shard} stopped"
fi
