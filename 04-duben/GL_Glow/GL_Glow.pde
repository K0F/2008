import processing.opengl.*;  

PGraphicsOpenGL pgl;
GL gl;  

void setup() {  
  size(400,400,OPENGL); 
  PImage glowTexture = loadImage( "glowTexture.png" ); 
}  

void draw() {  
  gl.beginGL();

  gl.glEnable( GL.GL_TEXTURE_2D );
  gl.bindTexture( glowTexture );

  gl.glBegin(GL.GL_POLYGON);
  gl.glTexCoord2f(0, 0);
  gl.glVertex2f(-0.5f, -0.5f);
  gl.glTexCoord2f(1, 0);    
  gl.glVertex2f( 0.5f, -0.5f);
  gl.glTexCoord2f(1, 1);    
  gl.glVertex2f( 0.5f,  0.5f);
  gl.glTexCoord2f(0, 1);    
  gl.glVertex2f(-0.5f, 0.5f);
  gl.glEnd();

  gl.endGL(); 

}  




