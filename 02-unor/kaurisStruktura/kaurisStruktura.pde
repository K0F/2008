FasterMovie fm;
PImage mImage;

void setup ()
{

  size(screen.width,200,P3D);
  frameRate(25);


  fm = new FasterMovie(this, sketchPath+"/data/dusk-00.mov", false);
  fm.loop();  
  background(0);


}
void init(){
  this.frame.setUndecorated(true);
  frame.setLocation(0,0);
  super.init(); 

}
boolean first = true;
boolean odd = false;
int i = 0;

void draw ()
{  
  if(first){
    fm.jump(0.0);
    first=false; 
  }
  i++;
  if(i>width){
    save("kaurismaki.png"); 
  }
  
    odd=!odd;
  fm.jump(map(i,0,width,0,30*60.0));
  //image( fm, 0,0, width, height );
  if ( mImage != null ){
    PImage msk = mImage;
    
    if(odd){
      msk.filter(THRESHOLD,.5);   
      
      mImage.mask(mImage);
      mImage.filter(OPAQUE);
      PImage fin = mImage;
      image(fin,i,0,fm.width*norm(height,0,fm.height),height);
  
  }else{
    tint(255,5);
    image(mImage,i,0,fm.width*norm(height,0,fm.height),height);
    noTint();
  }
    //line(i,0,i,height);


  }

}

void movieImageAvailable ( PImage _movieImage )
{
  mImage = _movieImage;
}
