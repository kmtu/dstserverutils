mode="allinone" # or "separate"

if [[ "$mode" == "separate" ]]; then
  for shard in master cave;
  do
    host=dst${shard}
    ssh steam@${host} 'tmux has-session -t dst'
    if [[ "$?" == 0 ]]; then
        echo "${shard} is running"
    else
        echo "${shard} is stopped"
    fi
  done
elif [[ "$mode" == "allinone" ]]; then
  host=dsttuserver
  ssh steam@${host} 'tmux has-session -t dst-all'
  if [[ "$?" == 0 ]]; then
      echo "server is running"
  else
      echo "server is stopped"
  fi
fi
