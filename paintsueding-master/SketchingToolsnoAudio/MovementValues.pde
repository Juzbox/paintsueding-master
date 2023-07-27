// Square properties
float x, y;
float size = 40; // Reduced size range
float speed=200;
float angle = 0;
float noiseScale = 0.03; // Increased noiseScale for more movement
float rotationDirection = 1; // 1 for clockwise, -1 for counterclockwise
 float brushChoice = 0;


void movement() {

 noiseSeed(millis());
  
  // Update the square's position and rotation using Perlin noise
  float noiseX = map(noise(x * noiseScale, y * noiseScale), 0, 1, -10, 10);
  float noiseY = map(noise(x * noiseScale + 10, y * noiseScale + 10), 0, 1, -10, 10);
  float noiseAngle = map(noise(x * noiseScale + 20, y * noiseScale + 20), 0, 1, -10, 10);
  float noiseSize = map(noise(x * noiseScale + 30, y * noiseScale + 30), 0, 1, -10, 10);
  
  float movementX = noiseX * speed;
  float movementY = noiseY * speed;
  
  float brushVal= random(0,100);
  brushChoice = map(brushVal,0,100,0,myEmos.length);
  println(brushChoice);
  
  x += movementX;
  y += movementY;
  
  // Check boundaries and bounce back
  if (x + size / 2 > width || x - size / 2 < 0) {
    x = constrain(x, size / 2, width - size / 2);
    speed = -speed; // Reverse the direction of movement on bouncing
  }
  if (y + size / 2 > height || y - size / 2 < 0) {
    y = constrain(y, size / 2, height - size / 2);
    speed = -speed; // Reverse the direction of movement on bouncing
  }
  
  // Update the rotation direction based on Perlin noise
  rotationDirection = (noiseAngle < 0) ? 1 : -1; // Randomly set the rotation direction
  
  // Update the square's rotation speed based on movement speed
  float movementSpeed = dist(0, 0, movementX, movementY);
  float rotationSpeed = map(movementSpeed, 0, speed, 0.02, 0.15); // Increased rotation speed range
  
  // Update the square's size based on Perlin noise
  float minSize = 40;
  float maxSize = 80; // Reduced size range
  size = map(abs(noiseSize), 0, 1, minSize, maxSize);
  
  // Update the square's rotation
  angle += rotationDirection*2 * rotationSpeed;
  
  // Draw the square with rotation
  pushMatrix();
  translate(x, y);
  rotate(angle);
  fill(255, 150, 50);
  //rectMode(CENTER);
  //rect(0, 0, size, size);
    imageMode(CENTER);
  image(myEmos[int(brushChoice)], 0,0, size,size);
  popMatrix();
}
