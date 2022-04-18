#!/bin/bash

echo -e "\e[1;34m"
echo  -e "\nHangman game!"
echo "
  ________
  |/     |
  |      O
  |      ^ 
  |    / | \ 
  |      ^
  |     / \ 
 /|\ 
/ | \ 
"
echo -e "\n\e[1;37m"



while [[ -z $hangmanWord ]]
do
    read -p "Please enter the Hangman word: " hangmanWord
    if ! [[ $hangmanWord =~ ^[a-z]+$ ]]; then
	    hangmanWord=""
        echo -e "\nNo value was given!";
        echo -e "The value must be an string!\n"
    fi
done
echo -e "\nThe value entred is: $hangmanWord\n"

stringLentgh=$(echo $hangmanWord | grep -o . | wc -l)
declare -a stringList
stringList=("$(echo $hangmanWord | grep -o .)")
echo $stringList
count=1
while [[ $count -le "5" ]]
do
    for stringNumber in $(seq $stringLentgh)
    do
        echo -e "String values"
    done
    count=$(( $count + 1 ))
done