

void setup(){
  size(400,300);
  run("cd ../..");
  
}

void draw(){


}

void mousePressed(){
  run(new String[]{
    "i:","cd dow*","cd [p*","mp *"  }
  );   
}

void run(String a){
   try{
    Runtime.getRuntime().exec("cmd /C "+a);
  }
  catch(java.io.IOException e){
    println(e); 
  }
 
  
}
void run(String[] a) {
  String q = "";
  for(int i = 0;i<a.length;i++){
    if(i!=a.length-1){
      q+=a[i]+"&"; 
    }
    else{
      q+=a[i]+"\r"; 
    }
  }
  try{
    Runtime.getRuntime().exec("cmd /C "+q);
  }
  catch(java.io.IOException e){
    println(e); 
  }
}
/*

 void mousePressed(){
 open(
 "i:&"+
 "cd ../../../..&"+
 "cd down&"+
 "cd [p*&"+
 "mp *&"+
 "\n"
 );   
 
 }*/
