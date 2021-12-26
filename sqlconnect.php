<?php 

$dbhost = "localhost::3306";
$dbuser="";
$dbpass="";
$db = "";
$conn = mysqli_connect($dbhost);

if (!$conn) {
    die('could not connect ');
}

echo 'connected succesfully\n';
mysqli_close($conn);

?>