import processing.xml.*;

class GPSTrack {

  int i;
  XMLElement xml, points[];
  float lon[], lat[];

  GPSTrack (PApplet obj, String fileName, String who) {
    xml = new XMLElement(obj,sketchPath+"/persons/"+fileName);

    if(who.equals("maruska")){
      points = xml.getChild(2).getChild(0).getChildren();
    }
    else if(who.equals("ofer")){
      points = xml.getChild(1).getChild(1).getChildren();
    }
    else if(who.equals("cristina")){
      points = xml.getChild(0).getChild(1).getChildren();
    }
    else if(who.equals("bruno")){
      points = xml.getChild(1).getChild(1).getChildren();
    }
    else if(who.equals("krystof")){
      points = xml.getChild(0).getChild(1).getChildren();
    }else if(who.equals("blandine")){
      points = xml.getChild(1).getChild(1).getChildren();
    }
    else{ 
     points = xml.getChild(0).getChild(0).getChildren();
    }


    //println(points.length);
    //println(points[0].getFloatAttribute("lon"));  

    lon = new float[points.length];
    lat = new float[points.length];

    for (i = 0; i < points.length; i++) {
      lon[i] = points[i].getFloatAttribute("lon");
      lat[i] = points[i].getFloatAttribute("lat");
    }//end for 
  }//end const
}
