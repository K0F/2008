
 Generator gen;

void setup(){
	size(300,80);
	
	textFont(createFont("OpenSans",9));
	
	gen = new Generator(1000000,20,3,65,91);
	gen.start();
	
	noStroke();
	fill(200);
}

void draw(){
	background(5);
	rect(10,20,map(gen.perct,0,100,0,width-20),5);
	text("generating: "+gen.pocet+" keys\nof length: "+gen.len+" \nwith "+gen.cislic+" numbers per line",10,35);
	text(gen.perct+" %",10,14);	
}

class Generator extends Thread{

	PrintWriter output;
	int len,cislic,mina,maxa,pocet;
	String[] keys;
	float perct = 0.0;
	
	Generator(int _pocet,int _len, int _cislic, int _mina,int _maxa){
		pocet=_pocet;
		len=_len;
		cislic=_cislic;
		mina=_mina;
		maxa=_maxa;
		
		output = createWriter("dictionary.txt");

	}
	
	void run(){
		int gi = 0;
		int kde[] = new int[cislic];
		keys = new String[(int)(pocet/100.0)];
		for(int i =0;i<pocet;i++){
			for(int a = 0;a<cislic;a++){
				kde[a] = (int)random(0,len);
			}			
			for(int q = 0;q<len;q++){
				for(int r = 0;r<cislic;r++){
					if(kde[r]==q){
						output.print((int)random(0,10)+"");
					}else{
						output.print(""+(char)random(mina,maxa));
					}
				}			
			
			}
			output.println("");
			gi++;
			perct = (gi/(pocet+0.0))*100.0;
		}
		
	output.flush();
	output.close();
	exit();
	}
}
