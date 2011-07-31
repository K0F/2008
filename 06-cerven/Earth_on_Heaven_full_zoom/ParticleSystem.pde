/**
 *	Particle class using a vectors
 *	
 */
class Particle {
  ParticleSystem parent;
  Vector3D loc;
  Vector3D vel;
  Vector3D acc;
  float timer,mapTimer;
  PImage img;
  
  //// scale of particles sparking  //////////////////////// :: >
  float noiseScale = 0.04;
  //// life of particles  //////////////////////// :: >
  float baseTime = 400.0;

  Particle(Vector3D a, Vector3D v, Vector3D l, PImage img_) {
    acc = a.copy();
    vel = v.copy();
    loc = l.copy();
    timer = baseTime;
    img = img_;
  }

  // Another constructor (the one we are using here)
  Particle(ParticleSystem p,Vector3D l,PImage img_) {
    parent = p;
    acc = new Vector3D(0.0,0.0,0.0);
    float x = (float) parent.generator.nextGaussian()*noiseScale;
    float y = (float) parent.generator.nextGaussian()*noiseScale;
    vel = new Vector3D(x,y,0);
    loc = l.copy();
    timer = baseTime;
    img = img_;
  }

  void run() {
    update();
    render();
  }

  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void add_force(Vector3D f) {
    acc.add(f);
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 2.2;
    acc.setXY(0,0);
  }

  // Method to display
  void render() {
    imageMode(CORNER);
    mapTimer = map(timer,0,baseTime,0,130);
    //float a = pow(timer/100.0,0.2)*100.0;
    tint(255-mapTimer,255-mapTimer,255,mapTimer);
    image(img,loc.x-img.width/4,loc.y-img.height/4,img.width/2,img.height/2);
  }

  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles

class ParticleSystem {
   Random generator;
  ArrayList particles;    // An arraylist for all the particles
  Vector3D origin;        // An origin point for where particles are birthed
  PImage img;

  ParticleSystem(int num, Vector3D v, PImage img_) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.copy();                        // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(this,origin, img));    // Add "num" amount of particles to the arraylist
    }
    //// create random generator //////////////////////// :: >
    generator = new Random();//
  }

  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.run();
      if (p.dead()) {
        particles.remove(i);
      }
    }
  }

  // Method to add a force vector to all particles currently in the system
  void add_force(Vector3D dir) {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.add_force(dir);
    }

  }

  void addParticle() {
    particles.add(new Particle(this,origin,img));
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }

}


/**
 *	Vector class holding basic vector operations
 */
public class Vector3D {
  public float x;
  public float y;
  public float z;

  Vector3D(float x_, float y_, float z_) {
    x = x_; 
    y = y_; 
    z = z_;
  }

  Vector3D(float x_, float y_) {
    x = x_; 
    y = y_; 
    z = 0f;
  }

  Vector3D() {
    x = 0f; 
    y = 0f; 
    z = 0f;
  }

  void setX(float x_) {
    x = x_;
  }

  void setY(float y_) {
    y = y_;
  }

  void setZ(float z_) {
    z = z_;
  }

  void setXY(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void setXYZ(float x_, float y_, float z_) {
    x = x_;
    y = y_;
    z = z_;
  }

  void setXYZ(Vector3D v) {
    x = v.x;
    y = v.y;
    z = v.z;
  }
  public float magnitude() {
    return (float) Math.sqrt(x*x + y*y + z*z);
  }

  public Vector3D copy() {
    return new Vector3D(x,y,z);
  }

  public Vector3D copy(Vector3D v) {
    return new Vector3D(v.x, v.y,v.z);
  }

  public void add(Vector3D v) {
    x += v.x;
    y += v.y;
    z += v.z;
  }

  public void sub(Vector3D v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
  }

  public void mult(float n) {
    x *= n;
    y *= n;
    z *= n;
  }

  public void div(float n) {
    x /= n;
    y /= n;
    z /= n;
  }

  //public float dot(Vector3D v) {
  //implement DOT product

  // public Vector3D cross(Vector3D v) {
  //implement CROSS product

  public void normalize() {
    float m = magnitude();
    if (m > 0) {
      div(m);
    }
  }

  public void limit(float max) {
    if (magnitude() > max) {
      normalize();
      mult(max);
    }
  }

  public float heading2D() {
    float angle = (float) Math.atan2(-y, x);
    return -1*angle;
  }

  public Vector3D add(Vector3D v1, Vector3D v2) {
    Vector3D v = new Vector3D(v1.x + v2.x,v1.y + v2.y, v1.z + v2.z);
    return v;
  }

  public Vector3D sub(Vector3D v1, Vector3D v2) {
    Vector3D v = new Vector3D(v1.x - v2.x,v1.y - v2.y,v1.z - v2.z);
    return v;
  }

  public Vector3D div(Vector3D v1, float n) {
    Vector3D v = new Vector3D(v1.x/n,v1.y/n,v1.z/n);
    return v;
  }

  public Vector3D mult(Vector3D v1, float n) {
    Vector3D v = new Vector3D(v1.x*n,v1.y*n,v1.z*n);
    return v;
  }

  public float distance (Vector3D v1, Vector3D v2) {
    float dx = v1.x - v2.x;
    float dy = v1.y - v2.y;
    float dz = v1.z - v2.z;
    return (float) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }

}
