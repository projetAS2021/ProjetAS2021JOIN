<?php

function getCsv() {

	$csvFile = file('php://input');
    $data = [];
    foreach ($csvFile as $line) {
        $data[] = str_getcsv($line,";");
    }
    return $data;
}
function insertBd($data) {
	require_once('../../connect.php');
	$co->set_charset("utf8mb4");
	$result = mysqli_query($co,"SELECT numCat FROM CATEGORIE NATURAL JOIN COMPTE WHERE (user1={$_GET['id']} OR user2={$_GET['id']}) AND nomCat='INCONNU'");
	if(mysqli_num_rows($result)==0) {
		header("HTTP/1.0 460 cat INCONNU non présente");
		return;
	}
	$r = mysqli_fetch_array($result);
	foreach($data as $line) {
		mysqli_query($co,"INSERT INTO DEPENSES(libelleD,dateD,montantD,numU,numCat) VALUES('".$line[2]."','".$line[1]."',".floatval($line[4]).",".$_GET['id'].",{$r['numCat']})");
	}
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
	#Si la méthode utilisée est POST
	case 'POST':
            insertBd(getCsv());
            
	    break;
	default:
			header("HTTP/1.0 405 Method Not Allowed");
		break;
}

?>
