/**
 *	class which is holding and parsing the data from
 *	gpx files
 *	lons and lats are array of floats - extracted data
 */
class GPSTrack {
  XMLElement xml, points[];
  float lon[], lat[];
  String path;

  GPSTrack (PApplet obj,String _path,String fileName) {
    path=_path;

    //// new GPX file parsing, it needs futher testing  ///////////////////// >>
    xml = new XMLElement(obj,path+"/"+fileName);
    int numSites = xml.getChildCount();
    String[] names = returnField(xml);

    for(int i =0;i<names.length;i++){
      //// structure could be something like a >trk>trkseq>lon,lat //////////////////////// :: >
      if(names[i].equals("trk")){
        XMLElement trk = xml.getChild(i);
        String[] lev2 = returnField(trk);

        for(int q = 0;q<lev2.length;q++){
          if(lev2[q].equals("trkseq")||lev2[q].equals("trkseg")){
            XMLElement trkseq = trk.getChild(q);
            points = trkseq.getChildren();
            break;
          }
        }
      }
    }
    //// create empty arrays //////////////////////// :: >
    lon = new float[points.length];
    lat = new float[points.length];
    //// and fill it with colleced data //////////////////////// :: >
    for (int i = 0; i < points.length; i++) {
      lon[i] = points[i].getFloatAttribute("lon");
      lat[i] = points[i].getFloatAttribute("lat");
    }
  }

  //// returnField is returning a String array of names of layers inside a gpx //////////////////////// :: >
  String[] returnField(XMLElement _tmp){
    String[] names = new String[_tmp.getChildCount()];
    for(int i = 0; i < _tmp.getChildCount(); i++){
      names[i] = _tmp.getChild(i).getName();
    }
    return names;
  }
}
