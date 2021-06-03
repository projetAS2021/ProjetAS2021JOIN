<?php

function inscription() {
	#On se connecte à la base de données
	require_once('../connect.php');
	$co->set_charset("utf8mb4");
	#On précise qu'on renvoie un résultat en JSON
	header('Content-Type: application/json; charset=utf-8');
	#On récupère le body de la requête 
	$logs = json_decode(file_get_contents('php://input'));
	$returnCode=array('codeCompte' => "");
	#On exécute la requête pour ajouter un utilisateur
	if ($logs->{'email'}=="" || $logs->{'nomU'}=="" || $logs->{'prenom'}=="" || $logs->{'mdpU'}=="") {
		header("HTTP/1.0 461 Champ requis absent");
	}
	else {
		if($logs->{'codeCompte'}!="") {
			$result = mysqli_query($co,"SELECT codeCompte FROM COMPTE WHERE codeCompte='{$logs->{'codeCompte'}}'");
			if(mysqli_num_rows($result)==0) {
				header("HTTP/1.0 460 Mauvais code");
				return;
			}
		}
		if(mysqli_query($co,"INSERT INTO UTILISATEUR(email,nomU,prenom,mdpU) VALUES('".$logs->{'email'}."','".$logs->{'nomU'}."','".$logs->{'prenom'}."','".$logs->{'mdpU'}."')")) {
			$id=mysqli_insert_id($co);
			#Si l'insertion se fait on renvoie 1
			if($logs->{'codeCompte'}=="") {
				$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
				$code="";
				for ($i=0; $i<10;$i++) {
					$code = $code.$characters[random_int(0, strlen($characters))];
				}
				if(mysqli_query($co,"INSERT INTO COMPTE(user1,pourcCpt,codeCompte) VALUES({$id},50,'{$code}')")) {
					$returnCode=array('codeCompte' => $code);
					$id=mysqli_insert_id($co);
					mysqli_query($co,"INSERT INTO CATEGORIE(nomCat,pourcCat,numCpt) VALUES('INCONNU',50,{$id})");
				}
				else {
					header("HTTP/1.0 500 Internal server error");
				}
			}
			else {
				if(!mysqli_query($co,"UPDATE COMPTE SET user2={$id}, codeCompte='' WHERE numCpt=(SELECT numCpt FROM COMPTE WHERE codeCompte='{$logs->{'codeCompte'}}')"))
					header("HTTP/1.0 500 Internal server error");
			}
		}
		else {
			header("HTTP/1.0 462 Email non unique");
		}
	}
	echo json_encode($returnCode,JSON_PRETTY_PRINT);
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
	#Si la méthode utilisée est POST
	case 'POST':
            inscription();
	    break;
	default:
			header("HTTP/1.0 405 Method Not Allowed");
		break;
}

?>
