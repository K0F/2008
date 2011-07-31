// this signal uses the mouseX and mouseY position to build a signal
class KofSynth implements AudioSignal
{

 

  KofSynth(){
    
  }

  /*
  void generate(float[] samp){
   for(int i = 0;i<samp.length;i++){
   samp[i] = random(-1.0,1.0); 
   }
   
   }*/  //noise

  void generate(float[] samp){
    m.update();
    img = m.image();   
    
    for(int y = 0;y<numY;y++){
      for(int x = 0;x<numX;x++){
      samp[y*numX+x] = norm(brightness(img[y*numX+x]),0,255)*2-1.0; 
      }
    }

  }

  /*void generate(float[] samp)
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
   */
  // this is a stricly mono signal
  void generate(float[] left, float[] right)
  {
    generate(left);
    generate(right);
  }
}
