#!/usr/bin/env zsh

LIL_FONT=/usr/local/Cellar/figlet/2.2.5/share/figlet/fonts/C64-fonts/charact2.flf
BIG_FONT=/usr/local/Cellar/figlet/2.2.5/share/figlet/fonts/C64-fonts/roman.flf
RANDO=1

kitty @ set-colors background=black foreground=white

function rainbow_print() {
  figlet -w $(tput cols) -c -f $LIL_FONT $1 | tr '#' '█' | lolcat
  figlet -w $(tput cols) -c -f $BIG_FONT $2 | tr '#' '█' | lolcat
}

clear

while true
do
  rainbow_print "host" "brittany baker"
  echo "\n"
  rainbow_print "presenter" "curtis schlak"
  read -s -t 5 -k 1 KEY
  if [[ "$KEY" == "x" ]]; then break; fi
  clear

  if [[ "$RANDO" == "1" ]]
  then
    rainbow_print "best food" "tacos"
    RANDO=2
  elif [[ "$RANDO" == "2" ]]
  then
    rainbow_print "worst food" "french toast"
    RANDO=3
  elif [[ "$RANDO" == "3" ]]
  then
    rainbow_print "???" "where am i?"
    RANDO=1
  fi
  read -s -t 5 -k 1 KEY
  if [[ "$KEY" == "x" ]]; then break; fi
  clear
done

clear
kitty @ set-colors --reset
