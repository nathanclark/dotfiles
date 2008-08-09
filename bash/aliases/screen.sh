
alias sls='screen -ls'

function sc() {
  local tempfile=`mktmp` || local tempfile=/tmp/test$$
  trap "rm -f $tempfile" 0 1 2 5 15

  local screens=`screen -ls | awk '/^	/ {print $1}'`

  if [ -z "$screens" ]; then
    echo "no screens" >&2
    return
  fi

  pick_from_list $screens 2> $tempfile

  local screen=`cat_rm $tempfile`

  if [ -z "$screen" ]; then
    return 1
  fi

  screen -r $screen || screen -x $screen
}
