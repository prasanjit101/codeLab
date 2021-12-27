<?php 

$dbhost = "localhost:3306";
$dbuser="root";
$dbpass="";
$db = "test_db13";
$conn = mysql_connect($dbhost,$dbuser,$dbpass,$db);


//to connect to existing database
if (!$conn) {
    die('could not connect ');
}

echo 'connected succesfully\n';
mysql_close($conn);


//to create database
$sql = 'CREATE Database test_db8';
$retvalue = mysql_query($sql)

if (!$retvalue) {
    die('could not connect '.mysql_error());
}

echo "database test _db8 created successfully"

//to create new table
$sql = 'CREATE TABLE employee5('.
    'emp_id INT NOT NULL AUTO_INCREMENT,'.
    'emp_name VARCHAR(20) NOT NULL,'.
    'emp_address VARCHAR(20) NOT NULL,'.
    'emp_salary INT NOT NULL,'.
    'primary key (emp_id))';

mysql_select_db('test_db13');
$retval= mysql_query($sql);

if (!$conn) {
    die('could not connect '.mysql_error());
}

echo "Table employee 5 has been created successfully";


//Fetch database 
$sql = 'SELECT emp_id, emp_name, emp_salary FROM employee5';
mysql_select_db('test_db13');

$retval= mysql_query($sql);

if (!$retval) {
    die('could not get the data '.mysql_error());
}

while($row = mysql_fetch_array($retval, MYSQL_ASSOC)){
    echo "EMP ID: {$row['emp_id']} <br/>".
        "EMP NAME: {$row['emp_name']} <br/>".
        "EMP SALARY: {$row['emp_salary']} <br/>".
        "---------------------------------<br/>";
}



?>