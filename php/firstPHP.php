<?php

class Objects
{
    function count(){
        $this->counter = 0;
        //+ - * / % ++ -- == != > < >= <= and or && || ! = += -= *= /= %= ?: **(exponent)
        // .($txt1.$tx2) for concatenaion 
    }   
}
$to_be_dumped_val='hello world';
var_dump($to_be_dumped_val);

$x=10;
$obj1 = new Objects();

//array
$arr1 = array(12,56,34);
$arr2 = array(12,56,34);

$arr3= $arr1+$arr2 ;
//+(union) ,==(equality), ===(identity)

echo $obj1->counter = $obj1->counter+$arr1[1] ;


//function
function func($x,$y){
echo "\n".$x+$y."\n";
}
func($x,500);

//class
class Bike {  
    public $color;  
    public $model;  
    public function __construct($color, $model) { 
         $this->color = $color;  $this->model = $model;  
        }
    public function message() {  
        return "My bike is a " . $this->color . " " . $this->model . "!";  
    }
}  
$myBike = new Bike("red", "Honda");  
echo $myBike -> message(); 

//if
if ($arr2[0]>$arr1[0]) {
    echo 'array 2';
}

//switch
switch ($arr[0]) {
    case '9':
        echo '9';
        break;
    default:
        echo 'not 9';
        break;
}

//for loop
for ($i=0; $i < $arr1[0]; $i++) { 
    # code...
}

//for each
foreach ($variable as $key => $value) {
    # code...
}

//while loop
while ($a <= 10) {
    # code...
}

//do while
do {
    # code...
} while ($a <= 10);

//global
$a = 10;  $b = 15;
function addition() {  
    $GLOBALS['c'] = $GLOBALS['a'] + $GLOBALS['b'];  
}  
addition();  
echo $c;

//post method
if ($_SERVER["REQUEST_METHOD"] == "POST") { 
    $name = $_POST['fname']; 
    if (empty($name)) { 
        echo "Please Enter your name"; 
    } 
    else { 
        echo $name; 
    } 
}

//get method
if ($_SERVER["REQUEST_METHOD"] == "POST") { 
    $name = $_REQUEST['fname']; 
    if (empty($name)) {
        echo "Name is empty"; 
    } 
    else { 
        echo $name; 
    } 
}

//isset($x) => checks if the value of the variable is set
//unset($x) => unsets the value of the variable
//empty($x) => check if empty


?>