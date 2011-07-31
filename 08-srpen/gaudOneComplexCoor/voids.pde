void reint(int kolik){  


  snura = new SnuraPhy[0];

  for(int i = 0;i<cr.A.length;i++){
    snura = (SnuraPhy[])expand(snura,snura.length+1);
    snura[snura.length-1] = new SnuraPhy(i, kolik ,
    ps[cr.returnNeighs(i)[0]],
    ps[cr.returnNeighs(i)[1]],
    10.0,10.0,1.0,0.01);
  }

}

void addLev(int A,int B){

  int parA = snura[A].returnLowest();
  int parB = snura[B].returnLowest();
  Particle[] tmp = {
    snura[A].particles[parA],snura[B].particles[parB]        };

  int parents[] = {
    A,B        };

  // println(A+" lowestPoint @ "+parA);
  //   println(B+" lowestPoint @ "+parB);
  //println("2");

  //ps = (Point[])expand(ps,ps.length+2);

  //println("3");

  // ps[ps.length-1] = new Point(snura[A].particles[parA].position().x(),
  //  snura[A].particles[parA].position().y(),
  //  snura[A].particles[parA].position().z(),ps.length-2);


  //  ps[ps.length-2] = new Point(snura[B].particles[parB].position().x(),
  //   snura[B].particles[parB].position().y(),
  //   snura[B].particles[parB].position().z(),ps.length-1);
  //println("4");

  //  SX = (float [])expand(SX,SX.length+2);
  //    SY = (float [])expand(SY,SY.length+2);
  //    SZ = (float [])expand(SZ,SZ.length+2);

  snura = (SnuraPhy[])expand(snura,snura.length+1);
  snura[snura.length-1] = new SnuraPhy(snura.length-1,tmp,
  snura[0].particles.length,
  ps[ps.length-1],ps[ps.length-2],
  10.0,10.0,1.0,0.01);
}
