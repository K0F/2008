import processing.opengl.*;
PImage racek,racek2;
Dav dav;
String slova[];
int which;

void setup(){

	size(1024,768,P3D);

	dav = new Dav();
	textFont(createFont("Arial",15));
	racek = loadImage("racek.png");
	racek2 = loadImage("racek.png");
	for (int i = 0; i < 40; i++) {
		dav.addPtak(new Ptak(new Vector3D(random(width),
		                                  random(height)),lerpColor((85),(255),norm(random(0,255),0,255)),i));
	}

	frame.setTitle(" > < > < : R");
	slova = loadStrings(sketchPath+"/BirdsKof.pde");
	println("setted!");
	background(0);
}


void draw(){
	//fill(0,5);
	//rect(0,0,width,height);
	noFill();

	dav.run();

	if(frameCount%200==0){
		tex();
	}
}

void mousePressed() {
	fill(0,50);
	rect(0,0,width,height);
	dav.addPtak(new Ptak(new Vector3D(mouseX,mouseY),
	                     (#FFFFCC11),dav.ptaci.size()+1));
}

void tex(){
	float X = random(-20,width+20);
	float Y = random(-20,height+20);
	which = (int)random(slova.length);
	fill(0,50);
	rect(0,0,width,height);
	fill(lerpColor(#ffcc00,#ffffff,map(which,0,slova.length,0.0f,1.0f)),125);
	text(slova[which],X,Y);

}



class Dav{
	ArrayList ptaci;

	Dav(){
		ptaci = new ArrayList();
	}

	void run(){

		for(int i = 0;i< ptaci.size();i++){
			Ptak p = (Ptak)ptaci.get(i);
			p.run(ptaci);
		}

	}

	void addPtak(Ptak b) {
		ptaci.add(b);
	}
}

class Ptak{
	float r = 3.0f;
	float maxforce = 0.09f;    // Maximum steering force
	float maxspeed = 2.0f;
	int id;
	int cyklus, time, delka;
	color c;

	float sep = 120;
	float align = 25;
	float coh = 180;

	Vector3D loc;
	Vector3D vel;
	Vector3D acc;


	Ptak(Vector3D _l,color _c,int _id){
		acc = new Vector3D(0,0);
		vel = new Vector3D(random(-1,1),random(-1,1));
		loc = _l.copy();
		//cyklus = 60;//(int)random(65,250);
		cyklus = (int)random(20,80);
		delka = cyklus/2;
		time = (int)random(cyklus);
		c=_c;
		id=_id;

		sep += random(-50,50);
		align += random(-5,5);
		coh += random(-50,50);
	}

	void run(ArrayList ptaci) {
		time++;

		flock(ptaci);
		update();
		borders();
		render();
	}

	void flock(ArrayList ptaci) {
		Vector3D sep = separate(ptaci);   // Separation
		Vector3D ali = align(ptaci);      // Alignment
		Vector3D coh = cohesion(ptaci);   // Cohesion
		// Arbitrarily weight these forces
		sep.mult((sin(time/(cyklus*10+1.0f))+1)*2.5f);
		ali.mult((sin((time+20)/(cyklus*20+1.0f))+1)*1.0f);
		coh.mult((sin((time+13)/(cyklus*30+1.0f))+1)*0.5f);
		// Add the force vectors to acceleration
		acc.add(sep);
		acc.add(ali);
		acc.add(coh);

	}

	void update(){
		vel.add(acc);
		vel.limit(maxspeed);
		loc.add(vel);
		acc.setXYZ(0,0,0);
	}

	void borders(){
		if (loc.x < -r) loc.x = width+r;
		if (loc.y < -r) loc.y = height+r;
		if (loc.x > width+r) loc.x = -r;
		if (loc.y > height+r) loc.y = -r;
	}

	void render2(){
		float theta = vel.heading2D() + radians(90);
		noFill();
		stroke(c,85);
		pushMatrix();
		translate(loc.x,loc.y);
		line(0,0,acc.x*50,acc.y*50);
		rotate(theta);
		beginShape(TRIANGLES);
		vertex(0, -r*2);
		vertex(-r, r*2);
		vertex(r, r*2);
		endShape();
		popMatrix();
	}

	void render(){
		float theta = vel.heading2D() + radians(90);
		noFill();
		noStroke();
		pushMatrix();
		translate(loc.x,loc.y);
		rotate(theta);
		tint(c,85);
		if(time%cyklus<delka){
			image(racek2,-racek.width/8.0f,-racek.height/8.0f,racek.width/4.0f,racek.height/4.0f);
		}else{
			image(racek,-racek.width/8.0f,-racek.height/8.0f,racek.width/4.0f,racek.height/4.0f);
		}
		popMatrix();
	}

	void seek(Vector3D target) {
		acc.add(steer(target,false));
	}

	void arrive(Vector3D target) {
		acc.add(steer(target,true));
	}

	Vector3D separate (ArrayList ptaci) {
		float desiredseparation = sep;
		Vector3D sum = new Vector3D(0,0,0);
		int count = 0;
		// For every Ptak in the system, check if it's too close
		for (int i = 0 ; i < ptaci.size(); i++) {
			Ptak other = (Ptak) ptaci.get(i);
			float d = loc.distance(loc,other.loc);
			// If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
			if ((d > 0) && (d < desiredseparation)) {
				// Calculate vector pointing away from neighbor
				Vector3D diff = loc.sub(loc,other.loc);
				diff.normalize();
				diff.div(d);        // Weight by distance
				sum.add(diff);
				count++;            // Keep track of how many
			}
		}
		// Average -- divide by how many
		if (count > 0) {
			sum.div((float)count);
		}
		return sum;
	}

	Vector3D align (ArrayList ptaci) {
		float neighbordist = align;
		Vector3D sum = new Vector3D(0,0,0);
		int count = 0;
		for (int i = 0 ; i < ptaci.size(); i++) {
			Ptak other = (Ptak) ptaci.get(i);
			float d = loc.distance(loc,other.loc);
			if ((d > 0) && (d < neighbordist)) {
				sum.add(other.vel);
				count++;
			}
		}
		if (count > 0) {
			sum.div((float)count);
			sum.limit(maxforce);
		}
		return sum;
	}

	// Cohesion
	// For the average location (i.e. center) of all nearby ptaci, calculate steering vector towards that location
	Vector3D cohesion (ArrayList ptaci) {
		float neighbordist = coh;
		Vector3D sum = new Vector3D(0,0,0);   // Start with empty vector to accumulate all locations
		int count = 0;
		for (int i = 0 ; i < ptaci.size(); i++) {
			Ptak other = (Ptak) ptaci.get(i);
			float d = loc.distance(loc,other.loc);
			if ((d > 0) && (d < neighbordist)) {
				sum.add(other.loc); // Add location
				count++;
			}
		}
		if (count > 0) {
			sum.div((float)count);
			return steer(sum,false);  // Steer towards the location
		}
		return sum;
	}


	Vector3D steer(Vector3D target, boolean slowdown) {
		Vector3D steer;  // The steering vector
		Vector3D desired = target.sub(target,loc);  // A vector pointing from the location to the target
		float d = desired.magnitude(); // Distance from the target is the magnitude of the vector
		// If the distance is greater than 0, calc steering (otherwise return zero vector)
		if (d > 0) {
			// Normalize desired
			desired.normalize();
			// Two options for desired vector magnitude (1 -- based on distance, 2 -- maxspeed)
			if ((slowdown) && (d < 100.0f)) desired.mult(maxspeed*(d/100.0f)); // This damping is somewhat arbitrary
			else desired.mult(maxspeed);
			// Steering = Desired minus Velocity
			steer = target.sub(desired,vel);
			steer.limit(maxforce);  // Limit to maximum steering force
		} else {
			steer = new Vector3D(0,0);
		}
		return steer;
	}




}
