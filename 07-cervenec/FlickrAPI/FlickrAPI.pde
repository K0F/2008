import processing.opengl.*;

import proxml.*;

String userName = "girl";
String[] requests = {"portrait"};
String apiKey = "549a31fdf69975d13790c836887b0560";
String nsid = "1fb62b998528c74a";
String url = "http://api.flickr.com/services/rest/";
XMLInOut xml = null;

void init(){
 frame.setUndecorated(true);
 super.init(); 
  
}

void setup() {
  frame.setLocation(0,0);
  size(screen.width,screen.height);
  
  background(0);
  frameRate(30);
  xml = new XMLInOut(this);
} 

void draw() {
} 

int cntr = 0;

void mousePressed() {
  nsid = "";
  //getPublicPhotos(userName);
  //findByUsername(userName);
  if(requests[cntr]!=null){
  search(requests[cntr]);
  }
  cntr++;
}

void search(String _n) {
  String rest = url+"?method=flickr.photos.search";
  rest += "&api_key=" + apiKey;
  rest += "&text=" + _n;
  rest += "&sort=interestingness-desc";
  xml.loadElement(rest);
}

void findByUsername(String _n) {
  String rest = url+"?method=flickr.people.findByUsername";
  rest += "&api_key=" + apiKey;
  rest += "&username=" + _n;
  xml.loadElement(rest);
}

void getPublicPhotos(String _n) {
  String rest = url+"?method=flickr.people.getPublicPhotos";
  rest += "&api_key=" + apiKey;
  rest += "&user_id=" + nsid;
  xml.loadElement(rest);
}

void xmlEvent(XMLElement _x) {
  parseXML(_x);
}

void parseXML(XMLElement _x) {
  String stat = _x.getAttribute("stat");
  if (!stat.equals("ok")) {
    println("Error from Flickr");
    return;
  }
  XMLElement node = _x.getChild(0);
  String type = node.getName();
  if (type.equals("user")) {
    nsid = node.getAttribute("nsid");
    println(nsid);
    getPublicPhotos(nsid);
  }
  else if (type.equals("photos")) {
    int num = node.countChildren();
    println(num);
    getPhotos(node);
  }
}

void getPhotos(XMLElement _n) {
  int cnt = _n.countChildren();
  //cnt = min(cnt,300);
  cnt = 200;
  for (int i=0;i<cnt;i++) {
    XMLElement ph = _n.getChild(i);
    String fm = ph.getAttribute("farm");
    String sv = ph.getAttribute("server");
    String id  = ph.getAttribute("id");
    String sc = ph.getAttribute("secret");
    String imgURL = "http://farm"+fm+".static.flickr.com/"+
      sv + "/" + id + "_" + sc + "_s.jpg";
    PImage img = loadImage(imgURL);
    int x = (i%22) * img.width;
    int y = (i/22) * img.height;
    image(img,x,y);
  }
}
