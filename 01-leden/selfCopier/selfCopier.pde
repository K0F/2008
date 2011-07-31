/**
 *  ::YouAreNowLookingAtTheCodeWhichGeneratesThisPicture::
 *              ::code-self-copier by kof * save before run::
 */

String s[];

void setup(){  
  String commands[] = {
    "@echo off","cd " +sketchPath,"del tmp.txt","type "+
      parseName(sketchPath)+".pde > tmp.txt","exit"
  };
  saveStrings("cmds.bat",commands);
  link(sketchPath+"/cmds.bat");
  s = loadStrings(sketchPath+"/tmp.txt");

  size(300,s.length*10+10); //!

  textFont(loadFont("Uni0553-8.vlw"));
  int i =0;
  fill(0,45);
  background(255);
  while(i<s.length){    
    text(s[i],5,12+10*i);
    i++;
  }
  filter(BLUR);
  int q =0;
  fill(0,155);
  while(q<s.length){
    text(s[q],5,10+10*q);
    q++;
  }
  save("me.png");
}

String parseName(String path){
  String[] tmp = split(path,'\\');
  return tmp[tmp.length-1];
}

// hehe
