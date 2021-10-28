#!/usr/bin/env sh

kitty @ new-window --cwd=${HOME}/cli-pres
sleep 1
kitty @ goto-layout tall
sleep 1
kitty @ set-font-size 26
sleep 1
kitty @ resize-window -i=-32 --self

