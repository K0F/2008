class CoorParser{
  String[] inCoor;
  float x[],y[],z[];
  int A[],B[];
  int sloupyLn,klenbyLn,sloupyLnE,klenbyLnE;

  CoorParser(String filename){
    inCoor = loadStrings(sketchPath+"/data/"+filename);
    //println(pocet());

    for(int i = 0;i<inCoor.length;i++){
      if(inCoor[i].equals("sloupy")){
        sloupyLn=i+1;
      }

      if(inCoor[i].equals("klenby")){
        klenbyLn=i+1;
      }
      if(inCoor[i].equals("!sloupy")){
        sloupyLnE=i;
      }

      if(inCoor[i].equals("!klenby")){
        klenbyLnE=i;
      }      
    }

    println("sloupyLn @ "+sloupyLn+" ... "+sloupyLnE);
    println("klenbyLn @ "+klenbyLn+" ... "+klenbyLnE);

    x = new float[0];
    y = new float[0];
    z = new float[0];


    for(int i = sloupyLn;i<sloupyLnE;i++){
      String tmp[] = splitTokens(inCoor[i]," ");
      x=(float[])expand(x,x.length+1);
      y=(float[])expand(y,y.length+1);
      z=(float[])expand(z,z.length+1);
      x[x.length-1] = parseFloat(tmp[1]);
      y[y.length-1] = -parseFloat(tmp[3]);
      z[z.length-1] = parseFloat(tmp[2]);      

    }
    println("coordinates red "+x.length);

    A=new int[0];
    B=new int[0];


    for(int i = klenbyLn;i< klenbyLnE;i++){
      String tmp[] = splitTokens(inCoor[i]," ");
      A=(int[])expand(A,A.length+1);
      B=(int[])expand(B,B.length+1);

      A[A.length-1] = parseInt(tmp[1]);      
      B[B.length-1] = parseInt(tmp[2]);   
    }   

    println("klenby red "+A.length);

  }


  float [] getCoordinates(int in){
    float[] tmp = {
      x[in],y[in],z[in]           };
    return tmp;
  }

  int[] returnNeighs(int in){
    int[] tmp = {
      A[in],B[in]    };
    return tmp;
  }

  int pocetP(){
    return x.length;
  }

  int pocetK(){
    return A.length;
  }  
}  
