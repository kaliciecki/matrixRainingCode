#!/bin/bash

#Script generates MATRIX-like green charts rain in your terminal.
#It is based on BruXy`s and Brett`s Terpstra scripts, i recreated them, understood and changed 
#a few things.

#Colors to choose from:
GREEN="\033[0;32m"
LIGHTGREEN="\033[1;32m"

COLORS=($GREEN $LIGHTGREEN)

SPACING=${1:-100}
SCROLL=	${2:-0}

TERMINAL_LINES=$(expr `tput lines` - 1)
TERMINAL_COLUMNS=`tput cols`

CHARS=(ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ﾝ)

CHARS_AMOUNT=${#CHARS[@]}
COLORS_AMOUNT=${#COLORS[@]}


echo -e "\033[2J\033[?25l"
tput cup 0 0
tput civis
while true
	do
		( e=echo\ -e s=sleep j=$[$RANDOM%TERMINAL_COLUMNS] d=$[$RANDOM%TERMINAL_LINES] 
 
			for i in `eval echo -e {1..$TERMINAL_LINES}`
				do
					c=`printf "${CHARS[$RANDOM%$CHARS_AMOUNT]}%s" " ${COLORS[$RANDOM%$COLORS_AMOUNT]}${CHARS[$RANDOM%$CHARS_AMOUNT]}"`
                        		$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c;
                                	$s .0$[ ( $RANDOM % 10 ) + 1 ]s


				if [ $i -ge $d ]
                                        then $e "\033[$[i-d];${j}H "
				fi

				done
				for i in `eval $e {$[i-d]..$TERMINAL_LINES}`
                        		do echo -e "\033[$i;${j}f "; $s 0.01s


                        	done)& sleep 1s

#			tput cup 0 0
	done
