<?
$Title = $_GET['title'];
$Ext = $_GET['ext'];
$folder = $_GET['folder'];
$savepath = dirname($_SERVER["PATH_TRANSLATED"]);
 
$filename = $Title.".".$Ext;
while(file_exists($folder."/".$filename))
  $filename = $Title."-".rand(2,500).".".$Ext;
 
 if (is_uploaded_file($data))
 {
   $newfile = $savepath."/".$folder."/".$filename;
   if (!copy($data, $newfile))
   {
      // if an error occurs the file could not
      // be written, read or possibly does not exist
      echo "Error #1 Uploading File.";
      exit();
   }else{
      echo $folder."/".$filename;
   }
 }else{
      echo "Error #2 Uploading File.";
      exit();
 }
?>