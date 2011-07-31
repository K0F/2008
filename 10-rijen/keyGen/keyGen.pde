/*wep random key-gen by Kof beta 0.65
	wifi key buster ;)
*/

////////////////////////////////////////////
int lengthOfAKey = 20;
int numberOfKeysToGen = 500000;
String outputFile = "noveKlice.txt";
int charIndexA = 97, charIndexB = 122;
//////////////////////////////////////////// >>


Generator g;

void setup(){
  size(200,200);
  println((char)90+"");

  println("keyGen by Kof is now running!");//97..122 a-z
  g=new Generator(lengthOfAKey,numberOfKeysToGen,outputFile,charIndexA,charIndexB);
  background(#ffcc00);
  background(0);
  exit();
}


class Generator{
  String[] keys;
  int len;
  int num;
  String filename;
	int mn,mx;

  Generator(int _len,int _num,String _filename,int _mn,int _mx){
    num=_num;
    len=_len;
    mn=_mn;mx=_mx;
    filename=_filename+"";
    keys = new String[num];
    keys = gen2();
    println(num+" of keys with length of "+len+" chars generated!");
    saveStrings(filename,keys);
    println("saved to file "+filename);    
  }

  String[] gen(){
    String[] temp = new String[num];
    for(int i =0 ;i<num;i++){
      temp[i] = "";
      for(int q =  0;q<len;q++){
        temp[i] += ""+(char)((int)random(mn,mx));    
      }
    }
    
    //temp = (String[])sort(temp);
    
    return temp;
  }
 
 String[] gen2(){
	int pos;

  String temp[] = new String[num];
  for(int i =0 ;i<num;i++){
      if(i%100000==0){
       println(i); 
      }
        pos = (int)random(len);

      temp[i] = "";
      for(int q = 0;q<len;q++){
        if(pos==q){
         temp[i] += ""+(int)random(0,10);        
        }else{
        temp[i] += ""+(char)((int)random(mn,mx));
        }    
      }
      
      
    }
    return temp;
 }  
  
  
  
 } 







