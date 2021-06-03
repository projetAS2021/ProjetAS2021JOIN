<?php

function connexion() {
	#On se connecte à la base de données
	require_once('../connect.php');
	$co->set_charset("utf8mb4");
	#On précise qu'on renvoie un résultat en JSON
	header('Content-Type: application/json; charset=utf-8');
	#On récupère le body de la requête 
	$logs = json_decode(file_get_contents('php://input'));
	#On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
	$result = mysqli_query($co,"SELECT numU FROM UTILISATEUR WHERE email='".$logs->{'email'}."' AND mdpU='".$logs->{'mdpU'}."'");
	#Si non alors on renvoie un numU négatif
	if(mysqli_num_rows($result)==0) {
		header("HTTP/1.0 500 Internal Server Error");
	}
	#Si oui alors on renvoie son numU (forcément positif)
	else {
		$r = mysqli_fetch_array($result);
		$result = mysqli_query($co,"SELECT user1 FROM COMPTE WHERE user1={$r['numU']}");
		if(mysqli_num_rows($result)==0) {
			$rows = array('numU' => intval($r['numU']),'isUser1' => 0);
		}
		else {
			$rows = array('numU' => intval($r['numU']),'isUser1' => 1);
		}
		echo json_encode($rows,JSON_PRETTY_PRINT);
	}
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
	#Si la méthode utilisée est POST
	case 'POST':
            connexion();
	    break;
	default:
			header("HTTP/1.0 405 Method Not Allowed");
		break;
}

?>
