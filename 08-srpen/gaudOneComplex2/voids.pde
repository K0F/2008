void reint(int kolik){  
  sura = new SnuraPhy[ps.length];
  for(int i =0;i<sura.length;i++){
    sura[i] = new SnuraPhy(i, kolik , ps[i],ps[(i+1)%(ps.length-1)] ,10.0,10.0,1.0,0.01);
  }  
}

void addLev(int A,int B){
 
   int parA = sura[A].returnLowest();
    int parB = sura[B].returnLowest();
    Particle[] tmp = {sura[A].particles[parA],sura[B].particles[parB]};
    
    int parents[] = {A,B};
    
    println(A+" lowestPoint @ "+parA);
    println(B+" lowestPoint @ "+parB);
    //println("2");
    
    //ps = (Point[])expand(ps,ps.length+2);
    
    //println("3");
    
   // ps[ps.length-1] = new Point(sura[A].particles[parA].position().x(),
  //  sura[A].particles[parA].position().y(),
  //  sura[A].particles[parA].position().z(),ps.length-2);
    
    
  //  ps[ps.length-2] = new Point(sura[B].particles[parB].position().x(),
 //   sura[B].particles[parB].position().y(),
 //   sura[B].particles[parB].position().z(),ps.length-1);
    //println("4");
    
  //  SX = (float [])expand(SX,SX.length+2);
//    SY = (float [])expand(SY,SY.length+2);
//    SZ = (float [])expand(SZ,SZ.length+2);
    
    sura = (SnuraPhy[])expand(sura,sura.length+1);
    sura[sura.length-1] = new SnuraPhy(sura.length-1,tmp,sura[0].particles.length , ps[ps.length-1],ps[ps.length-2] ,10.0,10.0,1.0,0.01);
}
