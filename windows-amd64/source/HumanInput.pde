// HumanInput.pde
PFont violetSans;
int hours = hour();
int minutes = minute();
int seconds = second();
public void setup() {
  size(368, 448);
  smooth();
  noStroke();
  violetSans = createFont("violetsans.ttf", 48);
  textFont(violetSans);
  textAlign(LEFT, CENTER);
}
public void draw() {
  background(13);
  float sinWave = tan( radians( seconds * (frameCount*.5) * ( noise( .0016, .025 ) ) ) );
  // Star One
  pushMatrix();
  translate( width / 2, height / 2);
  fill( 255 - ( hours + ( seconds / 2 ) ), seconds * 7, 32 * ( minutes - seconds ) );
  drawStar();
  popMatrix();

  //Star Two
  pushMatrix();
  translate( width / 2, height / 2);
  //translate( mouseX, mouseY);
  rotate(TWO_PI * frameCount / width);
  translate(0, width / 5);
  fill(minutes * hours, seconds * 7, 255 - ( minutes * 2 ) );
  drawStar();
  popMatrix();

  pushMatrix();
  renderTime(16 + int(noise(seconds*sinWave)), height - 124, 24 * (sinWave*.28));
  popMatrix();
}
void renderTime(int xPosition, int yPosition, float leadingValue) {
  int h = hour();
  int m = minute();
  int s = second();
  String timestamp = h + " hours\n" + m + " minutes\n" + s + " seconds\n®™";
  fill(255);
  textSize(24);
  textLeading(24 + leadingValue);
  text(timestamp, xPosition, yPosition  );
}
void drawStar() {
  float numberOfSpokes = ( width * height ) / ( ((24000000 / frameCount) * seconds) * (noise( .0016, .025 )) );
  for (float i = 0; i < numberOfSpokes; ++i) {
    /*
     How map works here?
     Convert i:
     within current range
     lower bound 0
     upper bound numberOfSpokes - 1
     within target range
     lower bound 0
     upper bound TWO_PI (360 degrees)
     */
    float t0 = map(i, 0, numberOfSpokes - 1, 0, TWO_PI);
    float t1 = t0 + (TWO_PI/(2 * numberOfSpokes));

    // Arc: xCoordinate, yCoordinate, width, height, start, stop
    //rect(noise( hours *  t0), noise( hours *  t1), width*noise(seconds*i), height*noise(seconds*i));
    arc( noise( hours *  frameCount), noise( hours /  frameCount), width*noise(seconds), height, t0, t1);
  }
}
