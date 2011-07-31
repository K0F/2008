import traer.physics.*;

ParticleSystem physics;
Particle[] particles;

void setup()
{
  size( 400, 400 );
  smooth();
  fill( 0 );
  frameRate( 24 );
  ellipseMode( CENTER );
        
  physics = new ParticleSystem( 5.0, 0.05 );
  
  particles = new Particle[10];
              
  //p = physics.makeParticle( 1.0, width/2, height/2, 0 );
  particles[0] = physics.makeParticle( 1.0, 50, height/2, 0 );
  particles[0].makeFixed(); 
  
  
  
  for ( int i = 1; i < particles.length; ++i )
  {
    int next = constrain(i-1,0,particles.length);
    particles[i] = physics.makeParticle( 1.0, lerp(50,width-50,map(i,1,particles.length-1,0,1)), height/2, 0 );
    physics.makeSpring( particles[i],  particles[next], 2.0, 0.1, 0.01 );
  }
  
  particles[particles.length-1] = physics.makeParticle( 1.0, width-50, height/2, 0 );
  particles[particles.length-1].makeFixed(); 
  
  //particles[particles.length-1].setMass( 5.0 );
}

void draw()
{
  physics.advanceTime( 1.0 );
    
  if ( mousePressed )
  {
    particles[particles.length-1].moveTo( mouseX, mouseY, 0 );
    particles[particles.length-1].velocity().clear();
  }
    
  background( 255 );
  noFill();
  beginShape();
  curveVertex( particles[0].position().x(), particles[0].position().y() );
  for ( int i = 0; i < particles.length; ++i )
  {
    curveVertex( particles[i].position().x(), particles[i].position().y() );
  }
  curveVertex( particles[particles.length-1].position().x(), particles[particles.length-1].position().y() );
  endShape();
  
  ellipse( particles[0].position().x(), particles[0].position().y(), 5, 5 );
  ellipse( particles[particles.length-1].position().x(), particles[particles.length-1].position().y(), 20, 20 );
}

void mouseReleased()
{
  particles[particles.length-1].setVelocity( (mouseX - pmouseX), (mouseY - pmouseY), 0 );
}


