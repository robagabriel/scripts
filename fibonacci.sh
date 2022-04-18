#!/bin/bash


fibonacciFirstNumber=0
fibonacciSecondNumber=1
declare -a fibonacciList
echo 

while [[ -z $fibonacciNumberLength ]]
do
    read -p "Please enter the length of the Fibonacci number: " fibonacciNumberLength
    if ! [[ $fibonacciNumberLength =~ ^[0-9]+$ ]]; then
	    fibonacciNumberLength=""
        echo -e "\nNo value was given!";
        echo -e "The value must be an integer!\n"
    fi
done


if [[  $fibonacciNumberLength == "0" ]]; then
    echo -e "\nYou have givin the value zero the length of the string. \n"   
else
    for fibonacciLength in $(seq $fibonacciNumberLength)
    do
        if [[ $fibonacciLength -eq "1" ]]; then
            fibonacciNextNumber=$fibonacciFirstNumber
            fibonacciList+=("$fibonacciNextNumber")
        elif [[ $fibonacciLength -eq "2" ]] 
        then
            fibonacciNextNumber=$(( $fibonacciSecondNumber + $fibonacciFirstNumber ))
            fibonacciList+=("$fibonacciNextNumber")
        elif [[ $fibonacciLength -le '90' ]] 
        then
            fibonacciNextNumber=$(( $fibonacciSecondNumber + $fibonacciFirstNumber ))
            fibonacciList+=("$fibonacciNextNumber")
            fibonacciFirstNumber=$fibonacciSecondNumber
            fibonacciSecondNumber=$fibonacciNextNumber
        fi
    done
    echo -e "\nFibonacci list: \n"
    echo ${fibonacciList[*]}
    echo -e "\nThis script only shows 90 numbers from the series!\n"
fi

echo -e "The script has run successfuly!\n"
sleep 1


