#!/usr/bin/env zsh

function move-slide () {
  jq_filter='.[].tabs | .[].windows | .[] | select(.is_focused == false) | .id'
  id=$(kitty @ ls | jq $jq_filter)
  kitty @ send-text -m id:$id $1
}

function sn () {
  move-slide "n"
}

function sp () {
  move-slide "p"
}

function sx () {
  move-slide "x"
}
