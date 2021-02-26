mode="allinone" # or "separate"

if [[ "$mode" == "separate" ]]; then
  for shard in master cave;
  do
    echo "starting ${shard}"
    host=dst${shard}
    ssh steam@${host} 'tmux has-session -t dst' && \
      echo "dst already running on ${host}" || \
      ssh steam@${host} 'tmux new -d -s dst ./run_dedicated_servers.sh'
  done
elif [[ "$mode" == "allinone" ]]; then
  host=tuserver
  echo "starting ${host}"
  ssh steam@${host} 'tmux has-session -t dst-all' && \
    echo "dst already running on ${host}" || \
    ssh steam@${host} 'tmux new -d -s dst-all ./run_dedicated_servers-all.sh'
fi

