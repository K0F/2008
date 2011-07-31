/**
 * HTTP Client. 
 * 
 * Starts a network client that connects to a server on port 80,
 * sends an HTTP 1.1 GET request, and prints the results. 
 */

import processing.net.*;
import java.awt.datatransfer.*; 

String addr = "processing.org";

Client c;
String data;
String lastA = "";
int cnt = 0;
int offset = 0;
String[] ss;
float moveY,shift;
boolean moving = false;

void init(){
 frame.setUndecorated(true);
 
super.init(); 
  
}

void setup() {
 // frame.setLocation(0,0);
  frame.setTitle("http hacker");
  size(900,900,P3D);
  
  background(5);
  fill(14,200,0);
  frameRate(30);
  
  textFont(createFont("Tahoma",9));
  textMode(SCREEN);
  
  ss = new String[0];
  
  httpReq(addr);
 
}

void httpReq(String _addr){ 
  
  c = new Client(this, _addr, 80); // Connect to server on port 80
  c.write("GET / HTTP/1.1\n"); // Use the HTTP "GET" command to ask for a Web page
  c.write("Host: "+addr+"\n\n"); // Be polite and say who we are 
  
}

void keyPressed(){
 if(keyCode==ENTER){
   
   
  httpReq(addr);
   
  lastA = addr+"";
  addr="";
 }else if (keyCode==BACKSPACE){
   if(addr.length()>0){
  addr=addr.substring(0,addr.length()-1); 
   }
 }else if(keyCode==UP){
     if(lastA.length()>0){
    addr=lastA+""; 
     }
   }else if(keyCode==DELETE){
     ss = new String[0];
   }else if(keyCode==TAB){
     if(getClipboard().length()>0&&getClipboard().length()<200){
       addr= ""+getClipboard();  
       if(addr.substring(0,7).equals("http://")){
   addr = ""+addr.substring(7,addr.length()); 
  }
    
     }
   }else if(keyCode!=LEFT&&keyCode!=RIGHT){
  addr+=key;
  keyPressed=false;
 } 
  
}

String getClipboard() {
  Transferable t = Toolkit.getDefaultToolkit().getSystemClipboard().getContents(null);
 
  try {
    if (t != null && t.isDataFlavorSupported(DataFlavor.stringFlavor)) {
 
 String text = (String)t.getTransferData(DataFlavor.stringFlavor);
 return text;
 
    }
  }  
  catch (UnsupportedFlavorException e) {
  }  
  catch (IOException e) {
  }
  return null;
} 

void draw() {
  
  
  background(5);
  
  if(focused){
    noFill();
    stroke(155,255,12,127*(sin(frameCount/5.0)+1));
   rect(0,0,width-1,height-1); 
    
  }
  
  if(cnt>0){
    for(int i =0 ;i<ss.length;i++){
      text(ss[i],10,i*9+moveY);
    }
  }
  
  if(moving){
   fill(155,255,10); 
  }else{
   fill(200); 
  }
  
  text(ss.length,width-35,12);
  text("$root >",width-132-addr.length()*4.5,height-10);
  text(addr,width-100-addr.length()*4.5,height-10);  
  text("_");
  
  
  if(abs(moveY-shift)>5){
   moving =true; 
  }else{
   moving = false; 
  }
  
  moveY += (shift-moveY)/30.0;
  shift += 0.3*((height-(ss.length*9))-shift);

  if (c.available() > 0) { // If there's incoming data from the client...
    data = c.readString(); // ...then grab it and print it
    
    int len = splitTokens(data,"\n").length;
    String temp[] = new String[len];
    
    cnt=0;
    for(int i = 0 ;i<len;i++){
      temp[i] = ""+splitTokens(data,"\n")[i];
     cnt++; 
    }
   // println(cnt);
    
    offset = ss.length;
    ss = (String[])expand(ss,ss.length+cnt);
    for(int q = offset;q<ss.length;q++){
    ss[q] = temp[constrain(q-offset,0,cnt-1)];
    }
  }
}

