<?php
// BolGalleryCreative - 05/03/2005
// All right reserved to Nicolas d'Haussy
// Use or modify it at your own risk

// Coders : I commented this code as much as possible for you ;)
// Coders : Need help at reducing file URLs expressions according to "current directory" PHP workflow style

// Returns a GD image file resource create and its width and height into an array
// Output array : {image resource, image width, image height}
function getImageResource($imageFile) {

	// Get image info
	$imageFileInfo = getimagesize($imageFile);
	$dataArray[1] = $imageFileInfo[0];
	$dataArray[2] = $imageFileInfo[1];

	// Create a image resource
 	if ($imageFileInfo[2] == 1) { $imageFileResource = imagecreatefromgif($imageFile); }
	if ($imageFileInfo[2] == 2) { $imageFileResource = imagecreatefromjpeg($imageFile); }
 	if ($imageFileInfo[2] == 3) { $imageFileResource = imagecreatefrompng($imageFile); }
	$dataArray[0] = $imageFileResource;	
	return $dataArray;
}



// Creates a jpeg image sized as you want focusing randomly at a detail of the reference image
function imageDetailExtract($referenceImage, $thumbnail, $thumbnailWidth, $thumbnailHeight, $thumbnailJpegQuality=70) {

	$getImageResource = getImageResource($referenceImage);
	
	// Method to display a image detail
	// Coders : problems with little images (To get rid of it, set those two variables to 0)
	// Coders : could be also enhanced so as to see more details
	$Xposition = round(rand(0, ($getImageResource[1]-$thumbnailWidth)));
	$Yposition = round(rand(0, ($getImageResource[2]-$thumbnailHeight)));

	// Create the detail image
	$thumbnailResource = imagecreatetruecolor($thumbnailWidth,$thumbnailHeight);
	imagecopy($thumbnailResource, $getImageResource[0], 0, 0, $Xposition, $Yposition, $getImageResource[1], $getImageResource[2]);
	imagejpeg($thumbnailResource, $thumbnail, $thumbnailJpegQuality);
	
	// Destroy image resources
	imagedestroy($getImageResource[0]);
	imagedestroy($thumbnailResource);
}



// Resizes the given image outputting a jpeg image
function resizeImage($referenceImage, $thumbnail, $maxWidth, $maxHeight, $thumbnailJpegQuality=70) {
	
	$getImageResource = getImageResource($referenceImage);
	
	// Recompute size for fitting (to be validated)
	if( $getImageResource[1] > $getImageResource[2]) { $maxHeight = round(($getImageResource[2]/$getImageResource[1])*$maxWidth); }
	else { $maxWidth = round(($getImageResource[1]/$getImageResource[2])*$maxHeight); }

	// Create resized image
	$thumbnailResource = imagecreatetruecolor($maxWidth,$maxHeight);
	imagecopyresized($thumbnailResource, $getImageResource[0], 0, 0, 0, 0, $maxWidth, $maxHeight, $getImageResource[1], $getImageResource[2]);
	imagejpeg($thumbnailResource, $thumbnail, $thumbnailJpegQuality);
	
	// Destroy image resources
	imagedestroy($getImageResource[0]);
	imagedestroy($thumbnailResource);
}



// Date sorting method
function mtime_sort($b, $a) { 

	if (filemtime($a) == filemtime($b)) {
		return 0; 
	} else {
		return (filemtime($a) < filemtime($b)) ? -1 : 1; 
	}
} 




// Creates bolGallery files and returns the HTML layout source string
function bolGalleryCreate($imagesList, $referenceImagesDirectory, $tableColumnsNb, $thumbnailWidth, $thumbnailHeight, $switchClassic=false) {

	// Build gallery HTML source
	$HTML = "";

// Bolgallery Javascript popup function
$bolGalleryPopup = "<!-- BolGallery Javascript popup window function -->
<SCRIPT type=\"text/javascript\">

function bolGalleryPopup(imageFile, width, height, title){

	var html = '<title>' + title + ' - Click to close </title><body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 onclick=\"javascript:window.close()\"><img src=\"' + imageFile + '\" alt=\"Click to close\"></body>';
	var popup = window.open(imageFile, '_blank', 'width=' + width+ ', height=' + height + ', status=no');
	popup.document.write(html);
	popup.focus();
}
</SCRIPT>\n\n";
$HTML .= $bolGalleryPopup;


	// Build the HTML table to display all the thumbnails
	$HTML .= "<!-- Corridors - luxfera sketches -->\n<TABLE border=0 cellspacing=0 cellpadding=0>\n\t<TR valign=\"top\">\n";
	$table_i=0;

	foreach($imagesList as $currentImage) {

				// (Re)build thumbnail url string
				$referenceImageName = str_replace($referenceImagesDirectory, "", $currentImage);
				$thumbnail = ($referenceImagesDirectory . "bolGallery/thumbnail_" . $referenceImageName); 

				// Get reference image file info
				$referenceImageInfos = getimagesize($currentImage);
				$referenceImageWidth = $referenceImageInfos[0];
				$referenceImageHeight = $referenceImageInfos[1];

				// Generate the thumbnail image if doesn't exist
				if(! file_exists($thumbnail)) {
				
					// Generate mode style thumbnail
					if($switchClassic) { resizeImage($currentImage, $thumbnail, $thumbnailWidth, $thumbnailHeight); } 
					else { imageDetailExtract($currentImage, $thumbnail, $thumbnailWidth, $thumbnailHeight); }
				}

				// Display the thumbnail image and set a popup link to the big one
				$alt = str_replace("_", " ", substr($referenceImageName, 0, -4)); 
				$HTML .= "\t\t<TD align=\"center\">\n\t\t\t<A href=\"" . $currentImage . "\" onClick=\"bolGalleryPopup(this.href, " . $referenceImageWidth. ", " . $referenceImageHeight . ", '" . $alt . "'); return(false);\" target=\"_blank\">\n"; // target attribute to be tested
				$HTML .= "\t\t\t\t<IMG src=\"" . $thumbnail . "\" title=\"" . $alt . "\" border=0>\n";				
                                $HTML .= "\t\t\t</A>\n\t\t</TD>\n";

				
				// HTML table next line evaluation

				$table_i++;
				if (($table_i % $tableColumnsNb) == 0) {
					$HTML .= "\t</TR>\n\t<TR valign=\"top\">\n";
				}

	}
	$HTML .= "\t</TR>\n\t<TR>\n\t\t<TD colspan=" . $tableColumnsNb . ">\n\t\t\t<FONT size=1>Generated by <A href=\"http://bolgallery.free.fr\" target=\"_blank\">bolGallery</A></FONT>\n\t\t</TD>\n\t</TR>\n"; // Thanks not to delete this line
	$HTML .= "</TABLE>\n<BR>\n<!--End BolGallery-->\n\n";
	return $HTML;
}


// Main function. Handles bolGalleryCreate(). Call it on your php pages where you want it build a gallery.
// Loads static page or lists reference images directory and launchs gallery creation
function bolGallery($referenceImagesDirectory, $tableColumnsNb, $thumbnailWidth, $thumbnailHeight, $switchClassic=false) {

		$staticPage = ("./" . str_replace(".", "", str_replace("/", "", $referenceImagesDirectory)) . "_bolGalleryStaticPage.html");
		
		// Recreate the gallery if there was any modification
		if((!file_exists($staticPage)) or (filemtime($referenceImagesDirectory) > filemtime($staticPage))) {

			// Builds an array (sorted by date) of image files from given directory
			if (is_dir($referenceImagesDirectory)) { 

				// Create the thumbnails directory if doesn't exist
				if (! is_dir($referenceImagesDirectory."bolGallery")) {
					mkdir($referenceImagesDirectory."bolGallery", 0755);
				}

				// Check the reference images directory (Doesn't scan subdirectories)
				$handle=opendir($referenceImagesDirectory);
				while ($file=readdir($handle)) {

					if (is_file($referenceImagesDirectory.$file)) {

						// Check if the file is an image
						$extension = strtolower(substr(strrchr($file,  "." ), 1));
						$supportedExtensions = array("jpg", "jpeg", "gif", "png");
		
						if (in_array($extension, $supportedExtensions) and ($file[0] != "#")) { // Also checks whether file is marked by a "#"
		
							// Add this file to the image files array
							$imagesList[] = $referenceImagesDirectory.$file; // Should not add $referenceImagesDirectory in the array, could be added later
						}
					}
				}
				closedir($handle);

				// Sort image files array by date with "mtime_sort" method
				// Coders : could enable the user to choose between multiple file sorting
				@usort($imagesList, "mtime_sort") or die("There are no image in <b>" . $referenceImagesDirectory . "</b> to run bolGallery.");

			} else { die("<b>" . $referenceImagesDirectory . "</b> does not exist or is not a valid directory url. Cannot run bolGallery."); }

			// Build gallery
			$HTML = bolGalleryCreate($imagesList, $referenceImagesDirectory, $tableColumnsNb, $thumbnailWidth, $thumbnailHeight, $switchClassic);

			// Bake also bolGallery HTML source output to file
			$session = fopen($staticPage, "w"); // "r+" ?
			fputs($session, "<!-- BolGallery baked HTML page -->\n".$HTML);
			fclose($session);

		}

/* Won't work

		// Load static page (the old one or the last created above)
		require($staticPage) or die("<b>" . $staticPage . "</b> does not exist.");
*/

		$pageString = file_get_contents($staticPage);
		echo $pageString;
}
?>
