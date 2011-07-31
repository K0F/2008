public class Mirror{

  PhpCom p;
  String request ="";
  String displayPath ="/";
  String pathToScript;
  String scriptFN = "";
  String root;
  String[] childs;
  String[] tour = new String[1];
  String[] textToDisplay;
  String ext  = "";
  PImage img;
  int Dtype;
  PApplet par;
  int level;

  boolean ready = false,displayingText = false;
  
  color[] c ={#000000,#FCFCFC,#FFCC11};
   
  Mirror(PApplet _par,String _pathToScript,String _scriptFN,String _root){
    par=_par;
    pathToScript = _pathToScript;
    scriptFN = _scriptFN;
    img = createImage(1,1,ARGB);
    //-------------------------- New Communicators >>  
    p = new PhpCom(par,pathToScript+scriptFN);
   // I = new PhpCom(par,pathToScript+"image.php");
    
    level=0;
    root = _root;
    tour[0]=""+root;
    p.getData(root);
    childs = p.List;    

  }  

  String getNameOfChild(int _which){
    return childs[_which];
  }  

boolean isItFile(String s){
  boolean bool = false;
  if(s.charAt(0)=='~'){
    bool=true;
  }
  return bool;
}

String cleanFilename(String _fn){
  String fn = "";
  if(isItFile(_fn)){
  for(int i = 1;i<_fn.length();i++){   
    fn+=""+_fn.charAt(i);    
  }
  }else {
  fn=_fn;
  }
  return fn;
}

String getFileExtension(String _fn){
 String[] ext;
 ext = split(_fn,'.');
 //println("ext: "+ext[1]);
  return ext[1];
}

int getDataType(String _ext){
 int bck = 0;
 
 if(_ext.equals("gpx")){
  bck = 1;
 } 
 else if(_ext.equals("txt")){
  bck = 2; 
 }
 
 return bck;
}

}
