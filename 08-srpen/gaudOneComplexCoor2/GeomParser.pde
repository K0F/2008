class GeomParser{
  String[] inCoor;
  float x[],y[],z[];
  int A[],B[];
  int cpLn,cpLnE,sloupyLn,vsloupyLn,vsloupyLnE,klenbyLn,sloupyLnE,klenbyLnE;
  float[] cpoint;
  float[] hmotnost;
  boolean soliter[];
   // -----------------------------------------------------  >

  GeomParser(String filename){
    inCoor = loadStrings(sketchPath+"/data/"+filename);
    //println(pocet());

    for(int i = 0;i<inCoor.length;i++){
      if(inCoor[i].equals("sloupy")){
        sloupyLn=i+1;
      }
      if(inCoor[i].equals("klenby")){
        klenbyLn=i+1;
      }
      if(inCoor[i].equals("volne sloupy")){
        vsloupyLn=i+1;
      }
      if(inCoor[i].equals("CenterPoint")){
        cpLn=i+1;
      }


      if(inCoor[i].equals("!sloupy")){
        sloupyLnE=i;
      }
      if(inCoor[i].equals("!klenby")){
        klenbyLnE=i;
      }
      if(inCoor[i].equals("!volne sloupy")){
        vsloupyLnE=i;
      } 
 if(inCoor[i].equals("!CenterPoint")){
        cpLnE=i;
      }          
    }

    println("sloupyLn @ "+sloupyLn+" ... "+sloupyLnE);
    println("klenbyLn @ "+klenbyLn+" ... "+klenbyLnE);

    ////// --------------------------------------------------------- >>
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


    ////// --------------------------------------------------------- >>
    A=new int[0];
    B=new int[0];
    hmotnost = new float[0];
    soliter = new boolean[0];


    for(int i = klenbyLn;i< klenbyLnE;i++){
      String tmp[] = splitTokens(inCoor[i]," ");
      if(tmp.length==3){
      A=(int[])expand(A,A.length+1);
      B=(int[])expand(B,B.length+1);
      hmotnost=(float[])expand(hmotnost,hmotnost.length+1);
      soliter=(boolean[])expand(soliter,soliter.length+1);
      
      A[A.length-1] = parseInt(tmp[0]);      
      B[B.length-1] = parseInt(tmp[1]);   
      hmotnost[hmotnost.length-1] = parseFloat(tmp[2]);
      soliter[soliter.length-1] = true;
      }else{
        A=(int[])expand(A,A.length+1);
      B=(int[])expand(B,B.length+1);
      hmotnost=(float[])expand(hmotnost,hmotnost.length+1);
      soliter=(boolean[])expand(soliter,soliter.length+1);
      
      A[A.length-1] = parseInt(tmp[0]);      
      B[B.length-1] = parseInt(tmp[0]);   
      hmotnost[hmotnost.length-1] = parseFloat(tmp[1]);
      soliter[soliter.length-1] = false;
      }
    }   
    println("klenby red "+A.length);
    
    ////// --------------------------------------------------------- >>
    cpoint = new float[3];
     for(int i = cpLn;i< cpLnE;i++){
      String tmp[] = splitTokens(inCoor[i]," ");
      cpoint[0] = parseFloat(tmp[0]);
      cpoint[1] = parseFloat(tmp[1]);
      cpoint[2] = parseFloat(tmp[2]);
     }
     println(cpoint);
     
     
  }


  float [] getCoordinates(int in){
    float[] tmp = {
      x[in],y[in],z[in]                   };
    return tmp;
  }

  int[] returnNeighs(int in){
    int[] tmp = {
      A[in],B[in]            };
    return tmp;
  }

  float getWeight(int in){
    float a = hmotnost[in]; 
    if(!soliter[in]){
      a = hmotnost[in]*0.5;
    }
    return a;
  }
  
  boolean getSolo(int in){
    boolean ans = true;
    if(in<soliter.length){
      ans = soliter[in]; 
    }
    return ans; 
  }

  int pocetP(){
    return x.length;
  }
  
  int pocetK(){
    return A.length;
  }  
}  
