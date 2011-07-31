PImage [] loadImages(){
  PImage[] temp = new PImage[0];
  String path = sketchPath+"/imgs/";
  File dir = new File(path);
  File[] files = dir.listFiles();
  fileNames = new String[files.length];
  //println(dir.listFiles());


  for( int i=0; i < files.length; i++ ){
    String fileName = files[i].getName();
    fileNames[i] = fileName+"";
    temp = (PImage[])expand(temp,temp.length+1);
    temp[temp.length-1] = loadImage(path+fileName);
    cnt++;

  }// end loop

  return temp;
}// end void

PImage[] monochrome(PImage[] a){
  PImage[] temp = a;
  for(int i = 0;i<temp.length;i++){
    temp[i].filter(GRAY);    
  }

  return temp;

}

PImage[] negative(PImage[] a){
  PImage[] temp = a;
  for(int i = 0;i<temp.length;i++){
    temp[i].filter(INVERT);    
  }

  return temp;
}
