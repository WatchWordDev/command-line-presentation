#!/usr/bin/env zsh
kitty @ set-colors background=white

seq=1
prefix="01"
max="$(lsd --reverse *-slide.png | ghead -n 1 | gawk -F'-' '{ print $1; }')"

cols=$(tput cols)
lcols=$(($cols/2))
if [[ $((cols % 2)) -eq 1 ]]
then
  rcols=$(($cols/2 + 1))
else
  rcols=$lcols
fi
msgfmt="%-${lcols}s%${rcols}s"

while [[ -f "${prefix}-slide.png" ]]
do
  clear
  printf $msgfmt "Slide ${prefix} of ${max}" "(n)ext|(p)rev|e(x)it"
  kitty +kitten icat --align=left "${prefix}-slide.png"
  read -sk direction
  if [[ "$direction" == "p" ]]
  then
    seq=$(($seq-1))
    if [[ $seq -lt 1 ]]; then seq=1; fi
    echo $seq
  elif [[ "$direction" == "n" ]]
  then
    seq=$(($seq+1))
  elif [[ "$direction" == "x" ]]
  then
    seq=$(($max+100))
  fi
  if [ $seq -lt 10 ]
  then
    prefix="0${seq}"
  else
    prefix="${seq}"
  fi
done

clear
kitty @ set-colors --reset
