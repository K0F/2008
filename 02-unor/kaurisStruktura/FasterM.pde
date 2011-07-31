// nice work, originally from Daniel Oberhoff:
// http://danieloberhoff.de/processing/FasterMovie.pde
// posted here:
// http://processing.org/discourse/yabb_beta/YaBB.cgi?board=os_core_pde;action=display;num=1175633922
// another update, fixed the loop bug, now again at:
// http://danieloberhoff.de/processing/FasterMovie.pde

import quicktime.*;
import quicktime.qd.*;
import quicktime.std.*;
import quicktime.app.view.*;
import quicktime.io.*;
import quicktime.std.movies.*;
import quicktime.std.movies.media.*;
import quicktime.std.movies.media.DataRef;
import quicktime.app.view.*;
import quicktime.util.*;
import java.lang.reflect.*;
import quicktime.app.audio.*;

static boolean QTinitialized = false;
static int guid = 1;

public class FasterMovie
extends PImage
implements MovieDrawingComplete, MovieProgress
{
  AudioMediaControl audiocontrol = null;
  //public int width, height;
  Movie movie = null;
  QDGraphics gworld;
  int id;
  Method movieImageAvailableCallback = null;  
  boolean directwrite = false;
  boolean available = false;
  MovieController controller = null;
  QDRect movieRect;
  float fader = 1;
  
  public void pre ()
  {
      this.task();
  }

//daniel 20070417: this is the way to do it, in execute the movie is never done
  public void post ()
  {
    try{        
        if (movie.isDone()) 
        {
          if(repeat) {
              movie.goToBeginning();
              movie.start();
          } else
            isrunning = false;
        }  
    } 
      catch (Exception e) {
      e.printStackTrace();
    }
  }
  
  boolean task() 
  {
    available = false;
    try{
      Movie.taskAll(100);
    } 
      catch (Exception e) {
      e.printStackTrace();
    }
    return available;
  }  
  
  FasterMovie(PApplet _applet, String path, boolean _directwrite)
  {
    this(_applet, path);
    directwrite = _directwrite;    
  }
  
  FasterMovie(PApplet _applet, String path)
  {
      super(1, 1, RGB);
      
      id = guid++;
      applet = _applet;
      
      _applet.registerPre( this );
      _applet.registerPost( this );
      
      try {
        // fjenett 20070404: fixed
        Class[] args  =  new Class[]{ Class.forName("processing.core.PImage") }; // PImage.class
        movieImageAvailableCallback = _applet.getClass().getMethod("movieImageAvailable", args);
     } catch (Exception e) {
        //e.printStackTrace();
     }
     
    try {
      if (!QTinitialized)
      {
         // fjenett 20070404:
         // not sure PApplet handles shutdown of QTSession .. might need to do that ourselfs.
         QTSession.open(); 
         QTinitialized = true;
      }
  
       try { //security exception when online    
         //try reading various ways, just like the original
        try {
         QTFile file = new QTFile (path);
         OpenMovieFile openqtfile = OpenMovieFile.asRead(file);
         movie = Movie.fromFile(openqtfile);
        } catch (QTException e) {}
       
        if (movie == null) {
          try {
            File file = new File(path);
            if (file.exists()) {
              movie = fromDataRef(new DataRef(new QTFile(file)));
          }
        } catch (QTException e) { }
       }
     } catch (SecurityException se) {
      // online, whups. catch the security exception out here rather than
      // doing it three times (or whatever) for each of the cases above.
     }
      
     if (movie == null) {
       byte data[] = applet.loadBytes(path);
       try {
         movie = fromDataRef(new DataRef(new QTHandle(data)));
       } catch (QTException e) {
         e.printStackTrace();
       }
     }

    if (movie == null) {
      applet.die("Could not find movie file " + path, null);
    }

     movie.prePreroll(0, 1.0f);
     movie.preroll(0, 1.0f);

    //this should force the movie to aqcuire the playback size
    movieRect = movie.getBox();
    Pict pict = movie.getPict(movie.getTime());

    //establish direct ofscreen rendering
    if (quicktime.util.EndianOrder.isNativeLittleEndian()) {
         gworld =
           new QDGraphics(QDConstants.k32BGRAPixelFormat, movieRect);
     } else {
       gworld =
         new QDGraphics(QDGraphics.kDefaultPixelFormat, movieRect);
     }

    pict.draw(gworld, movieRect);
    PixMap pixmap = gworld.getPixMap();
    RawEncodedImage raw = pixmap.getPixelData();
    checkSize(raw);
    
     //probably we should call MovieController(int subType, Movie theMovie, QDGraphics window, QDPoint location) 
     //but I don't know the right subtype
     //this way it works if we set the offscreen gworld afterwards
     //...so far :)
     controller = new MovieController(movie);

     movie.setGWorld(gworld,GDevice.get());    
     movie.setDrawingCompleteProc(StdQTConstants.movieDrawingCallWhenChanged, this);
     movie.setProgressProc(this);

      
  } catch (Exception e) {
     //println("movie setup");
    e.printStackTrace();
  }
  }

  public void setVolume(float volume) {
    try {
      controller.setVolume(volume);
    } catch(QTException e) {
      //println("couldn't set voume");
    }
  }

  private quicktime.std.movies.Movie fromDataRef(DataRef ref)
    throws QTException {

    return
      quicktime.std.movies.Movie.fromDataRef(ref,
                                             StdQTConstants4.newMovieAsyncOK |
                                             StdQTConstants.newMovieActive);
  }

  void stop()
  {
    try {    
      movie.stop();
      isrunning = false;
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  void loop()
  {
    repeat = true;
    try {
        movie.start();
        isrunning = true;
    } 
    catch (Exception e) {
      e.printStackTrace();
      isrunning = false;
    }
  }

  public void speed(float rate) {
    //rate = irate;
    try {
      movie.setRate(rate);
    } catch (StdQTException e) {
      e.printStackTrace();
//      errorMessage("speed", e);
    }
  }

  public float time() {
    try {
      return (float)movie.getTime() / (float)movie.getTimeScale();

    } catch (StdQTException e) {
        //println("getting time");
      e.printStackTrace();
//      errorMessage("time", e);
    }
    return -1;
  }


  boolean running()
  {
    return isrunning;
  }
  
  void start ()
  {
    repeat = true;
    try {
        isrunning = true;
        movie.start();
    } 
    catch (Exception e) {
       //println("starting");
      e.printStackTrace();
    }
  }
  
    PApplet applet;
    boolean repeat = false;
    boolean isrunning = false;
    
  public void jump(float where) {
    try {
      //movie.setTime(new TimeRecord(rate, where));  // scale, value
      //movie.setTime(new TimeRecord(1, where));  // scale, value
      int scaledTime = (int) (where * movie.getTimeScale());
      movie.setTimeValue(scaledTime);

    } catch (StdQTException e) {
      e.printStackTrace();
    }
  }

  boolean available()
  {
    return available;
  }

//daniel 20070417: to make it reusable, we also want to check after loading
//so the applet can resize accordingly
  void checkSize(RawEncodedImage raw)
  {
     int w = movieRect.getWidth();
     int h = movieRect.getHeight();
     int j = raw.getRowBytes() - w * 4;
     int k = j / 4;
     w = w + k;
     if ( w != width || h != height ) {
        super.init(w, h, RGB);
     }        
  }

    int execute(Movie m)
    {
      //this shouldn't really be neccessary anymore
      //just ot make sure...
      if (isrunning == false)
        return 0;
      try{
        
        PixMap pixmap = gworld.getPixMap();
        RawEncodedImage raw = pixmap.getPixelData();
      
        checkSize(raw);
        
        // fjenett 20070404:
        // from processing.video.Movie
        if (applet != null && directwrite)
        {
          if (applet.width != width || applet.height != height)
            throw(new Exception("movie size doesn't match stage size"));
            //todo: have source and target rects
          applet.loadPixels();
          raw.copyToArray(0, applet.pixels, 0, pixels.length);
          // fjenett 20070404: 
          // i think things like this should be done via filter or in the sketch itself.
          //daniel 20070417:
          // i put it back :), it's the only way to control movie brightness
          //when direct drawing
           if ( fader >= 0 && fader < 1)
            for (int i = 0; i < applet.pixels.length; i++)
            {
              applet.pixels[i] =         (applet.pixels[i]        & 0xFF000000)         + 
                                 ((int)(((applet.pixels[i] >> 16) & 0xFF)*fader) << 16) + 
                                 ((int)(((applet.pixels[i] >> 8)  & 0xFF)*fader) << 8)  + 
                                  (int) ((applet.pixels[i]        & 0xFF)*fader);
            }
          applet.updatePixels();
        } else {
          loadPixels();
          raw.copyToArray(0, pixels, 0, pixels.length);
          updatePixels();
          if (movieImageAvailableCallback != null)
            movieImageAvailableCallback.invoke(applet, new Object[] { this });
          available = true;
        }
      } 
      catch (Exception e) {
       //println("executing");
        e.printStackTrace();
      }
      return 0;
    }
  public int execute(Movie theMovie,int message,int whatOperation, float percentDone)
  {
    println("progress: " + percentDone);
    return 0;
  }
}

