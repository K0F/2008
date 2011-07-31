////////////////////////////////////////////////////////////////////////////////// Globalni Funkce

void mousePressed(){
  player.click(); 

  for(int i = 0;i<cp.names.length;i++){
    if(cp.over(i)){
      cp.action(i);
    } 
  }

  mousePressed = false;

}

//////////////////////////////////////////////////////////////////////////////////

void keyPressed(){
  int which = key;
  // println(which);
  if(keyCode==BACKSPACE){
    player.prew=changeState(player.prew);

  }
  else if((which>=49)&&(which<=53)){  
    cp.action(0);
    cp.pre = (int)key-49;
    cp.action(2);  
  }
  else if(which==54){
    cp.action(8);

  }
  else if(which==47){
    cp.action(0);
  }
  else if(which==42){
    cp.action(1);
  }
  else if(which==45){
    cp.action(2);
  } 

  keyPressed=false;


}  

//////////////////////////////////////////////////////////////////////////////////

boolean changeState(boolean _w){
  boolean w = true;
  if (_w) w=false;
  return w;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
