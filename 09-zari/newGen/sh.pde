void makeVid(String path,String name){
   String Path = sketchPath+"/"+path;
   try{     String bitrate=""+(((int)(50*25*width*height)/256)*2);
    Runtime.getRuntime().exec("gnome-terminal -x png2vid "+Path+" "+name+" msmpeg4v2 "+bitrate);
    println("finishing");
  }
  catch(java.io.IOException e){
    println(e); 
  }  
}
