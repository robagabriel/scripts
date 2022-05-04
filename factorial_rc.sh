#!/bin/bash

factorialFirstNumber=1

while [[ -z $factorialNumber ]]
do
    read -p "Please enter the Factorial number that you what to be calculated: " factorialNumber
    if ! [[ $factorialNumber =~ ^[0-9]+$ ]]; then
	    factorialNumber=""
        echo -e "\nNo value was given!";
        echo -e "The value must be an integer!\n"
    fi
done

function factorial_rc ()
{
    if [[ $1 == "1" ]]; then
        echo $1
    else
        echo $(( $1 * $(factorial_rc $(($1 - 1)))))
    fi
}

if [[ $factorialNumber -eq "0" ]]; then
    factorialResault=$factorialFirstNumber
elif [[ $factorialNumber -le "20" ]] 
then
    factorialResault=$(factorial_rc $factorialNumber)
elif [[ $factorialNumber -gt "20" ]]
then
    echo -e "\nThis script only shows the Factorial resault from 0 to 20!"
    factorialResault="Value has exceed the variable size!"
fi

if [[ $factorialResault == "Value has exceed the variable size!" ]]; then
    echo -e "\n\e[1;31mERROR!!!\n$factorialResault"
    
else
    echo -e "\n\e[1;34mThe Factorial number is: \n$factorialNumber"
    echo -e "\nFactorial resault: \n$factorialResault"
fi

echo -e "\n\e[1;37mThe script has run successfully!\n"
sleep 1




