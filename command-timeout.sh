#/bin/bash
#
# Executes any command in the background and kills it if it takes too long.
# Taken from http://typo.pburkholder.com/2009/06/22/bash-command-timeout

# Inspired by:
# http://www.ultranetsolutions.com/BASH-terminate-command-after-timeout.html
cmd_timeout() {
  if [ $# -ne 2 ]; then
    echo "cmd_timeout takes 2 arguments" 
    exit 1
  fi
  command=$1
  sleep_time=$2

  # run $command in background, sleep for our timeout then kill the process if it is running
  # $! has the pid of the backgrounded job
  $command &
  cmd_pid=$!

  # sleep for our timeout then kill the process if it is running
  ( sleep $sleep_time && kill $cmd_pid && echo "ERROR - killed $command due to timeout $sleep_time exceeded" ) &
  killer_pid=$!

  # 'wait' for cmd_pid to complete normally.  If it does before the timeout is reached, then
  # the status will be zero.  If the killer_pid terminates it, then it will have a non-zero 
  # exit status
  wait $cmd_pid &> /dev/null
  wait_status=$?

  if [ $wait_status -ne 0 ]; then 
    echo "WARNING - command, $command, unclean exit" 
  else
    # Normal exit, detach and clean up the useless killer_pid
    disown $killer_pid
    kill $killer_pid &> /dev/null
  fi

  return $wait_status
}
