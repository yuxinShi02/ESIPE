


<!DOCTYPE html>
<html>
<body>

<h2>Cr&eacute;ation d'un JSON &agrave; partir de PHP.</h2>

<?php
$myObj->nom = "Durand";
$myObj->age = 30;
$myObj->ville = "New York";

$myJSON = json_encode($myObj);

echo $myJSON;
?>


</body>
</html>