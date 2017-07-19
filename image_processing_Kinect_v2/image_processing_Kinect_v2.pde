// Santiago Casero //<>// //<>//
// Code for data collection of RGB and DepthMap images

// Modified version of code by Thomas Sanchez Lengeling
// 

// original work can be found here: https://github.com/shiffman/OpenKinect-for-Processing

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;


Kinect2 kinect;


//time variables to check the delay between images
int timeRGB = 0;
int timeGrayscale = 0;

//counter of number of grayscale images
int grayscale = 0;

//directory where images wil be saved to, modify for use on different machines
String directory = "D:\\Users\\kxero\\Documents\\Pictures\\Test\\";


void setup() {
  size(800, 320);


  //create the Kinect
 
    kinect = new Kinect2(this);
    kinect.initDepth();
    kinect.initVideo();
    
    kinect.initDevice();

}


void draw() {
  background(0);


    //Checking if 5 seconds have passed to give the Kinect time to setup
    if (millis() > 5000) {
      
      //200 miliisecond delay so as to not save too many RBG images
      if(millis() > timeRGB + 200) {
        kinect.getVideoImage().save(directory + "RGB\\" + millis()); 
      }
      
      
      //500 miliisecond delay so as to not save too many grayscale images,
      //without this delay DepthMap images would change very slowly creating a bad data set
      if(millis() > timeGrayscale + 500) {
        kinect.getDepthImage().save(directory + "Grayscale\\" + millis());
        timeGrayscale = millis();
        grayscale++; //increasing the counter so we keep track of how many images have been done so far
      }
    }
    
    //make the kinects capture smaller to fit the window
    image(kinect.getVideoImage(), 0, 0, 320, 320);
    image(kinect.getDepthImage(), 320, 0, 320, 320);


  fill(255);
  text(
    "Grayscale Images: " + grayscale, 660, 100, 280, 250); //show how many images have been done so we can have consistent takes
}