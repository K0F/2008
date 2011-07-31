import proxml.*;

String userName = "amy";
String apiKey = "???";
String nsid = "";
String url = "http://api.flickr.com/services/rest/";
XMLInOut xml = null;

void setup() {
  size(600,600);
  background(0);
  frameRate(15);
  xml = new XMLInOut(this);
} 

void draw() {
} 

void mousePressed() {
  nsid = "";
  findByUsername(userName);
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
  cnt = min(cnt,64);
  for (int i=0;i<cnt;i++) {
    XMLElement ph = _n.getChild(i);
    String fm = ph.getAttribute("farm");
    String sv = ph.getAttribute("server");
    String id  = ph.getAttribute("id");
    String sc = ph.getAttribute("secret");
    String imgURL = "http://farm"+fm+".static.flickr.com/"+
      sv + "/" + id + "_" + sc + "_s.jpg";
    PImage img = loadImage(imgURL);
    int x = (i%8) * img.width;
    int y = (i/8) * img.height;
    image(img,x,y);
  }
}
