int cols;
int rows;
int w = 5000;
int h = 5000;
int scale = 20;

float[][] zValue;

float flying = 0;

void setup() {
  size(1000, 700, P3D);

  cols = w / scale;
  rows = h / scale;
  zValue = new float[cols][rows];
}

void draw() {
  prepareZValues(100);

  background(200, 200, 230);

  translate(width / 2, height / 2);
  rotateX(PI / 3);
  frameRate(1);
  translate( -w /2, -h / 2);
  noStroke();

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < cols; x++) {
      setFill(zValue[x][y], y);
      int offset = floor(1.2 * zValue[x][y]);
      //fill(colour, 0 + distanceAlphaIncrement * y);
      //stroke(colour - 10, 0 + distanceAlphaIncrement * y);

      vertex(x * scale, y * scale, zValue[x][y]);
      vertex(x * scale, (y + 1) * scale, zValue[x][y + 1]);
    }
    endShape();
  }
}

void setFill(float z, int rowNumber) {
  int distanceAlphaIncrement = 255 / cols;
  int opacity = 255;

  if (rowNumber < rows / 15) {
    opacity =  0 + distanceAlphaIncrement * rowNumber;
  }
  if (z < -60) {
    fill(100, 100, 200, opacity);
    stroke(90, 90, 190, opacity);
  } else {
    int colour = 255 / 2 + min(floor(1.2 * z), 255 / 2);
    fill(colour + 10, colour + 50, colour, opacity);
    stroke(colour, colour + 40, colour - 10, opacity);
  }
}

void prepareZValues(int y) {
  float speed = 0.1;
  flying -= speed;
  float colOff = 0;
  for (int col = 0; col < cols; col++) {
    float rowOff = flying;
    for (int row = 0; row < rows; row++) {
      zValue[col][row] = map(noise(colOff, rowOff), 0, 1, -100, 100);
      rowOff += 0.1;
    }
    colOff += 0.1;
  }
}
