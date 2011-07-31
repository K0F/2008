//////////////// res ///////// >
int X = 3*10+4;
int Y = 4;
int siz = 30;
////////////////////////////// >
////////////////////////////// >

boolean on[][];
PImage lux;
int cnt = 1;

void setup(){  
  size(1020,120,P3D);
  //frame.setTitle("luxferosis");
  background(0);
  lux = loadImage("lux.png");
  nulla();
   

}


void draw(){
  background(0);
  for(int x = 0;x<on.length;x++){
    for(int y = 0;y<on[x].length;y++){
      if(on[x][y]){
       tint(#FFFFFF); 
      }else{
       tint(#111111); 
      }
      stroke(0);
      if(over(x,y)&&mousePressed){
        if(mouseButton==LEFT){
       on[x][y] = true; 
        }else{
         on[x][y]=false; 
        }
       //mousePressed = false;
      }
      image(lux,map(x,0,on.length,0,width),map(y,0,on[x].length,0,height),
      width/on.length,height/on[x].length);
    }
  }
  
  if(frameCount%5==0){
   //reset(); 
  }
}

void change(int x,int y){
  on[x][y] = !on[x][y];  
}

boolean over(int x,int y){
  boolean [] answ = {false,false}; 
  boolean answR = false;
    if(mouseX>map(x,0,on.length,0,width)&&mouseX<map(x,0,on.length,0,width)+width/on.length){
      answ[0] = true;
    }
    
     if(mouseY>map(y,0,on[x].length,0,height)&&mouseY<map(y,0,on[x].length,0,height)+height/on[0].length){
      answ[1] = true;
    }    
    
    if(answ[0]&&answ[1]){
     answR = true; 
    }
    
    return answR;
    
}
void reset(){
 on = new boolean[X][Y];

  for(int x = 0;x<on.length;x++){
    for(int y = 0;y<on[x].length;y++){
      if(random(100)>50){
        on[x][y] = false;
      }
      else{
        on[x][y] = true;
      }
    } 

  } 
}

void nulla(){
  on = new boolean[X][Y];

  for(int x = 0;x<on.length;x++){
    for(int y = 0;y<on[x].length;y++){
      on[x][y] = false;
    }
  } 
}

void keyPressed(){
  if(key==' '){
   //save("imgs/grab_"+cnt+".png"); 
   // then i want to save all jpgs to a folder called savedJPG \\
   loadPixels();
   PImage shot = createImage(width,height,RGB);
   shot.pixels = pixels;
   //String title, String ext, String folder, byte[] data, boolean popup
    saveToWeb_saveJPG("test","sketchLux",shot);
   cnt++;
  }else if(keyCode==DELETE){
    nulla();
  }
}

