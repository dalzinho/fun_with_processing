final float speed = 0.1;
final int minHeight = -100;
final int maxHeight = 100;
final int w = 5000;
final int h = 5000;
final int rollingness = 30;
final int seaLevel = -60;
final int distanceFactor = 6;

int cols;
int rows;
float[][] zValue;
float flying = 0;

void setup() {
  size(1000, 700, P3D);

  cols = w / rollingness;
  rows = h / rollingness;
  zValue = new float[cols][rows];
}

void draw() {
  prepareZValues(100);

  background(200, 200, 230);

  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate( -w /2, -h / 2);

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < cols; x++) {
      colourFillAndStroke(zValue[x][y], y);
      vertex(x * rollingness, y * rollingness, zValue[x][y]);
      vertex(x * rollingness, (y + 1) * rollingness, zValue[x][y + 1]);
    }
    endShape();
  }
}

void colourFillAndStroke(float z, int rowNumber) {
  int opacity = calculateOpacityFromRowValue(rowNumber);
 

  if (z < seaLevel) {
        int heightIncrement = 255 / minHeight;

    int colour = 50 + floor(z  * heightIncrement + seaLevel);
    fill(colour, colour, colour + 50, opacity + 10);
    stroke(colour - 10, colour - 10, colour + 40, opacity - 20);
  } else {
    int heightIncrement = 255 / maxHeight;
    
    int colour = 50 + floor(z  * heightIncrement + abs(seaLevel));
    fill(colour + 10, colour + 50, colour, opacity + 10);
    stroke(colour, colour + 40, colour - 10, opacity - 20);
  }
}

int calculateOpacityFromRowValue(int rowNumber) {
  int distanceAlphaIncrement = 255 / cols;
  int opacity;

  if (rowNumber < rows / distanceFactor) {
    opacity =  distanceAlphaIncrement * rowNumber;
  } else {
    opacity = 255;
  }

  return opacity;
}

void prepareZValues(int y) {
  flying -= speed;
  float colOff = 0;
  for (int col = 0; col < cols; col++) {
    float rowOff = flying;
    for (int row = 0; row < rows; row++) {
      zValue[col][row] = map(noise(colOff, rowOff), 0, 1, minHeight, maxHeight);
      rowOff += 0.1;
    }
    colOff += 0.1;
  }
}
