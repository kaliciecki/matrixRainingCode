#!/bin/bash

# kalicieckid
# Script generates MATRIX-like green chars rain in your terminal.
# It is based on BruXy`s and Brett`s Terpstra scripts, i recreated them, understood and changed 
# a few things.
# I know cmatrix exists, but just wanted to do this myself.

#Colors to choose from:
BLUE="\033[0;34m"
LIGHTBLUE="\033[1;34m"
CYAN="\033[0;36m"
LIGHTCYAN="\033[1;36m"
RED="\033[0;31m"
LIGHTRED="\033[1;31m"
WHITE="\033[1;37m"
BLACK="\033[0;30m"
GREY="\033[0;37m"
DARKGREY="\033[1;30m"
GREEN="\033[0;32m"
LIGHTGREEN="\033[1;32m"

COLORS=($GREEN $LIGHTGREEN)

TERMINAL_LINES=$(expr `tput lines` - 1)
TERMINAL_COLUMNS=`tput cols`

CHARS=(A B C D E F G H I J K L M N O P R S T U Q V X Y Z a b c d e f g h i j k l m n o p r s tu q w x y z { } [ ] )
#CHARS=(ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ﾝ)

CHARS_AMOUNT=${#CHARS[@]}
COLORS_AMOUNT=${#COLORS[@]}

#To make our loops more readable assign commands as variables.
e=echo\ -e
s=sleep

echo -e "\033[2J\033[?25l"
tput cup 0 0
tput civis
for z in {1..1000} # Most convienent for me. If you wish to have infinite loop change to while true.
	do
	(	j=$[$RANDOM%TERMINAL_COLUMNS] d=$[$RANDOM%TERMINAL_LINES] # Assign different random value to $j and $d every time.
 
		for i in `eval $e {1..$TERMINAL_LINES}` # Main loop
			do
			c=`printf "${CHARS[$RANDOM%$CHARS_AMOUNT]}${COLORS[$RANDOM%$COLORS_AMOUNT]}"`
			$e "\033[$[i-1];${j}H$c\033[$i;${j}H$WHITE"$c;
			$s .0$[ ( $RANDOM % 18 ) + 1 ]s # Speed for columns going down. 

				if [ $i -ge $d ] # Clears the columns that went down or is rewriting them on the go.
					then
						rand=$[($RANDOM % 2)]
						if [ $rand -eq 0 ]
							then
							 $e "\033[$[i-d];${j}H " # Clearing lines
							else
							$e "\033[$[i-d];${j}H$c" # Rewriting lines
						fi
				fi
			done
		for i in `eval $e {$[i-d]..$TERMINAL_LINES}`
                     	do $e "\033[$i;${j}f "; $s 0.005s
                       	done)& $s 0.02s
	done

$s 3s;
clear&tput cup 0 0
