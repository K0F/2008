import processing.xml.*;

class XMLParser {

  int i;
  XMLElement xml, Body[], Cells[];
  float xes[], yes[],zes[];
  float data[];
  
  XMLParser (PApplet obj, String fileName) {
    println("loading "+fileName);
    xml = new XMLElement(obj,sketchPath+"/data/"+fileName);
    Body = xml.getChild(4).getChild(0).getChildren();
    
    data = new float[Body.length*3];
    int g = 0;
    
    for(int b = 0;b<Body.length;b++){
      for(int dim = 0;dim<=2;dim++){
        data[g] = parseFloat(Body[b].getChild(dim).getChild(0).getContent());
        g++;
      }
    }
    
    println("num of pnts. = "+Body.length);
   // println(data);
  
    xes = new float[Body.length];
    yes = new float[Body.length];
    zes = new float[Body.length];

    for (i = 0; i <xes.length; i++) {
      xes[i] = data[i*3];
      yes[i] = -data[i*3+2];
      zes[i] = data[i*3+1];
      // data X,data Y = -Z,data Z = Y;
    }//end for
    //println(xes);    
  }//end const
  
  float[] getPointDimensions(int in){
    in = constrain(in,0,Body.length);
    float[] answr = {xes[in],yes[in],zes[in]};
    return answr;
  }
  
  int pocet(){
    return Body.length;
  }
  
}
