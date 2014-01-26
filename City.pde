class City {
  float DEVIATION = 0.25;
  float BIAS = 0.5;
  
  PImage block;
  PImage[] images = new PImage[2];
  int buildings, margin, maxFloors;
  int[] floors, tops;
  int built;
  int count;
  
  City() {
    block = loadImage("block.gif");
    images[0] = loadImage("roof.gif");
    images[1] = loadImage("razed.gif");
  }
  
  void initialise(int cityHeight, int level) {
    maxFloors = cityHeight/block.height;
    buildings = (width - BREATHING_SPACE*BORDER)/(block.width+GAP);
    margin = (width -buildings*(block.width+GAP) +GAP) /2;
    floors = new int[buildings];
    tops = new int[buildings];
    float scale = maxFloors + 2*level; // add two floors per additional level
    count=0;
    for (int i=0; i<buildings; i++) {
      float r = randomGaussian()*DEVIATION +BIAS;
      floors[i] = max(min(int(r*scale), maxFloors),0);
      count += floors[i];
      tops[i] = 0; // topped by a roof
    }
    built=0;
  }
  
  void draw() {
    for (int i=0; i<buildings; i++) {
      int x = i*(block.width+GAP) +margin;
      int f = min(floors[i],built);
      for (int j=1; j<f; j++) {
        image(block,x,height -BORDER -GROUND -j*block.height);
      }
      // top it off
      if (f>0 && tops[i]>=0) {
        image(images[tops[i]],x,height -BORDER -GROUND -(f-1)*block.height -images[tops[i]].height);
      }
    }
    if (built<maxFloors) built++;
  }
  
  int getBuilding(int x) {
    if (x<margin) return -1;
    int i = (x-margin)/(block.width+GAP);
    return i<0 || i>=buildings ? -1 : i;
  }
  
  int getBuildingHeight(int i) {
    return floors[i];
  }
  
  int getBuildingX(int i) {
    return i*(block.width+GAP) +margin;
  }
  
  void crash(int i) {
    tops[i] = -1;
  }
  
  void bomb(int i, int altitude) {
    if (floors[i]-1>=altitude) {
      int points = floors[i] - max(0,altitude);
      score += points;
      count -= points;
      floors[i] -= points;
      tops[i] = 1;
    }
  }
  
}
