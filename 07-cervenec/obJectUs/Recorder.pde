class Recorder{
  String dir,name;
  int cntr = 0;
  
  int mode = 0; //0=png,1=jpg
  String exte;
  Recorder(String _dir,String _name,int _mode){
    dir = _dir;
    name=_name;
    mode=_mode;
    if(mode==0){
     exte="png"; 
    }else{
     exte="jpg"; 
    }
  }

  void add(){
    save(dir+"/screen"+nf(cntr,4)+"."+exte);
    cntr++;
  }

  void finish(){
    String Path = sketchPath+"/"+dir;
    try{     
      String bitrate="6000000";//+(((int)(50*25*width*height)/256)*2);
      Runtime.getRuntime().exec("gnome-terminal -x "+exte+"2vid "+Path+" "+name+" msmpeg4v2 "+bitrate);
      println("finishing");
    }
    catch(java.io.IOException e){
      println(e); 
    }  
  }



}
