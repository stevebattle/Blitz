/**
 * Blitz Resurrection
 * 
 * by Steve Battle
 *
 * A simple animated game.
 *
 */

color BACKGROUND = color(102, 178, 255); // light blue
color GROUND_COLOUR = color(128,128,128); // grey
int BORDER = 12; // width/height of the border
int GROUND = 4; // height of ground in pixels
int CLEARANCE = 5; // clearance below the plane
int GAP = 2; // gap between buildings
int BREATHING_SPACE = 8; // space before first building
int STEP = 5; // pixels traversed in one step
int FONT_SIZE = 36;
int BONUS = 10;

Plane plane;
City city;
Bomb bomb;
PFont font;

int level = 0;
int score = 0, best = 0;

void drawGround() {
  fill(GROUND_COLOUR);
  stroke(GROUND_COLOUR);
  rect(BORDER, height -BORDER -GROUND, width - 2*BORDER, GROUND);
}

void drawScore() {
  textSize(FONT_SIZE);
  text("SCORE "+score,BORDER,BORDER+36);
}

void drawBest() {
  textSize(FONT_SIZE);
  text("BEST "+best,width/2,BORDER+36);
}

void setup() {
  size(450,300);
  font = loadFont("Checkbook-48.vlw");
  textFont(font);
  plane = new Plane();
  city = new City();
  bomb = new Bomb();
  startGame();
}
  
void startGame() {
  frameRate(30);

  // calculate maximum city height
  int cityHeight = height -2*BORDER -GROUND -plane.images[0].height -CLEARANCE;

  city.initialise(cityHeight, level++);  
  plane.initialise(cityHeight);
}

void draw() {
  background(BACKGROUND);
  drawGround();
  drawScore();
  drawBest();
  city.draw();
  if (bomb.falling) {
    bomb.draw();
    bomb.step();
  }
  plane.draw();
  if (!plane.landed) plane.step();
  else startGame();
  
  if (mousePressed && !bomb.falling) {
    if (plane.crashed) {
      level = score = 0;
      startGame();
    }
    else if (city.count>0) {
      bomb.drop(plane.x+plane.images[0].width/2, plane.y+plane.images[0].height/2);
    }
  }
  if (score>best) best = score;
}
