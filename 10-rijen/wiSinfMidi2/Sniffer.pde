public class Sniffer extends Thread implements jpcap.PacketReceiver{
  jpcap.NetworkInterface[] devices = jpcap.JpcapCaptor.getDeviceList();
  jpcap.JpcapCaptor j;

  PacketReceiver r;
  String data[] = new String[0];
  int dataB[] = new int[0];
  int len = 300;
  int counter = 0;

  Sniffer(){

    println("found "+devices.length+" usable interfaces!");
    for(int i = 0;i<devices.length;i++){
      println(i+" : "+devices[i].name);
    }

    try{
      j = JpcapCaptor.openDevice(devices[0], len, true, 300);


      // j.setFilter("arp",true);
      //j.loopPacket(-1,this);

    }
    catch(IOException e){
      println(e); 
    } 

  }

  void run(){
    j.loopPacket(-1,this);
  }

  void receivePacket(Packet p){
    //println("got it!");
    //println(p.toString());
    data = (String[])expand(data,data.length+1);
    dataB = (int[])expand(dataB,dataB.length+1);
    viz= (Viz[])expand(viz,viz.length+1);
	counter++;
    if(p.data.length>0){
      //println(p.data.length);
      data[data.length-1] = "";
      dataB[dataB.length-1] = 0;
    for(int i = 0;i<p.data.length;i++){
      if(!((char)p.data[i]+"").equals("\n"))
      data[data.length-1] += (char)p.data[i]+"";
      dataB[dataB.length-1] +=abs((int)p.data[i]);  
    }
	viz[viz.length-1] = new Viz(data[data.length-1]);
    }else{
     data[data.length-1] = p.toString()+""; 
    }
    
    
  }

  void clean(int in){
    data = subset(data,in);
    viz = (Viz[])subset(viz,in);
  }

}


