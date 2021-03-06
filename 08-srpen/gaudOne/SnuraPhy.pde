import traer.physics.*;

class SnuraPhy{
  ParticleSystem physics;
  Particle[] particles;
  int pocet = 10;
  Point pts [];
  float sila,pruznost,vule,mass;

  SnuraPhy(int _pocet,Point A,Point B,float _mass, float _sila,float _pruznost,float _vule){
    
    pts = new Point[2];
    pts[0] = A;
    pts[1] = B;
    
    pocet = _pocet;
    mass=_mass;
    sila=_sila;
    pruznost=_pruznost;
    vule = _vule;
    
    reset();
  }
  
  void reset(){    
    
    physics = new ParticleSystem( 5.0, 0.05 );

    particles = new Particle[pocet];
    
    
    particles[0] = physics.makeParticle( 1.0, pts[0].x,pts[0].y,pts[0].z);
    particles[particles.length-1] = physics.makeParticle( 1.0, pts[1].x,pts[1].y,pts[1].z);

    for ( int i = 1; i < particles.length; ++i )
    {
      particles[i] = physics.makeParticle( mass, lerp(particles[0].position().x(),particles[particles.length-1].position().x(),map(i,1,particles.length-1,0,1)),
      lerp(particles[0].position().y(),particles[particles.length-1].position().y(),map(i,1,particles.length-1,0,1)),
      lerp(particles[0].position().z(),particles[particles.length-1].position().z(),map(i,1,particles.length-1,0,1))  );
      // sila, pruznost, vule
      physics.makeSpring( particles[i-1],  particles[i], sila,pruznost,vule );
    }

    particles[0].makeFixed(); 
    particles[particles.length-1].makeFixed(); 
  }
  
  void draw(){
    physics.advanceTime( 1.0 );
    
     noFill();//fill(255,15);
     //stroke(255,180);
    stroke(255,20);
    
  for ( int i = 0; i < particles.length; ++i )
  {
    pushMatrix();
    translate(particles[i].position().x(), particles[i].position().y(),particles[i].position().z());
    box(1);
    popMatrix();
  }
/*
  pushMatrix();
  translate(particles[0].position().x(),particles[0].position().y(),particles[0].position().z());
  box(5);
  popMatrix();

  pushMatrix();
  translate(particles[particles.length-1].position().x(),particles[particles.length-1].position().y(),particles[particles.length-1].position().z());
  box( 5);
  popMatrix();
  */
  noFill();
  stroke(255,66);
  beginShape();
  curveVertex( particles[0].position().x(), particles[0].position().y(),particles[0].position().z() );
  for ( int i = 0; i < particles.length; ++i )
  {
    curveVertex( particles[i].position().x(), particles[i].position().y(),particles[i].position().z() );
  }
  curveVertex( particles[particles.length-1].position().x(), particles[particles.length-1].position().y(), particles[particles.length-1].position().z() );
  endShape();
    
  }




}
