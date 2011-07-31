
Basnik lyrik;

void setup(){
  size(400,50);
  textFont(createFont("Tahoma",9));
  //Basnik t = new Thread(this);
  lyrik = new Basnik("kevin16");
  
  //lyrik.mluv("hello, ohtravioso, do you hear me?");
}

String word = " ",wordT = " ";

void draw(){
 background(0); 
 fill(255);
 text(word,20,20);
 fill(255,sin((frameCount*0.5f)+1)*255);
 text("_");
}

void keyPressed(){
  //println(keyCode);
  if((keyCode>=65)&&(keyCode<=90)||(keyCode==' ')){
  word += (char)keyCode+"";
  }
  if(keyCode==ENTER){  
    wordT=word+"";
  lyrik.mluv(word); 
   word = " ";
  }else if(keyCode==BACKSPACE){
    if(word.length()>0){
   word=word.substring(0,word.length()-1);
    } 
  }else if(keyCode==UP){
    word=wordT+"";
  }
}
