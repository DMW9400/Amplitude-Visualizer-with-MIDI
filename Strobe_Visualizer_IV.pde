import processing.sound.*;
import themidibus.*;

Amplitude amp;
AudioIn in;

MidiBus myBus;
int channel, number, value;

//declaration of variables for construction of amplitude-display rectangles
float min, max;
float x;
int y = 0;
int xRect = 0;

//declaration of variables for midi CC input
float cc[] = new float [256];
float cc2[]= new float [256];


void setup(){ 
  //background(40);
  frameRate(120);
  fullScreen();
  //size(800,800);
  smooth(8);


  //create an input stream which is routed into the amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this,0);
  in.start();
  amp.input(in);
  
  myBus = new MidiBus(this, 0, 1);
  
  max = 0;
  min = 0;
}

void draw(){
  
  background(cc[81],cc[82],cc[83]);

  //Traditional amp interpretation assignments
  //float value = amp.analyze();
  //float ampMove = map(value,0,.1,0,255);
  //float ampRed = map(value,0,.1,210,255);
  //float ampGreen = map(value,0,.1,0,255);
  //float ampBlue = map(value,0,.1,0,255);
  
  
  //amp interpretation with midi input
  float value = amp.analyze();
  
  //amp-color settings for first set of rectangles
  float ampRed = map(value,0,.1,cc[89],cc[90]);
  float ampGreen = map(value,0,.1,cc[91],cc[92]);
  float ampBlue = map(value,0,.1,cc[93],cc[94]);
  
  //amp-color settings for second set of rectangles 
  float ampRed2 = map(value,0,.1,cc[97],cc[98]);
  float ampGreen2 = map(value,0,.1,cc[99],cc[100]);
  float ampBlue2 = map(value,0,.1,cc[101],cc[102]);


//draw instructions for first set of amp-responsive rectangles
for (int i = width/4; i< width; i+= width/4){
  
  for(int y = height/4; y <height; y+=height/4){
    rect(i,y,70,70);
    fill(ampRed,ampGreen,ampBlue);
  }
}

//draw instructions for second set of amp-responsive rectangles
for (int i = width/3; i< width; i+= width/3){
  
  for(int y = height/3; y <height; y+=height/3){
    rect(i,y,70,70);
    fill(ampRed2,ampGreen2,ampBlue2);
  }
}
}

void controllerChange(int channel, int number, int value){
  this.channel = channel;
  this.number = number;
  this.value = value;

  cc[number]=map(value, 0, 127, 0, 255);
  cc2[number] = map(value, 0, 127, 0, 255);

}

  
  
  