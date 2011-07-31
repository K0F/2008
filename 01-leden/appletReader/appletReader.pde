String txt[];
float y;
String[] mesic = {"+---01-leden","+---02-unor","+---03-brezen","+---04-duben","+---05-kveten",
                          "+---06-cerven","+---07-cervenec","+---08-kveten","+---09-zari","+---10-rijen","+---11-listopad","+---12-prosinec"};
color cols[];

void setup(){  
  size(200,500);
  
  
  textFont(loadFont("00Acrobatix-8.vlw"));
  txt=loadStrings("http://weirdplace.wz.cz/tree.txt");//("./tree.txt");
 cols = new color[mesic.length];
 for(int i = 0;i<cols.length;i++){
   if(i%2==0){
  cols[i] = color(200) ;
   }else{
     cols[i] = color(#FFCC00);
   }
   
 }
 
 background(0);
 fill(255);
 
 for(int i =3;i<txt.length;i++){
  text(txt[i],5,i*9); 
 }
}

void draw(){
  background(0);
 y+=(map(mouseY,0,height,0,-txt.length*9)-y) / 5.0f;
 pushMatrix();
  translate(0,y);
 for(int i =3;i<txt.length;i++){
   for(int q = 0;q<mesic.length;q++){
   if(mesic[q].equals(txt[i])){
     fill(cols[q]);
     
    }
   }
   
  text(txt[i],5,i*9); 
 }
 
 popMatrix();
 stroke(255);
 line(width-10,map(y,0,-txt.length*9,0,height),width,map(y,0,-txt.length*9,0,height));   
}
