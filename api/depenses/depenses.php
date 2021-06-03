<?php

function getDepenses() {
	#On se connecte à la base de données
	require_once('../connect.php');
	$co->set_charset("utf8mb4");
	#On précise qu'on renvoie un résultat en JSON
	header('Content-Type: application/json; charset=utf-8');
	#On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
	$result = mysqli_query($co,"SELECT numD, libelleD, dateD, montantD, numU, nomCat, numCpt, pourcCat FROM DEPENSES NATURAL JOIN UTILISATEUR NATURAL JOIN COMPTE NATURAL JOIN CATEGORIE WHERE user1 = ".$_GET['id']." OR user2 = ".$_GET['id']);
	$depenses=array();
	while ($r = mysqli_fetch_array($result)) {
		//$rows = array('numD' => intval($r['numD']),'libelleD' => $r['libelleD']);
		array_push($depenses,array('numD' => intval($r['numD']),'numU' => intval($r['numU']),'libelleD' => $r['libelleD'],'dateD' => $r['dateD'],'nomCat' => $r['nomCat'],'numCpt' => intval($r['numCpt']),'pourcCat' => intval($r['pourcCat']),'montantD' => floatval($r['montantD'])));
	}
	echo json_encode($depenses,JSON_PRETTY_PRINT);
}
function majCat() {
	require_once('../connect.php');
	$co->set_charset("utf8mb4");
	#On récupère le body de la requête 
	$logs = json_decode(file_get_contents('php://input'));
	#On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
	$result = mysqli_query($co,"SELECT numCat FROM CATEGORIE NATURAL JOIN COMPTE WHERE nomCat='{$logs->{'nomCat'}}' AND (user1={$logs->{'numU'}} OR user2={$logs->{'numU'}})");
	$r = mysqli_fetch_array($result);
	if(!empty($r)) {
		$update = mysqli_query($co,"UPDATE DEPENSES SET numCat='{$r[0]}' WHERE numD={$logs->{'numD'}}");
	}
	else {
		header("HTTP/1.0 500 Internal Server Error");	
	}
}
function deleteDepenses() {
	require_once('../connect.php');
	$co->set_charset("utf8mb4");
	#On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
	$result = mysqli_query($co,"DELETE FROM DEPENSES WHERE numD={$_GET['id']}");
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
	#Si la méthode utilisée est POST
	case 'GET':
            getDepenses();
	    break;
	case 'PUT':
			majCat();
		break;
	case 'DELETE':
			deleteDepenses();
		break;
	default:
			header("HTTP/1.0 405 Method Not Allowed");
		break;
}

?>
