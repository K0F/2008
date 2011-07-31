Samplere s;

void setup(){
  size(300,200);

  s = new Samplere(this,1); 

}


void draw(){
  background(0);
  s.run();
}

void keyPressed(){
 if(key == ' '){
  s.record();
 } 
}

void stop()
{
  // always close Minim audio classes when you are done with them
  s.in.close();
  if ( s.player != null )
  {
    s.player.close();
  }
  super.stop();
}
