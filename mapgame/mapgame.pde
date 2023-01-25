//make player explode (with blood)
//make jump to get coins and get money
//make tunnel that takes you somewhere else
//fix the lava ( make it slow and bubble)
//make heart lives

//for turtle bro: make turtle bro class, add turtle pixel to grid, add color code

import fisica.*;
FWorld world;

//color pallette
color white = #FFFFFF;
color black = #000000;
color green = #00FF00;
color red   = #FF0000;
color blue  = #0000FF;
color cyan  = #00FFFF;
color middleGreen = #00FF00;
color leftGreen   = #009F00;
color rightGreen  = #006F00;
color centerGreen = #004F00;
color treeTrunkBrown = #FF9500;
color orange = #F0A000;
color brown  = #996633;
color spikyGrey = #b4b4b4;
color darkBlue = #2f3699;
color bridgered = #990030;
color lavared0 = #993d00;
color lavared1 = #452107;
color lavared2 = #de6107;
color lavared3 = #c47944;
color lavared4 = #b34800;
color redtub   = #750000;
color goombacolor   = #6f3198;
color walls    = #ffa3b1;
color bouldercolor  = #ffc30e;
color turtlebro = #ffee00;

int timer=-1;
int timer2=-2;

//Images
PImage map, ice, stone, spike, trampoline, bridgeCenter, bridgeLeft, bridgeRight, hammerbro;

PImage treeTrunk, treeIntersect, treeMiddle, treeLeft, treeRight, lavatub, heart;

PImage [] idle;
PImage [] jump;
PImage [] run;
PImage [] action;

PImage [] chosen;

PImage [] goomba;

PImage [] lava;

PImage[] boulderRest;
PImage[] boulderMad;

PImage[] turtle;

//extras
int gridSize = 32;
float zoom = 1.5;
int lives=5;

//#1
//PImage lava0, lava1, lava2, lava3, lava4, lava5, ;
//PImage[] images = {lava0, lava1, lava2, lava3, lava4, lava5};
//int randomImage = (int) random(0, 6);

//keyboard
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;

//Fbodies
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;

//int randomWord  = (int) random(0, 6); //will return 1-5, not 5.99 because we add int


//String [] words = {"lava0", "lava1", "lava2", "lava3", "lava4", "lava5"};




void setup() {
  size(800, 800);
  Fisica.init(this); //initialize fisica
  terrain = new ArrayList<FGameObject> ();
  enemies = new ArrayList<FGameObject> ();
  loadImages();
  loadAnimation();
  map.get(0, 0); //starts counting from 0, gives us the color
  makeWorld(map);
  makePlayer();
}

void loadAnimation() {
}

void loadImages() {
  map = loadImage("speedy.png");
  bridgeCenter= loadImage("bridge.png");
  bridgeLeft= loadImage("bridge_w.png");
  bridgeRight= loadImage("bridge_e.png");
  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeMiddle = loadImage("treetop_center.png");
  treeLeft = loadImage("treetop_w.png");
  treeRight = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  trampoline = loadImage("blueBlock.png");
  heart = loadImage("corazon.png");
  hammerbro= loadImage("hammer.jpg");

  //#2
  //lava0 = loadImage("lava0.png");
  //lava1 = loadImage("lava1.png");
  //lava2 = loadImage("lava2.png");
  //lava3 = loadImage("lava3.png");
  //lava4 = loadImage("lava4.png");
  //lava5 = loadImage("lava5.png");

  lavatub = loadImage("lavadeep.png");

  lava = new PImage [6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  action = idle;

  //enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  //boulder
  boulderRest = new PImage[1];
  boulderRest[0] = loadImage("thwomp0.png"); //idle

  boulderMad = new PImage[1];
  boulderMad[0] = loadImage("thwomp1.png"); //mad

  chosen = boulderRest;

  //turtle
  turtle = new PImage[2];
  turtle[0] = loadImage("hammerbro0.png");
  turtle[0].resize(gridSize, gridSize);
  turtle[1] = loadImage("hammerbro1.png");
  turtle[1].resize(gridSize, gridSize);
}



void makeWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000); //make the world (top left x and y, bottom x and y
  world.setGravity(0, 981);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c==black) {
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      }
      if (c== cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      }

      if (c== treeTrunkBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setFriction(4);
        b.setName("tree trunk");
        world.add(b);
      }
      if (c== centerGreen) {
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      }
      if (c== middleGreen) {
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      }
      if (c== leftGreen) {
        b.attachImage(treeLeft);
        b.setName("treetop");
        world.add(b);
      }
      if (c== rightGreen) {
        b.attachImage(treeRight);
        b.setName("treetop");
        world.add(b);
      }
      if (c== spikyGrey) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      }
      if (c== darkBlue) {
        b.attachImage(trampoline);
        b.setRestitution(3);
        b.setName("trampoline");
        world.add(b);
      }

      if (c == bridgered) {
        FBridge br = new FBridge (x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      if (c== lavared0) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared2) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared3) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== lavared4) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }

      if (c== lavared1) {
        FLava lav = new FLava (x*gridSize, y*gridSize);
        terrain.add(lav);
        world.add(lav);
      }
      if (c== redtub) {
        b.setFillColor(redtub);
        b.setStrokeColor(redtub);
        b.setStatic(true);
        b.setSensor(true);
        b.setName("Lava");
        world.add(b);
      }
      if (c == goombacolor) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      }
      if (c== walls) {
        b.attachImage(stone);
        b.setName("walls");
        world.add(b);
      }
      if (c == bouldercolor) {
        FBoulder bld = new FBoulder(x*gridSize, y*gridSize);
        enemies.add(bld);
        world.add(bld);
      }
      if (c== turtlebro) {
        Fturtle tlt = new Fturtle(x*gridSize, y*gridSize);
        enemies.add(tlt);
        world.add(tlt);
      }
    }
  }
}


void makePlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(black);
  textSize(30);

  int i=0;
  int x=50;
  while (i<lives) {
    image(heart, x, 50, 50, 50);
    x=x+50;
    i++;
  }
  drawWorld();
  actWorld();
}

void actWorld() {
  player.act();
  for (int i=0; i<terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
    t.show();
  }
  for (int i=0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+ width/3, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
