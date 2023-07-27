import controlP5.*;

PImage[] myEmos = new PImage[6];

boolean start=false;
PImage back;
PImage logo;
color background;
color background2;
boolean clearIt = false;
Slider2D gridControl;
float brush;
float rando;
float c3;
int timer;
int soundFactor;

float a;

float soundForce=1;
//boolean music = true;
boolean rotate=false;



void settings() {
  size(1920, 1080);
  pixelDensity(displayDensity());
}

void setup() {
  //textureMode(NORMAL);
  //createWindows();


  noStroke();
  for (int i=0; i < myEmos.length; i++) {
    myEmos [i] = loadImage( "em"+i+".png");
  }
  back = loadImage("004_BW.jpg");
   logo = loadImage("LogoLogo.png");


  x = random(width);
  y = random(height);
  speed = random(3, 6); // Increased speed range
  
  
 speed2 = random(1, 3);
   xxx = random(width);
  yyy = random(height);
  
  
}


void draw() {

  movementA();
  
  
  blendMode(NORMAL);
  fill(51,255,153, 10);
  rect(0, 0, width, height);



  start=true;
  
  
  
    
  blendMode(NORMAL);
  image(logo, width/2,height/2, 400,400);
  
}

void keyPressed() {

  if ((key == 'c' || key == 'C')&&(clearIt==false)) {
    clearIt = true;
    background(background);
  } else {
    clearIt=false;
  }


  if (key == 's' || key == 'S') {
    loadPixels();
    for (int i = 10; i < width*height-10; i++) {
      pixels[i] = pixels[i+int(random(-10, 10))];
    }
    updatePixels();
  }

  if (key == ' ') {
    saveFrame("WEDDING-######.tiff");
    text("printed", 50, height-50);
  }
  
  

  
  
}

// Square properties
float x, y, xx, yy, xxx,yyy;
float size = 100;
float speed, speed2;
float angle = 0;
float noiseScale = 0.2;
float directionChangeDelay = 1000; // Number of frames before changing direction
float currentDelay = 0;
float brushChoice = 0;
float brushChoice2 = 0;
float rotationDirection = 1; // 1 for clockwise, -1 for counterclockwise

void movementA() {

  directionChangeDelay = random(5, 7000);


 
  // Reset noise generation
  noiseSeed(millis());

  // Update the square's position and rotation using Perlin noise
  float noiseX1 = map(noise(x * noiseScale, y * noiseScale), 0, 1, -1, 1);
  float noiseY1 = map(noise(x * noiseScale + 10, y * noiseScale + 10), 0, 1, -1, 1);
  float noiseX2 = map(noise(x * noiseScale + 20, y * noiseScale + 20), 0, 1, -1, 1);
  float noiseY2 = map(noise(x * noiseScale + 30, y * noiseScale + 30), 0, 1, -1, 1);
  float noiseSize = map(noise(x * noiseScale + 30, y * noiseScale + 30), 0, 1, -1, 1);


  float movementX = (noiseX1 + noiseX2) * speed * random(1, 20);
  float movementY = (noiseY1 + noiseY2) * speed * random(1, 20);

  float brushVal= random(0, 100);
  brushChoice = map(brushVal, 0, 100, 0, myEmos.length);



  println(brushChoice);

  float minSize = 100;
  float maxSize = 500; // Reduced size range
  size = map(abs(noiseSize), 0, 1, minSize, maxSize);

  x += movementX+random(-100, 100);
  y += movementY+random(-100, 100);


  // Check boundaries and bounce back
  if (x + size / 2 > width || x - size / 2 < 0) {
    x = constrain(x, size / 2, width - size / 2);
    speed = -speed; // Reverse the direction of movement on bouncing
    currentDelay = 0; // Reset the current delay when changing direction
  }
  if (y + size / 2 > height || y - size / 2 < 0) {
    y = constrain(y, size / 2, height - size / 2);
    speed = -speed; // Reverse the direction of movement on bouncing
    currentDelay = 0; // Reset the current delay when changing direction
  }

  // Update the square's rotation speed based on movement speed
  float movementSpeed = dist(0, 0, movementX, movementY);
  float rotationSpeed = map(movementSpeed, 0, speed, 0.02, 0.15);

 imageMode(CENTER);
  
  tint(255, 10);
  image(back, width/2, height/2, width, height);
  tint(255, 255);

  // Draw the square with rotation
  pushMatrix();
  translate(x, y);
  rotate(angle);
  blendMode(MULTIPLY); 
  image(myEmos[int(brushChoice)], 0, 0, size, size);
  //rect(0, 0, size, size);
  popMatrix();


  pushMatrix();
  translate(random(width), random(height));
  rotate(random(angle));
  fill(255, 150, 50);
  imageMode(CENTER);
  image(myEmos[int(brushChoice)], 0, 0, size/2, size/2);  
  popMatrix();


  pushMatrix();
  translate(random(width), random(height));
  rotate(random(angle));
  fill(255, 150, 50);
  imageMode(CENTER);
  image(myEmos[int(brushChoice)], 0, 0, random(size),random(size));  
  popMatrix();


  // Update the square's rotation
  angle += rotationSpeed;

  // Increase the current delay when moving in the same direction
  currentDelay++;

  // Change direction after the delay has been reached
  if (currentDelay >= directionChangeDelay) {
    speed = -speed; // Reverse the direction of movement
    currentDelay = 0; // Reset the current delay after changing direction
  }
  delay(100);
}
