<?php
//clearstatcache();
$pat = "data";
$pat = $_GET['path'];
//$whole = getcwd();
//echo "$whole,";
$d = opendir($pat);

while($f = readdir($d)) {
	
if(is_file("$pat/$f")){echo "~$f,";
 }else{
echo "$f,"; // send
}
}

closedir($d);
?> 