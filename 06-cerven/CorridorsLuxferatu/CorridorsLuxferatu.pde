import interfascia.*;

GUIController c;
IFTextField t;
IFLabel l,popis;

boolean hide = false;


//////////////// res ///////// >
int X = 9*10+4;
int Y = 4;
int siz = 15;
////////////////////////////// >
////////////////////////////// >

String NAME = "user";

boolean on[][];
PImage lux;
int cnt = 1;
boolean sending = false;

void setup(){  
  size(X*siz,Y*siz);
  //frame.setTitle("luxferosis");
  background(0);
  frame.setTitle("corridors luxfer contest");
  lux = loadImage("lux.png");
  nulla();
  
  textFont(createFont("Arial",9));
  textMode(SCREEN);
  
  c = new GUIController(this);
  t = new IFTextField("Text Field", 25, 30, 350);
  l = new IFLabel("zadejte sve jmeno", 10, 5);
  popis = new IFLabel("navod:\n po zadani jmena strisknete ENTER\n levy klik mysi vyplnujte luxfery pravym mazte\n pro kompletni vymaz talcitko DELETE\n pro odeslani na server MEZERNIK \n galerie na adrese weirdplace.wz.cz", 400, 5);
  c.add(l);
  c.add(t);
  c.add(popis);
  

  t.addActionListener(this);
}

void actionPerformed(GUIEvent e) {
  if (e.getMessage().equals("Completed")) {    
    NAME = ""+(t.getValue());
    t.setValue("");
    t.setX(width+3);
    l.setX(width+5);
    popis.setX(width+5);
    hide = true;
  }
}

void draw(){
  if(!hide){
    background(255);
    fill(255);
    text("type your name please",100,10);
    
  }else{
  
  if(!sending){
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
  }
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
  if(key==' '&&hide){
    fill(#00FF00);
    
   savePicture(); 
   cnt++;
   nulla();
  }else if(keyCode==DELETE){
    nulla();
  }
}

void savePicture(){
  
  String da,mo,ye,ho,mi,se;    
    if((int)day()<10){da="0"+(int)day();}else{da=""+(int)day();}
    if((int)month()<10){mo="0"+(int)month();}else{mo=""+(int)month();}
    ye=""+(int)year();
    if((int)hour()<10){ho="0"+(int)hour();}else{ho=""+(int)hour();}
    if((int)minute()<10){mi="0"+(int)minute();}else{mi=""+(int)minute();}
    if((int)second()<10){se="0"+(int)second();}else{se=""+(int)second();}
 
  String name = NAME+"_lux"+cnt+"-"+da+"_"+mo+"_"+ye+"_"+ho+"_"+mi+".png";
  
    PGraphics img = createGraphics(width,height+12,P3D);
    loadPixels();
    
    
    for(int i = 0;i<img.pixels.length;i++){
     img.pixels[i] = color(0); 
    }
    
    for(int i = 0;i<pixels.length;i++){
     img.pixels[i] = pixels[i]; 
    }
    
    
    
    img.beginDraw();
    img.textFont(createFont("Arial",9));
    img.textMode(SCREEN);
    img.text("author : "+NAME+"   "+da+"/"+mo+"   "+ye+"   time: "+ho+":"+mi+":"+se,5,img.height-2);
    img.endDraw();
    
   img.save("imgs/"+name);
   putFile("weirdplace.wz.cz","weirdplace.wz.cz","cigareta","imgs","luxfera",name); 

}


