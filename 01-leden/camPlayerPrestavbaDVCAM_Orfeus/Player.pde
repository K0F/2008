
////////////////////////////////////////////////////////////////////////////////// Player Class

import JMyron.*;

//////////////////////////////////////////////////////////////////////////////////

class Player{
  JMyron m;
  
  OscP5 oscP5;
NetAddress myRemoteLocation;  
  
  int numX = 45;
  int numY = 36;
  
  String address = "192.168.22.125";//"78.102.53.186";
  int port =12000;
 
  float ratX = width/(numX+2.0);  
  float ratY = height/(numY+2.0);
  
  int rozdil = 0;
  int mez = 15;
  int instr,bnk;
  
  float avgX,avgY;
  float avgTX,avgTY;
  float avgSpeed = 10.0;
  float sX,sY;
  float bes = 0;
  
  int interval = 3;
  
  int channel;
  
  color output;
  
  int[] img = new int[numX*numY];
  int[] img2 = new int[numX*numY];
  boolean[][] net = new boolean[numX][numY]; 
  boolean[][] hraje = new boolean[numX][numY];
  int[][] counter = new int[numX][numY];
  
  boolean prew = false;
  boolean mute = true;

//////////////////////////////////////////////////////////////////////////////////
  
  Player(PApplet _parent,int _tol,int _itvl,int _instr,int _bnk,int _channel){
     ratX=ratX*1.01; //ratio obrazu
    
     
      println("/////////////////////////////////////");
     println("Translator cam->osc for orfeus 1.1 by Krystof Pesek aka Kof\n3.12 2007\nNo copyright!");
     println("\n/////////////////////////////////////");
    println("Ratio : \n"+ratX+":"+ratY);
    for(int y = 0; y < numY;y+=1){
      for(int x = 0; x < numX;x+=1){  
        net[x][y] = true;  
       hraje[x][y] = false; 
        counter[x][y] = 0;
        
        }
    }  
    
  m = new JMyron();//obj
  m.start(numX,numY);//45,36);//320x240
  m.findGlobs(0);
  
  interval = _itvl*10;
  mez = _tol;
  
   oscP5 = new OscP5(_parent,port);
   myRemoteLocation = new NetAddress(address,port);
    
  sX=avgX=width/2.0;
  sY=avgY=height/2.0;
  
 

  
  }//end setup
  
  //////////////////////////////////////////////////////////////////////////////////

  void draw(){
    
     img2 = m.image();     
     m.update();
     img = m.image();    
    
    for(int y = 0; y < numY;y+=1){
      for(int x = 0; x < numX;x+=1){ 
     // output =color(img[y*numX+x]);
        output =color(brightness(img[y*numX+x]));        
                
        if(net[x][y]){
           rozdil = (int)abs(brightness(output)-brightness(img2[y*numX+x])); 
            
            counter[x][y]++;
            
           if(rozdil >= mez){
             //println(x+":"+y+"   ht! - "+counter[x][y]);
             avgTX+=((x*ratX)-avgTX)/avgSpeed;
             avgTY+=((y*ratY)-avgTY)/avgSpeed;
            counter[x][y]=0;
             fill(255);
             rect(x*ratX,y*ratY,ratX,ratY);          
           }
           fill(255);
           text((int)(counter[x][y]/10),(int)(x*ratX+1),(int)(y*ratY+8));
           output =lerpColor(output,#FF0000,0.75);
        }//end if NET
        
          stroke(255,4);         
          fill(output,150);
          line(x*ratX,ratY,x*ratX,height-ratY);
          line(ratX,y*ratY,width-ratX,y*ratY);
          noStroke();
          
         
          
          if(prew){
          rect(x*ratX,y*ratY,ratX,ratY);        
          }
          
      }// end X      
    }//end Y    
    
    sX=avgX;
    sY=avgY;
    
    avgX+=(avgTX-avgX)/avgSpeed;    
    avgY+=(avgTY-avgY)/avgSpeed;
    
    bes += ((abs(avgX-sX)+abs(avgY-sY))-bes) / avgSpeed;
    bes=constrain(bes,0.0,10.0);
    bes=map(bes,0.0,4.0,0.0,1.0);
    //println(bes);
    
    stroke(255,0,0);
    line(0,avgY,width,avgY);
    line(avgX,0,avgX,height);
    
    
    
     if(cp.mute){      
    send("/rush",bes);
    send("/x",avgX);
    send("/y",avgY);
     }
     
    fill(255);
        text("| tol:"+mez+"| itvl:"+interval+"| x:"+numX+"| y:"+numY+"| ch:"+channel+"|",10,7);
  }//end void
  
  //////////////////////////////////////////////////////////////////////////////////
  


//////////////////////////////////////////////////////////////////////////////////

void click(){
 int X = (int)(mouseX/ratX);
 int Y = (int)(mouseY/ratY); 
 
 if((X>=1)&&(X<=numX-1)&&(Y>=1)&&(Y<=numY-1)){
 net[X][Y] = changeState(net[X][Y]);
 
 }
 
}

void send(String name,int what){
  OscMessage myMessage = new OscMessage(name);
  myMessage.add(what);
  oscP5.send(myMessage, myRemoteLocation);   
}

void send(String name,float what){
  OscMessage myMessage = new OscMessage(name);
  myMessage.add(what);
  oscP5.send(myMessage, myRemoteLocation);   
}


  
}//end class

//////////////////////////////////////////////////////////////////////////////////
