class Plane {
  int BOUNCE = 7;
  
  int state;
  PImage[] images = new PImage[4];
  int altitude; // height in floors
  int x,y,y1,t;
  int building;
  boolean landed, crashed;
 
  Plane() {
    images[0] = loadImage("plane0.gif");
    images[1] = loadImage("plane1.gif");
    images[2] = loadImage("plane2.gif");
    images[3] = loadImage("plane3.gif");
  }
  
  void initialise(int cityHeight) {
    state = 0;
    altitude = cityHeight/city.block.height+1;
    x = BORDER -images[0].width;
    y = height -BORDER -GROUND -altitude*city.block.height - CLEARANCE -plane.images[0].height;
    y1 = t = 0;
    landed = crashed = false;
  }
  
  void draw() {
    image(images[state],x,y+y1);
  }
  
  void step() {
    switch (state) {
      case 0: // flying
      x += STEP;
      if (x > width +plane.images[0].width) { 
          // move the plane to the start of the next layer
          x = BORDER-plane.images[0].width;
          if (city.count>0) {
            y += city.block.height;
            altitude -= 1;
          }
      }
      building = city.getBuilding(x+plane.images[0].width);
      if (building>=0 && city.getBuildingHeight(building)>altitude) {
        state++; // crash
        frameRate(10); // slo-mo
        x = city.getBuildingX(building) +city.block.width -images[state].width;
        y += + CLEARANCE +images[state-1].height -images[state].height;
        city.crash(building);
      }
      if (city.count==0) { // safe to land
        if (y+images[0].height<height-BORDER-GROUND) {
          y++; // descent
          if (y%city.block.height==0) score += BONUS;
        }
        else if (y+images[0].height==height-BORDER-GROUND) { // bounce
          frameRate(20); // slo-mo
          y1 = min(0,-BOUNCE*t + t*t++);
          landed = x-STEP>width;
        }
      }
      break;
      
      case 1: // crashing
      state++;
      x = city.getBuildingX(building) +city.block.width -images[state].width;
      y += images[state-1].height -images[state].height;
      break;
      
      case 2: // crashed
      state++;
      y += images[state-1].height -images[state].height;
      crashed = true;
      break;
    }
  }
  
}
