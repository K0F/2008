
class Point3{
	int id;
	float x,y,z;
	float tx,ty,tz;
	float speed = 10.0;
	float speed2 = 3.0;

	Point3(int _id,float _x,float _y,float _z){
		id=_id;
		tx=x=_x;
		ty=y=_y;
		tz=z=_z;
	}

	void live(){



		//for(int w = 0;w<10;w++){
			int q1 = ((int)random(num));
			float d = dist(x,y,z,o[q1].x,o[q1].y,o[q1].z);
			float dm = map(d,0,trsh/1.5,0,3);


			if(q1!=id){

				if(d<(trsh/1.5)){
					tx -= (o[q1].x-tx)/(speed2*0.9);
					ty -= (o[q1].y-ty)/(speed2*0.9);
					tz -= (o[q1].z-tz)/(speed2*0.9);
					//o[i].tz -= (o[r].z-o[i].tz)/(dd*10.0+1.0);
				}else if(d<trsh){
					tx += (o[q1].x-tx)/speed2;
					ty += (o[q1].y-ty)/speed2;
					tz += (o[q1].z-tz)/speed2;
				}
			}
		//}






		x += (tx-x)/speed;
		y += (ty-y)/speed;
		z += (tz-z)/speed;

		bordr(1);
		draw();


	}

	void bordr(float b){
		if (x>width-b)x=width-b;
		if (y>height-b)y=height-b;
		if (z>width-b)z=width-b;

		if (x<b)x=b;
		if (y<b)y=b;
		if (z<b)z=b;
	}

	void draw(){

		line(x-2,y,z,x+2,y,z);
		line(x,y-2,z,x,y+2,z);
		line(x,y,z-2,x,y,z+2);
	}

}

class Writer{
	String path;
	String name;
	String tmpL[];

	Writer(String _path, String _name){
		path=_path+"";
		name=_name+"";
	}

	void write(){
		String tmp[] = new String[0];
		tmpL = new String[0];
		int cntr = 0;

		for(int i = 0;i<o.length;i++){

			tmp = (String[])expand(tmp,tmp.length+1);
			tmp[tmp.length-1] = "pt ";
			tmp[tmp.length-1] += i+" ";
			tmp[tmp.length-1] += (norm(o[i].x,0,width)*100.0)+" ";
			tmp[tmp.length-1] += (norm(o[i].y,0,height)*100.0)+" ";
			tmp[tmp.length-1] += (norm(o[i].z,0,width)*100.0)+" \r";
			cntr++;
		}

		//int before = 0;
		//int after = 0;

		for(int i = 0;i<num;i++){
			for(int r = 0;r<num;r++){
				if(i!=r){
					float dd = dist(o[i].x,o[i].y,o[i].z,o[r].x,o[r].y,o[r].z);
					if(dd<trsh){
						//before++;
						if(!combination(i,r)){
							//after++;
							tmp = (String[])expand(tmp,tmp.length+1);
							tmpL = (String[])expand(tmpL,tmpL.length+1);
							tmp[tmp.length-1] = "ln "+o[i].id+" "+o[r].id+"\r";
							tmpL[tmpL.length-1] = o[i].id+" "+o[r].id;
						}
					}
				}
			}
		}



		saveStrings(path+"/"+name,tmp);
		println("saved to "+path+"/"+name+"\n :: "+cntr+" points, "+(tmp.length-cntr)+" lines\n");
	}

	boolean combination(int a,int b){

		boolean answer = false;

		for(int i = 0;i<tmpL.length;i++){
			if(tmpL[i].indexOf(b+"")>-1){
				if(tmpL[i].indexOf(a+"")>-1){
					answer = true;
				}
			}
		}

		return answer;

	}



}
