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
    fi
done

echo -e "\nThe Factorial number is:\n $factorialNumber"
echo -e "\nFactorial resault:\n $factorialResault"

echo -e "\nThis script only shows the Factorial resault from 0 to 20!\n"

echo -e "The script has run successfuly!\n"
sleep 1




