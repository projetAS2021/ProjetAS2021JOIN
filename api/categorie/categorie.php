<?php

function modifNom() {
    require_once('../connect.php');
    $co->set_charset("utf8mb4");
    #On récupère le body de la requête 
    $logs = json_decode(file_get_contents('php://input'));
    #On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
    $result = mysqli_query($co,"SELECT numCat FROM CATEGORIE NATURAL JOIN COMPTE WHERE nomCat='{$logs->{'oldNom'}}' AND (user1={$logs->{'numU'}} OR user2={$logs->{'numU'}})");
    $r = mysqli_fetch_array($result);
    if(!empty($r)) {    
        $update = mysqli_query($co,"UPDATE CATEGORIE SET nomCat='{$logs->{'newNom'}}' WHERE numCat={$r['numCat']}");
    }
    else {
        header("HTTP/1.0 500 Internal Server Error");    
    }
}

function modifPourc() {
    require_once('../connect.php');
    $co->set_charset("utf8mb4");
    #On récupère le body de la requête 
    $logs = json_decode(file_get_contents('php://input'));
    #On exécute la requête pour vérifier si un utilisateur correspond bien aux logs
    $result = mysqli_query($co,"SELECT numCat FROM CATEGORIE NATURAL JOIN COMPTE WHERE nomCat='{$logs->{'nomCat'}}' AND user1={$logs->{'numU'}}"); //" OR user2={$logs->{'numU'}})");
    // Bonjour je m'appelle user1
   if (mysqli_num_rows($result) > 0) {
	    $r = mysqli_fetch_array($result);
	    if(!empty($r)) {    
	        $update = mysqli_query($co,"UPDATE CATEGORIE SET pourcCat='{$logs->{'pourcCat'}}' WHERE numCat={$r['numCat']}");
	    }
	    else {
	        header("HTTP/1.0 500 Internal Server Error");    
	    }
   }
   else {
   		$result = mysqli_query($co,"SELECT numCat FROM CATEGORIE NATURAL JOIN COMPTE WHERE nomCat='{$logs->{'nomCat'}}' AND user2={$logs->{'numU'}}");
   		$r = mysqli_fetch_array($result);
	    if(!empty($r)) {
	    $pourc=100-$logs->{'pourcCat'};
	        $update = mysqli_query($co,"UPDATE CATEGORIE SET pourcCat='{$pourc}' WHERE numCat={$r['numCat']}");
	    }
	    else {
	        header("HTTP/1.0 500 Internal Server Error");    
	    }
   }
}

function modif(){
    $logs = json_decode(file_get_contents('php://input'));
    if (empty($logs->{'pourcCat'})) {
        modifNom();
    }else{
        modifPourc();
    }
}
function supprimer(){
    require_once('../connect.php');
    $co->set_charset("utf8mb4");
	$logs = json_decode(file_get_contents('php://input'));
	mysqli_query($co,"UPDATE DEPENSES SET numCat = (SELECT numCat FROM CATEGORIE WHERE nomCat='INCONNU' AND numCpt=(SELECT numCpt from COMPTE where user1={$logs->{'numU'}} OR user2={$logs->{'numU'}})) WHERE numCat=(SELECT numCat FROM CATEGORIE WHERE nomCat='{$logs->{'nomCat'}}' AND numCpt=(SELECT numCpt from COMPTE where user1={$logs->{'numU'}} OR user2={$logs->{'numU'}})) AND (numU={$logs->{'numU'}} OR (numU=(SELECT user1 FROM COMPTE WHERE user2={$logs->{'numU'}}) OR numU=(SELECT user2 FROM COMPTE WHERE user1={$logs->{'numU'}})))");
   	mysqli_query($co,"DELETE FROM CATEGORIE WHERE nomCat='{$logs->{'nomCat'}}' AND numCpt IN (SELECT numCpt from COMPTE where user1={$logs->{'numU'}} OR user2={$logs->{'numU'}})");
}

function getCategories() {
	require_once('../connect.php');
    $co->set_charset("utf8mb4");
	$logs = json_decode(file_get_contents('php://input'));
	$result = mysqli_query($co,"SELECT nomCat FROM COMPTE NATURAL JOIN CATEGORIE WHERE user1 = ".$_GET['id']." OR user2 = ".$_GET['id']);
	$categories=array();
	while ($r = mysqli_fetch_array($result)) {
		array_push($categories,array('nomCat' => $r['nomCat']));
	}
	echo json_encode($categories,JSON_PRETTY_PRINT);
}
function creer() {
	require_once('../connect.php');
    	$co->set_charset("utf8mb4");
	$logs = json_decode(file_get_contents('php://input'));
	$result = mysqli_query($co,"INSERT INTO CATEGORIE(nomCat,numCpt,pourcCat) VALUES('{$logs->{'nomCat'}}',(SELECT numCpt FROM COMPTE WHERE user1={$logs->{'numU'}} OR user2={$logs->{'numU'}}),50)");
}

header("Access-Control-Allow-Origin: *");
#On récupère le nom de la méthode HTTP
$request_method = $_SERVER['REQUEST_METHOD'];
switch($request_method)
{
    #Si la méthode utilisée est PUT
    case 'PUT':
            modif();
        break;
	case 'DELETE':
		supprimer();
		break;
	case 'GET':
		getCategories();
		break;
	case 'POST':
		creer();
		break;
    default:
            header("HTTP/1.0 405 Method Not Allowed");
        break;
}

?>