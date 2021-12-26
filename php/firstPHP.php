<?php

class Objects
{
    function count(){
        $this->counter = 0;
        //+ - * / % ++ -- == != > < >= <= and or && || ! = += -= *= /= %= ?: 
        // .($txt1.$tx2) for concatenaion 
    }   
}

$x=10;
$obj1 = new Objects();
$arr = array(12,56,34);

function func($x,$y){
echo "\n".$x+$y."\n";
}

echo $obj1->counter = $obj1->counter+$arr[1] ;
func($x,500);
?>