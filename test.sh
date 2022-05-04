#!/bin/bash
i=""
function testPrint ()
{
    i="$1"
    #i="100"
    echo $i
    #return $i
}
name="gabi"
var=$(testPrint $name)
echo $var
