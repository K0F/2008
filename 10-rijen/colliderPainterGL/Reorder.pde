

void keyPressed(){
 if(key == 'q'){
  rr.finish();
  println("moive finished");
  exit();
 }
} 
 
class Recorder{
  String dir,name;
  int cntr = 0;

  Recorder(String _dir,String _name){
    dir = _dir;
    name=_name;
  }

  void add(){
    save(dir+"/screen"+nf(cntr,4)+".png");
    cntr++;
  }

  void finish(){
    String Path = sketchPath+"/"+dir;
    try{     
      String bitrate="9000000";//+(((int)(50*25*width*height)/256)*2);
      Runtime.getRuntime().exec("gnome-terminal -x png2vid "+Path+" "+name+" msmpeg4v2 "+bitrate);
      println("finishing");
    }
    catch(java.io.IOException e){
      println(e); 
    }  
  }



}
