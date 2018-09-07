<!DOCTYPE html>
<html>
<body>


<?php
   session_start();
   $input_email = $_GET['Email'];
   $input_nickname = $_GET['NickName'];
   $input_address= $_GET['Address'];
   $input_pwd = $_GET['Password'];
   $input_phonenumber = $_GET['PhoneNumber'];
   $input_id = $_SESSION['id'];
   $conn = getDB();
   if ($conn->connect_error) {
       die("Connection failed: " . $conn->connect_error);
   }
   $sql="";
   if($input_pwd!=''){
   	$input_pwd = sha1($input_pwd);
   	/*$sql = "UPDATE credential SET nickname='$input_nickname',email='$input_email',address='$input_address',Password='$input_pwd',PhoneNumber='$input_phonenumber' where ID=$input_id;";
   }else{
   	$sql = "UPDATE credential SET nickname='$input_nickname',email='$input_email',address='$input_address',PhoneNumber='$input_phonenumber' where ID=$input_id;";
   }
   $conn->query($sql);*/
    $statement = $conn->prepare("UPDATE credential SET nickname=?,email=?,address=?,Password=?,PhoneNumber=? where ID=$input_id;");
    $statement->bind_param("sssss", $input_nickname, $input_email, $input_address,$input_pwd, $input_phonenumber);
    if (!$statement->execute()) {
       die('There was an error running the query [' . $conn->error . ']\n');
     }

   } else {
     $statement = $conn->prepare("UPDATE credential SET nickname=?,email=?,address=?, PhoneNumber=? where ID=$input_id;");
       $statement->bind_param("ssss", $input_nickname, $input_email, $input_address, $input_phonenumber);
      if (!$statement->execute()) {
          die('There was an error running the query [' . $conn->error . ']\n');
        }

   }
   $conn->close();
   header("Location: unsafe_credential.php");
   exit();

function getDB() {
   $dbhost="localhost";
   $dbuser="root";
   $dbpass="toto";
   $dbname="Users";


   // Create a DB connection
   $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
   if ($conn->connect_error) {
         die("Connection failed: " . $conn->connect_error . "\n");
   }
return $conn;
}

?>

</body>
</html>
