PGraphics a;
String tt;

int w = 720;
int h = 576;

float CHARW = 5.2;
int CHARH = 8;

int mina = 65,maxa = 91; //0...9 - 48-58; a...z - 97-123; A...Z - 65-91;
color A = #ffFFFF;
color B = #FFFFFF;
int aA = 200;
int aB = 100;

int totalfind = 0;

String keyword = "YES";


void setup(){
  w=screen.width;h=screen.height;  
  size(w,h);
  
  
  
  println("completeCharsetInUse: ");
  for(int i = mina;i<maxa;i++){
    print((char)i); 
  }
  println(" ");
  
  generate();
  
}

void generate(){
 
  
  a=null;
  a = createGraphics(width,height,JAVA2D);

  a.beginDraw();
  a.textFont(createFont("Tahoma",9));
  a.textAlign(LEFT);


  for(int i = 10;i<height-9;i+=CHARH){
    tt=""+(char)random(mina,maxa);
    
     for(int e = 0;e<width/CHARW;e++){
      tt+=(char)random(mina,maxa);     
    }    
    
    boolean found = false;
    boolean coloring = false;
    int[] res = new int[0];
    int len = 0, hold = 0;
    
    if(search(tt).length>0){ 
      found = true;
      len = search(tt).length;  
     res = new int[len];
     for(int q = 0;q<len;q++){
      res[q] = search(tt)[q]; 
      totalfind++;
     }
    }
    
    if(found&&res[0]==0){
     a.fill(A,aA); 
      }else{
       a.fill(B,aB); 
      }     
    
    a.text(tt.charAt(0),10,i);
    
    
    int gi = 1;
    int numero = 0;
    int nabito = 0;
    
    for(int e = 1;e<width/CHARW;e++){
      
      if(found){
        if(gi==res[numero]){
         coloring = true;         
        }
        
        if(gi>res[numero]+keyword.length()-1){
         
         coloring = false; 
         if(len-1>numero){
         numero++;
         }
        
        
        }
        
      }

      if(coloring){
       a.fill(A,aA); 
      }else{
       a.fill(B,aB); 
      }      
      
      a.text(tt.charAt(gi)); 
      gi++;
      
    }


    //a.fill(random(25,255),115);


  }
  a.endDraw();
  println("total matches: "+totalfind);
  a.save("test.png");
  println("saved"); 
  background(0);
  image(a,0,0); 
  
}

void draw(){
  ;
  
}


void mousePressed(){
 if(key==' '){
  generate();
 } else if(keyCode==ENTER){
   a.save("test.png");
  println("saved"); 
   exit();
 }
 keyPressed=false;
  
}


int[] search(String in){ 
      int[] answ = new int[0];
      int cnt = 0;
      if(keyword.length()<=in.length()){
        for(int s =0;s<in.length()-keyword.length();s++){     
              if(in.substring(s,s+keyword.length()).equals(keyword)){
               answ = (int[])expand(answ,answ.length+1);
               answ[answ.length-1] = s;
               //println("heureka @ "+answ[answ.length-1]+"  "+in.substring(s,s+keyword.length()));
               
              }
            }   
      }  
      
           return answ; 
}


