#!/bin/bash

echo -e "\e[1;34m"
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
echo -e "\nHangman game!"
echo -e "The theme of the game are animals."
echo -e "\n\e[1;37m"

declare -a listOfAnimals
listOfAnimals=("crocodile" "anaconda" "hippopotamus" "octopus" "alligator" "anteater" "baboon" "dolphin" "lizard" "peacock" "flamingo" "rooster" "gorilla" "buffalo" "caterpillar" "hamster" "chimpanzee" "cougar" "cheetah" "chicken" "elephant" "rattlesnake" "lobster")


while [[ -z $hangmanWord ]]
do
    read -p "Please enter the Hangman number that represents a word: " hangmanWord
    if ! [[ $hangmanWord =~ ^[0-9]+$ && $hangmanWord -le ${#listOfAnimals[@]} ]]; then
	    hangmanWord=""
        echo -e "\nNo value was given!";
        echo -e "The value must be a number from 0 to ${#listOfAnimals[@]}!\n"
    fi
done
echo -e "\nThe value entred is: $hangmanWord\n"

stringLentgh=$(echo ${listOfAnimals[$hangmanWord]} | grep -o . | wc -l)

declare -a stringList
for arrayValue in $(echo ${listOfAnimals[$hangmanWord]} | grep -o .)
do 
    stringList+=("$arrayValue")
done

declare -a emptyString
for stringNumber in $(seq $stringLentgh)
do
    emptyString+=("_")
done
echo -e "Here you go!\n"
echo -e ${emptyString[*]}"\n"
countFails=1

while [[ $countFails -le "6" ]]
do
    while ! [[ ${stringList[*]} == ${emptyString[*]} ]]
    do
        read -p "Please enter a letter from the word: " hangmanLetter
        hangmanLetterLength=$(echo $hangmanLetter | grep -o . | wc -l)
        if ! [[ $hangmanLetter =~ ^[a-z]+$ && $hangmanLetterLength -eq "1" ]]; then
            hangmanLetter=""
            echo -e "\nNo value or to many values were given !";
            echo -e "The value must be a single letter!\n"
        else
            countString=0
            for stringNumber in $(seq $stringLentgh)
            do
                # echo "first for"
                # echo "array value: "${stringList[$countString]}" givin letter: "$hangmanLetter" conter for the array: "$countString
                if [[ ${stringList[$countString]} == $hangmanLetter ]]; then
                    emptyString[$countString]=$hangmanLetter
                    goodLetter=1
                elif [[ $countString -ge $(( $stringLentgh - 1 )) ]]
                then
                    countString=0
                fi
                countString=$(( $countString + 1 ))
            done
            if ! [[ -z $goodLetter ]]; then
                echo -e "\n\e[1;33m"
                echo -e "The letter $hangmanLetter was correct!\n"
                echo -e ${emptyString[*]}"\n"
                echo -e "\n\e[1;37m"
                goodLetter=""
            else
                echo -e "\n\e[1;33m"
                echo -e "Wrong Letter!"
                echo -e ${emptyString[*]}"\n"
                echo -e "\n\e[1;37m"
                break
            fi
        fi
    if [[ ${stringList[*]} == ${emptyString[*]} ]]; then   
        wonTheGame=1
    fi
    done
    if [[ $wonTheGame -eq "1" ]]; then
        echo -e "\n\e[1;33m"
        echo -e "You won the game!"
        echo -e "\n\e[1;37m"
        break
    elif [[ $countFails -eq "1" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
        echo "
  ________
  |/     |
  |      
  |      
  |    
  |      
  |     / 
 /|\ 
/ | \ 
"
        echo -e "\n\e[1;37m"
    elif [[ $countFails -eq "2" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
        echo "
  ________
  |/     |
  |      
  |      
  |     
  |      
  |     / \ 
 /|\ 
/ | \ 
"
        echo -e "\n\e[1;37m"
    elif [[ $countFails -eq "3" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
        echo "
  ________
  |/     |
  |      
  |      
  |    / 
  |      
  |     / \ 
 /|\ 
/ | \ 
"
        echo -e "\n\e[1;37m"
    elif [[ $countFails -eq "4" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
        echo "
  ________
  |/     |
  |      
  |       
  |    /   \ 
  |      
  |     / \ 
 /|\ 
/ | \ 
"
        echo -e "\n\e[1;37m"
    elif [[ $countFails -eq "5" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
        echo "
  ________
  |/     |
  |      
  |      ^ 
  |    / | \ 
  |      ^
  |     / \ 
 /|\ 
/ | \ 
"
        echo -e "\n\e[1;37m"
    elif [[ $countFails -eq "6" ]]
    then
        echo -e "\e[1;31m"
        echo "This was your $countFails atempt"
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
        echo -e "You lost!\n"
        echo -e "You got hanged!"
        echo -e "\n\e[1;37m"
    fi

    countFails=$(( $countFails + 1 ))

done

