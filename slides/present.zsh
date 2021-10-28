#!/usr/bin/env zsh
kitty @ set-colors background=white

basedir=$(dirname "$0")
seq=1
prefix="01"
max="$(gecho $(basename $(lsd --reverse ${basedir}/*-slide.png | ghead -n 1)) | gawk -F'-' '{ print $1; }')"

cols=$(tput cols)
lcols=$(($cols/2))
if [[ $((cols % 2)) -eq 1 ]]
then
  rcols=$(($cols/2 + 1))
else
  rcols=$lcols
fi
msgfmt="%-${lcols}s%${rcols}s\n"

while [[ -f "${basedir}/${prefix}-slide.png" ]]
do
  clear
  printf $msgfmt "Slide ${prefix} of ${max}" "(n)ext|(p)rev|e(x)it"
  kitty +kitten icat --align=center "${basedir}/${prefix}-slide.png"
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
  elif [[ "$direction" == "g" ]]
  then
    read -s num
    seq=$((num + 0))
    if [[ $seq -lt 1 ]]; then seq=1; fi
    if [[ $seq -gt $max ]]; then seq=$max; fi
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
