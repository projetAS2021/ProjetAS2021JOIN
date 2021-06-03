<?php
	$expregu = shell_exec('cat  regex');
	$csv = shell_exec('cat releveTestDavid.txt | '.$expregu);
	echo $csv;
?>

