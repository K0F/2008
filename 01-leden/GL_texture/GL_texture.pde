
import processing.opengl.*;
import javax.media.opengl.*;
import com.sun.opengl.util.texture.*;  
 
Texture tex;  
 
void setup()  
{  
  size(1200,800, OPENGL);
  try { tex=TextureIO.newTexture(new File(dataPath("manFrom10.png")),true); }
  catch(Exception e) { println(e); }
}  
 
void draw()  
{  
  background(0);
  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;  
  GL gl = pgl.beginGL();  
 
  tex.bind();  
  tex.enable();  
 
  gl.glBegin(GL.GL_QUADS);
  gl.glNormal3f( 0.0f, 0.0f, 1.0f);
  gl.glTexCoord2f(0, 0); gl.glVertex2f(0, 52);
  gl.glTexCoord2f(1, 0); gl.glVertex2f(200, 52);
  gl.glTexCoord2f(1, 1); gl.glVertex2f(200, 0);
  gl.glTexCoord2f(0, 1); gl.glVertex2f(0, 0);
  gl.glEnd();  
 
  tex.disable();  
 
  pgl.endGL();
} 
