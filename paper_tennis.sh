#!/bin/bash


border=" --------------------------------- "
boardLine=" |       |       #       |       | "
state3=" |       |       #       |       |O"
state2=" |       |       #       |   O   | "
state1=" |       |       #   O   |       | "
state0=" |       |       O       |       | "
state_1=" |       |   O   #       |       | "
state_2=" |   O   |       #       |       | "
state_3="O|       |       #       |       | "
moves="       Player 1 played: ${input1}\n       Player 2 played: ${input2}\n\n"
invalidMove="NOT A VALID MOVE !"
win1="PLAYER 1 WINS !"
win2="PLAYER 2 WINS !"
draw="IT'S A DRAW !"



winner="noWin"
player1=50
player2=50

currentState=$state0

#gets state as parameter
printBoard(){
echo " Player 1: ${player1}         Player 2: ${player2} "
echo "$border"
echo "$boardLine"
echo "$boardLine"
echo "$currentState"
echo "$boardLine"
echo "$boardLine"
echo "$border"
}



#gets player numbers and valadates answer
getInput(){
read -p "PLAYER 1 PICK A NUMBER: " -s input1
res=$(expr "$player1" - "$input1" 2> /dev/null)
echo ""


#check input 1
while [[ $res -lt 0 ]] || ! [[ $input1 =~ ^[0-9]+$ ]] ;
do
echo $invalidMove
read -p "PLAYER 1 PICK A NUMBER: " -s input1
res=$(expr "$player1" - "$input1" 2> /dev/null)
echo ""
done
player1=$res


read -p "PLAYER 2 PICK A NUMBER: " -s input2
res=$(expr "$player2" - "$input2" 2> /dev/null)
echo ""


#check input 2
while [[ $res -lt 0 ]] || ! [[ $input2 =~ ^[0-9]+$ ]] ;
do
echo $invalidMove
read -p "PLAYER 2 PICK A NUMBER: " -s input2
res=$(expr "$player2" - "$input2" 2> /dev/null)
echo ""
done
player2=$res
}


checkSide(){
case $currentState in
	$state0)
	winner=$draw
	;;

        $state3)
        winner=$win1
        ;;

	 $state2)
        winner=$win1
        ;;

        $state1)
        winner=$win1
        ;;

	*)
	winner=$win2
	;;
	esac
	
}

checkForVictory(){
if [ $player1 -eq 0 ];
then
if [ $player2 -eq 0 ];
then
checkSide
else
winner=$win2
fi
elif [ $player2 -eq 0 ];
then
winner=$win1
fi
}

moveLeft(){
case $currentState in
	$state_1)
	currentState=$state_2
	;;

	$state_2)
        currentState=$state_3
        ;;

        $state_3)
        winner=$win2
        ;;

	*)
	currentState=$state_1
	;;

esac
}



moveRight(){
case $currentState in
        $state3)
        winner=$win1
        ;;

	 $state2)
        currentState=$state3
        ;;

        $state1)
        currentState=$state2
        ;;

	*)
	currentState=$state1
	;;

esac
}


#first Round
printBoard




while [ "$winner" = "noWin" ];
do
getInput
if [ $input1 -lt $input2 ];
then moveLeft
elif [ $input2 -lt $input1 ];
then moveRight
fi 
printBoard
echo "       Player 1 played: ${input1}"
echo "       Player 2 played: ${input2}"
checkForVictory;
done
echo "$winner"
