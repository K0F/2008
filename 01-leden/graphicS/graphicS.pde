import processing.opengl.*;

String txt = "";
String txt2[];
int odraz = 0;
int q = 1;

void setup(){  
  size(600,1000,OPENGL);
  frameRate(5);
  render();
}

void draw(){
  ;   
}

void mousePressed(){
  odraz = 0;
  q = 1;
  render();  
}

void keyPressed(){
  if(keyCode==ENTER){
    save("print.png");
  } 
  else if(key == ' '){

  }


}

void render(){
  header();
  content(); 
}

void header(){
  String tmp[];
  tmp = loadStrings("text.txt");
  txt = tmp[0];
  textFont(loadFont("Swiss721BT-BlackOutline-45.vlw")); //CenturyGothic-Bold-50
  background(255);
  fill(0,155);
  text(txt,30,50);

  fill(0,3);
  while(q<100){
    q++;
    text(txt,30,50+q*0.5); 
  } 


}



void content(){
  int x = 50;
  txt2 = loadStrings("text.txt");
  fill(0,155);
  textFont(loadFont("00Acrobatix-8.vlw"));
  q=1;
  PImage img;
  PImage msk = loadImage("imgs/mask.png");
  while(q<txt2.length){
    if(!txt2[q].equals("")){
      if(txt2[q].charAt(0)=='@'){
        String tmp[];
        tmp = split(txt2[q],"@ ");
        println(tmp);
        img = loadImage("imgs/"+tmp[1]);
        if(img!=null){

          image(img,x,q*10+120+odraz);
          image(msk,x,q*10+120+odraz);
          odraz += img.height;
        }
        else{
          fill(255,15,15,155);
          text(tmp[1]+" is missing!",x,q*10+120+odraz); 
          fill(0,155);
        }

      }
      else{
        text(txt2[q],x,q*10+120+odraz);

      }
    }
    q++; 


  } 


}






