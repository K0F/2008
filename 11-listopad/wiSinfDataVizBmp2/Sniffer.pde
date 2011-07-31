public class Sniffer extends Thread implements jpcap.PacketReceiver{
  jpcap.NetworkInterface[] devices = jpcap.JpcapCaptor.getDeviceList();
  jpcap.JpcapCaptor j;

  PacketReceiver r;
  int len;
  int counter = 0;

  Sniffer(int id){

    println("found "+devices.length+" usable interfaces! ..using "+id);
    for(int i = 0;i<devices.length;i++){
      println(i+" : "+devices[i].name);
    }

    try{
      len = width;
      j = JpcapCaptor.openDevice(devices[id], len, true, len+1);
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
    //println(p.data.length);
    drr(p.data);
  }

}




