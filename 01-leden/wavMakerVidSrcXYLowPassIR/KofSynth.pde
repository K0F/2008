// this signal uses the mouseX and mouseY position to build a signal
class KofSynth implements AudioSignal
{

 

  KofSynth(){
    ;
  }

  /*
  void generate(float[] samp){
   for(int i = 0;i<samp.length;i++){
   samp[i] = random(-1.0,1.0); 
   }
   
   }*/  //noise


//xy
  void generate(float[] samp){
    m.update();
    img = m.image();   
   
    for(int y = 0;y<numY;y+=1){
      for(int x = 0;x<numX;x+=1){
        
      samp[y*numX+x] = (map(brightness(img[y*numX+x]),255,0,-1.0,1.0));
      
      }
    }
     
  }
  
  //x
   void generateX(float[] samp){
    m.update();
    img = m.image();   
    
    int y = (int)(numY/2.0);
     for(int x = 0;x<numX;x++){
        samp[x] = map(brightness(img[y*numX+x]),0,255,-1.0,1.0); 
     }
      
     
    }
   
   
  void generateXX(float[] samp)
   {
   float range = map(mouseX, 0, width, 0, 1);
   float peaks = map(mouseY, 0, height, 1, 20);
   float inter = float(samp.length) / peaks;
   
   for ( int i = 0; i < samp.length; i += inter )
   {
   for ( int j = 0; j < inter && (i+j) < samp.length; j++ )
   {
   samp[i + j] = map(j, 0, inter, -range, range);
   }
   }
   }
   
  // this is a stricly mono signal
  void generate(float[] left, float[] right)
  {
    generate(left);
    generate(right);
  }
}
