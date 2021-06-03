<?php
function changerPourc() {
	require_once('../connect.php');
		$co->set_charset("utf8mb4");
		#On récupère le body de la requête 
		$logs = json_decode(file_get_contents('php://input'));
		#On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
		$result = mysqli_query($co,"UPDATE COMPTE SET pourcCpt={$logs->{'pourcCpt'}} WHERE user1={$logs->{'numU'}} OR user2={$logs->{'numU'}}");
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
	case 'PUT':
			changerPourc();
		break;
	default:
			header("HTTP/1.0 405 Method Not Allowed");
		break;
}
?>