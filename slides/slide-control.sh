# This file is meant to be sourced in a zsh environment

function move-slide () {
  jq_filter='.[].tabs | .[].windows | .[] | select(.is_focused == false) | .id'
  id=$(kitty @ ls | jq $jq_filter)
  kitty @ send-text -m id:$id $1
}

function next-slide () {
  move-slide "n"
}

function prev-slide () {
  move-slide "p"
}

function exit-slide () {
  move-slide "x"
}
