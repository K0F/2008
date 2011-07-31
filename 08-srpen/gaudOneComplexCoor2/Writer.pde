class Writer{
  SnuraPhy[] base;
  Writer(){
    base=snura;
  }

  void writeToFile(String file){
    base = snura;
    String[] tmp=new String[0];

    for(int i = 0;i<base.length;i++){
      for(int q = 0;q<base[i].particles.length;q++){
        tmp = (String[])expand(tmp,tmp.length+1);
        tmp[tmp.length-1] = (
          i+" "+
          base[i].particles[q].position().x()+" "+
          base[i].particles[q].position().z()+" "+
          -base[i].particles[q].position().y()
          );
      }      
    }
    
    saveStrings(sketchPath+"/data/"+file,tmp);
    println("! saved To File "+file+" successfuly !");   
  }


}
