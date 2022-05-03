#!/bin/bash

declare -a fibonacciList

while [[ -z $fibonacciNumberLength ]]
do
    read -p "Please enter the length of the Fibonacci number: " fibonacciNumberLength
    if ! [[ $fibonacciNumberLength =~ ^[0-9]+$ ]]; then
	    fibonacciNumberLength=""
        echo -e "\nNo value was given!";
        echo -e "The value must be an integer!\n"
    fi
done

fibonacciNumberLength=$(( $fibonacciNumberLength - 1 ))

function fibonacci_rc ()
{
    if [[ $1 -le "1" ]]; then
        echo $1
    else
        echo $(( $(fibonacci_rc $(( $1 - 1 ))) + $(fibonacci_rc $(( $1 - 2 )) ) ))
    fi
}

for fibonacciLength in $(seq 0 $fibonacciNumberLength)
do
    if [[ $fibonacciLength -le '90' ]];then
        fibonacciList+=("$(fibonacci_rc $fibonacciLength)")
    fi
done
echo -e "\nFibonacci list: \n"
echo ${fibonacciList[*]}
echo -e "\nThis script only shows 90 numbers from the series!\n"


echo -e "The script has run successfuly!\n"
sleep 1


