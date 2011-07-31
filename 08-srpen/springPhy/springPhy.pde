import traer.physics.*;

ParticleSystem physics;
Particle[] particles;


void setup(){
  size(400,400,P3D);
  frameRate( 30 );
  ellipseMode( CENTER );
  physics = new ParticleSystem( 5.0, 0.05 );

  particles = new Particle[10];

  particles[0] = physics.makeParticle( 1.0, 50, height/2, 0 );
  particles[particles.length-1] = physics.makeParticle( 1.0, width-50, height/2, 0 );

  for ( int i = 1; i < particles.length; ++i )
  {
    particles[i] = physics.makeParticle( 1.0, lerp(particles[0].position().x(),particles[particles.length-1].position().x(),map(i,1,particles.length-1,0,1)),
    lerp(particles[0].position().y(),particles[particles.length-1].position().y(),map(i,1,particles.length-1,0,1)),
    lerp(particles[0].position().z(),particles[particles.length-1].position().z(),map(i,1,particles.length-1,0,1))  );
    
    physics.makeSpring( particles[i-1],  particles[i], 2.0, 0.1, 0.01 );
  }

  particles[0].makeFixed(); 
  particles[particles.length-1].makeFixed(); 
}

void draw(){
  physics.advanceTime( 1.0 );

  background( 255 );
  noFill();


  beginShape();
  curveVertex( particles[0].position().x(), particles[0].position().y(),particles[0].position().z() );
  for ( int i = 0; i < particles.length; ++i )
  {

    curveVertex( particles[i].position().x(), particles[i].position().y(),particles[i].position().z() );
  }
  curveVertex( particles[particles.length-1].position().x(), particles[particles.length-1].position().y(), particles[particles.length-1].position().z() );
  endShape();
  for ( int i = 0; i < particles.length; ++i )
  {
    pushMatrix();
    translate(particles[i].position().x(), particles[i].position().y(),particles[i].position().z());
    box(3);
    popMatrix();
  }

  pushMatrix();
  translate(particles[0].position().x(),particles[0].position().y(),particles[0].position().z());
  box(10);
  popMatrix();

  pushMatrix();
  translate(particles[particles.length-1].position().x(),particles[particles.length-1].position().y(),particles[particles.length-1].position().z());
  box( 10);
  popMatrix();

}
