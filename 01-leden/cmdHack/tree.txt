/**
*    ::self-copier by kof * save before run::
*/

String s[];

void setup(){
  size(500,300);

   String commands[] = {"@echo off","cd " +sketchPath,"del tree.txt","type cmdHack.pde >> tree.txt","exit"  };
  saveStrings("cmds.bat",commands);

  link(sketchPath+"/cmds.bat","_new");
  s = loadStrings(sketchPath+"/tree.txt");
  textFont(loadFont("00Automatix-8.vlw"));
  int i =0;
  fill(0,85);
  background(255);
  while(i<s.length){    
    text(s[i],5,12+10*i);
    i++;
  }
  fill(0,155);
  filter(BLUR);
  int q =0;
  while(q<s.length){
    text(s[q],5,10+10*q);
    q++;
  }
}


