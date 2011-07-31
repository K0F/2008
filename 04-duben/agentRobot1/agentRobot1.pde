Robot robot;
PGraphics buff;
PImage pix,msk;
float X,Y,XX,YY;
int w = 80;
int h = 80;


void setup(){
  size(screen.width/4,screen.height/4,P3D);
  frame.setTitle("prosim nezavirat!");
  
   try{
    robot = new Robot();
  }
  catch(java.awt.AWTException e){
    println(e);
  }
  
  pix = createImage(w,h,RGB);
  msk = createImage(pix.width,pix.height,RGB);
  
  for(int x = 0;x<msk.width;x++){
    for(int y = 0;y<msk.height;y++){
      msk.pixels[y*msk.width+x]=(color)(map(constrain(dist(msk.width/2,msk.height/2,x,y),0,msk.width*0.33),0,msk.width*0.33,120,0));
    }    
  }
  
  buff = createGraphics(screen.width, screen.height, P3D);
  buff.beginDraw();
  buff.stroke(255);
  buff.background(0);
  buff.endDraw();

  background(0);
  stroke(255);  
}

void draw(){
  
  capturePos();


  image(buff,0,0,width,height);

}

void capturePos(){
  Point mouse;
  mouse = MouseInfo.getPointerInfo().getLocation();
  
  if(frameCount<=1){
    XX=X=mouse.x;
    YY=Y=mouse.y; 
  }

  X=mouse.x;
  Y=mouse.y;
  
  pix = getImage(w,h);
  pix.mask(msk);

  buff.beginDraw();
  buff.stroke(255,35);
  buff.line(map(X,0,screen.width,0,buff.width),
  map(Y,0,screen.height,0,buff.height),
  map(XX,0,screen.width,0,buff.width),
  map(YY,0,screen.height,0,buff.height));
  buff.tint(255,25);
  buff.image(pix,X-pix.width/2,Y-pix.height/2);
  buff.endDraw();  

  XX=X;
  YY=Y;
}

PImage getImage(int w,int h){
  PImage pixs = createImage(w,h,RGB);
  for(int x = 0;x<w;x++){
    for(int y = 0;y<h;y++){
    pixs.pixels[y*pixs.width+x]=(color)(robot.getPixelColor((int)(x+X-pix.width/2),(int)(y+Y-pix.height/2)).getRGB());    
    }
  } 
  return pixs;
}

void keyPressed(){
  if(keyCode==ENTER){
    buff.save("image.png");
  } 
}




