Recorder r;

void setup(){
  size(screen.width/2,screen.height/2);
  smooth();
  background(0);
  r= new Recorder("vids","one");

}


void draw(){
  fill(random(0,25),random(0,25),random(0,25),5);
  rect(0,0,width,height);
  stroke(255,55);
  for(int i = 0;i<(int)random(1,500);i++){
    line(0,random(height),width,random(height));
  }
  r.add();
}

void keyPressed(){
  if(key == 'q'){
    r.finish();
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
      String bitrate=""+(((int)(50*25*width*height)/256)*2);
      Runtime.getRuntime().exec("gnome-terminal -x png2vid "+Path+" "+name+" msmpeg4v2 "+bitrate);
      println("finishing");
    }
    catch(java.io.IOException e){
      println(e); 
    }  
  }



}

