#!/bin/bash


factorialFirstNumber=1
echo 

while [[ -z $factorialNumber ]]
do
    read -p "Please enter the Factorial number that you what to be calculated: " factorialNumber
    if ! [[ $factorialNumber =~ ^[0-9]+$ ]]; then
	    factorialNumber=""
        echo -e "\nNo value was given!";
        echo -e "The value must be an integer!\n"
    fi
done

for factorialNumberValue in $(seq 0 $factorialNumber)
do
    if [[ $factorialNumberValue -eq "0" ]]; then
        factorialNextNumber=$factorialFirstNumber
        factorialResault=$factorialNextNumber
    elif [[ $factorialNumberValue -le "20" ]] 
    then
        factorialNextNumber=$factorialResault
        factorialResault=$(( $factorialNextNumber * $factorialNumberValue ))
    elif [[ $factorialNumberValue -gt "20" ]]
    then
        echo -e "\nThis script only shows the Factorial resault from 0 to 20!"
        factorialResault="Value has exceed the variable size!"
    fi
done


if [[ $factorialResault == "Value has exceed the variable size!" ]]; then
    echo -e "\n\e[1;31mERROR!!!\n$factorialResault"
    
else
    echo -e "\n\e[1;34mThe Factorial number is: \n$factorialNumber"
    echo -e "\nFactorial resault: \n$factorialResault"
fi

echo -e "\n\e[1;37mThe script has run successfully!\n"
sleep 1




