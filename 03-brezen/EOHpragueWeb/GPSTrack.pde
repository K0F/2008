

class GPSTrack {

  int i;
  XMLElement xml, points[];
  float lon[], lat[];
  String path;

  GPSTrack (PApplet obj,String _path, String fileName, String who) {
    path=_path;
    //println(path);
    xml = new XMLElement(obj,path+"/"+fileName);  

    int numSites = xml.getChildCount();

    //// GPX file parsing ///////////////////// >>    
    String[] names = returnField(xml);
   
    for(int i =0;i<names.length;i++){      
      if(names[i].equals("trk")){
        //println("+ -- trk on "+i);
        XMLElement trk = xml.getChild(i);
        String[] lev2 = returnField(trk);
        
        for(int q = 0;q<lev2.length;q++){
          //println(lev2[q]);
          if(lev2[q].equals("trkseq")||lev2[q].equals("trkseg")){
            //println("  + -- trkseq on "+q);
            XMLElement trkseq = trk.getChild(q);
            points = trkseq.getChildren();
            break;             
          }//end if          
        }//end for        
      }//end if     
    }//end for



    lon = new float[points.length];
    lat = new float[points.length];

    for (i = 0; i < points.length; i++) {
      lon[i] = points[i].getFloatAttribute("lon");
      lat[i] = points[i].getFloatAttribute("lat");
    }//end for 
  }//end const

  String[] returnField(XMLElement _tmp){
    String[] names = new String[_tmp.getChildCount()];
    for(int i = 0; i < _tmp.getChildCount(); i++){
      names[i] = _tmp.getChild(i).getName();
    }      
    return names;
  }
}
