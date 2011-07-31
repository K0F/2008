int filla = 0;
Recorder r;
Sniffer snif;
int pix[];

void setup(){
  size(96,60,P3D);
  noCursor();  
  textFont(loadFont("AlMohanad-10.vlw"));
  rectMode(CENTER);

  r = new Recorder("print","out5.avi");
  snif = new Sniffer(1);
  snif.start();
  pix = new int[width*height+1];
  background(0);
   loadPixels(); 
}

void draw(){
  
 //
  for(int y =0;y<filla;y++){
    pixels[y] = pix[y];
     
  }
 // updatePixels();
  
}

void drr(byte[] data){
    if(data.length>0){ 
      int begin = filla;
      int end = begin + data.length;
      filla = end;
      
      if(filla>=width*height){
        filla=0;
        r.add();
        background(0);
        pix=new int[width*height];
        //begin=end=0;
      }
      
       for(int i = begin;i<end-1;i++)
      pix[constrain(i,0,pix.length-1)] = color((data[i-begin]>>16)&0xff,(data[i-begin]>>8)&0xff,(data[i-begin])&0xff);    
    //  counter++;
    }
}

void keyPressed(){
  if(key=='q'){
    r.finish();
    exit();
  }

}



