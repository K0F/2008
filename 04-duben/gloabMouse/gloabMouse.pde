PGraphics buff;
float X,Y,XX,YY;

void setup(){
  size(screen.width/4,screen.height/4,P3D);

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

  buff.beginDraw();
  buff.stroke(255,35);
  buff.line(map(X,0,screen.width,0,buff.width),
  map(Y,0,screen.height,0,buff.height),
  map(XX,0,screen.width,0,buff.width),
  map(YY,0,screen.height,0,buff.height));
  buff.endDraw();  

  XX=X;
  YY=Y;



}

void keyPressed(){
  if(keyCode==ENTER){
    buff.save("image.png");
  } 

}




