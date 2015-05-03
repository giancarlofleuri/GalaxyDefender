//Create vectors of following objects:

drawSphere[] spheres = new drawSphere[50];
//--------------------------------------------------------------------------------------------------------
// import Minim
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.ugens.*;

String MODE;

Menu menu;
String[] menuItems= {
  "START", "INSTRUCTIONS", "CREDITS", "EXIT"
};

PFont sMenu=createFont("waved", 72);
PFont sItem=createFont("sixty", 35);

String gOverText="GAME OVER";
String hScoreText="SCORE:";

String iControl="Accelerate: SPACE BAR/Right mouse button";
String iControl2="Shoot: Left mouse button ";
String iScore="Camera: Mouse";
String iScore2="Kill the enemies to score +1. Kill them all!!!";

String cBy="Developed/Coded/Designed By:";
String cName="Giancarlo Fleuri - giancarlo.comp@live.com";

MenuItem back;

// set up the sound variables
Minim minim;

AudioSnippet laser, laser2, explosion, redAlert;
AudioPlayer soundtrack;
Delay myDelay;

// track when a drum has been struck
boolean laserStruck, laserStruck2, soundtrackStruck, explosionStruck, redAlertStruck, redAlertStatus=false;//http://www.newgrounds.com/audio/listen/561358 - soundtrack by GameBalance
int i=0;
//--------------------------------------------------------------------------------------------------------

//Create the Image variable to save all the textures
PImage sun, earth, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune, galaxy, spaceship, cockpit, menuBackground;

//import damkjer.ocd.*;
//PLAYER VARIABLES--------------------------------------------------------------------------------------------
int PLAYER = 0, ENEMY = 1, EFFECT = 2;
Player player = new Player(0, 0, 100, 10);//create the player 
ArrayList fighterList = new ArrayList();//amount of fighters in general: player and enemies
ArrayList bulletList = new ArrayList();
ArrayList effectList = new ArrayList();
float cameraShake = 0.0;
int clearMillis = 0;
int hScore;

// set the score for player
int score2 = 0;



//SETUP-------------------------------------------------------------------------------------------------------
void setup() {
  size(1280, 880, P3D);//size of the screen 
  textFont( createFont("DialogInput", 20) );//new font to show messages such as 'GAME OVER''
  //Load the textures of the following PImages/Planets/moons:
  sun = loadImage("sun3.jpg");
  mercury = loadImage("mercury.jpg");
  venus = loadImage("venus.jpg");
  earth = loadImage("earth.jpg");
  mars = loadImage("mars.jpg");
  jupiter = loadImage("jupiter.jpg");
  saturn = loadImage("saturn.jpg");
  uranus = loadImage("uranus.jpg");
  neptune = loadImage("neptune.jpg");
  moon = loadImage("moon.jpg");
  galaxy = loadImage("galaxy3.jpg");
  spaceship = loadImage("spaceship.jpg");
  cockpit = loadImage("cockpit.png");
  minim = new Minim(this);
  laser = minim.loadSnippet("laser.wav");
  laser2 = minim.loadSnippet("laser2.wav");
  soundtrack = minim.loadFile("soundtrack.mp3", 2048);                         
  explosion = minim.loadSnippet("explosion.wav");
  redAlert = minim.loadSnippet("redAlert.wav");
  menuBackground =loadImage("menu.PNG");
  laserStruck = false;
  laserStruck2 = false;
  soundtrackStruck = false;
  explosionStruck = false;
  redAlertStruck = false;
  Sounds(3);//Play the soundtrack a as a setup

  menu=new Menu("", menuItems, sMenu, sItem, color(#ffffff), color(#000000), color(#0000ff), color(#ffffff), color(255, 0));
  MODE="NIL";
  back=new MenuItem("BACK", sItem, width/2, height/1.5, height/25, color(#000000), color(#0000ff), color(#ffffff), color(255, 0));    //Common back button for some of the screens.
  hScore=0;
  addEnemy(10);
}      
//DRAW--------------------------------------------------------------------------------------------------------
void draw() {
  if (MODE.equals("NIL")) {
    menuBackground.resize(width, height);//resize the image to fit the screen
    background(menuBackground);//define this image as background
    menu.render();//render the menu
    MODE=menu.whichItem();//selection of the Item from the menu
  }


  else if (MODE.equals("START")) {  

    //cockpit.resize(width, height);
    background(0);
    textSize(50);
    text(hScoreText, width/2+80, 20);
    text(score2, width/2, 60);

    setLights();//call the functions responsible for the lights effects such as fade-out when leaves the galaxy and other
    setPlayerCamera();//set the camera
    drawStars();//create al the stars 

      for (int i=0;i<fighterList.size();i++) {
      //create a list of Fighters
      Fighter chara = (Fighter) fighterList.get(i);
      chara.draw();//draw the character
    }

    noLights();
    for (int i=0;i<effectList.size();i++) {
      Effect effect = (Effect) effectList.get(i);
      effect.draw();
      if (effect.health<=0) effectList.remove(i--);
    }

    for (int i=0;i<bulletList.size();i++) {
      Bullet bullet = (Bullet) bulletList.get(i);
      bullet.draw(); 
      for (int j=0;j<fighterList.size();j++) {
        Fighter fighter = (Fighter) fighterList.get(j);
        if (bullet.isHit(fighter)) {//When the bullet hit the player/enemy
          if (fighter==player) cameraShake += bullet.power * 0.5;//shake the camera according to the bullet power 
          if (fighter.damage(bullet.power)) {//If the player destroy a enemy
            fighterList.remove(j--);//Remove from the list
            score2 ++;//Score +1
            addEnemy(1);//Add a new enemy
            addExplosionEffect(fighter);//Explosion effect is applied
            cameraShake += 3.0;//how strong is the shake
          }

          bullet.health = 0;
          break;
        }
      }
      if (bullet.health<=0) bulletList.remove(i--);
    }

    camera();

    noLights();
    //textMode(NORMAL); 
    textSize(20); //size of the text
    textAlign(CENTER, TOP);
    if (player.health>30) fill(0, 255, 0, 128);
    else { 
      redAlertStatus=true;//to play the red alert sound
      fill(255, 0, 0, 128);//fill the health bar red if it is less than 30% of health
    }


    if (player.health>0) {
      int enemyNum = fighterList.size()-1;
      if (enemyNum==0) {//If all enemies are dead
        fill(255, 128);
        textSize(80);
        text("MISSION CLEAR", width/2, height/2 - 40);
      } 
      else {
        textAlign(RIGHT, CENTER);  //allignment of the text
        text(nf(player.health, 1, 0)+"%", width/3, height-30);//print the health status
        rectMode(CORNER);//rect mode
        stroke(0);//black line arround the health bar
        rect(20+width/3, height-34, map(player.health, 0, 100, 0, width/3), 20);//shows the halth bar according to the player's health
      }
    } 
    else {
      textSize(80);
      text("GAME OVER", width/2, height/2);
    }

    input();
    //image(cockpit,0,0,width,height);//Not available in this version
    cameraShake *= 0.95;
    hScore++;
  }
  else if (MODE.equals("INSTRUCTIONS")) {//Draw the instructions on the screen
    background(menuBackground);//same menu background is settled
    stroke(0);
    fill(#ffffff);
    text("", width/2-textWidth("INSTRUCTIONS")/2, height/3);//finally draw it on the screen

    textFont(sItem);
    textSize(30);
    text(iControl, width/2-textWidth(iControl)/2, height/2-35);
    text(iControl2, width/2-textWidth(iControl2)/2, height/2);
    text(iScore, width/2-textWidth(iScore)/2, height/2+35);
    text(iScore2, width/2-textWidth(iScore2)/2, height/2+70);

    back.render();
    back.update();
    if (back.getClicked()) {//if the player click on the back, it will set 'NIL' again 
      back.unClick();
      MODE="NIL";
    }
  }
  else if (MODE.equals("CREDITS")) {//show the credits, same way as the others above
    background(menuBackground);
    fill(#ffffff);
    textFont(sItem);

    textSize(35);
    text(cBy, width/2-textWidth(cBy)/2, height/2);

    textSize(45);
    text(cName, width/2-textWidth(cName)/2, height/1.7);

    back.render();
    back.update();
    if (back.getClicked()) {//if the player click on the back, it will set 'NIL' again 
      back.unClick();
      MODE="NIL";
    }
  }
  else if (MODE.equals("EXIT")) {
    exit();
  }
}

//--------------------------------------------------------------------------------------------------------
void input() {
  if (mouseX>0 && mouseX<width && mouseY>0 && mouseY<height) {//control the camera movements with the mouse
    float rotYLevel = map(mouseX, 0, width, -1, 1);
    float rotXLevel = map(mouseY, 0, height, -1, 1);
    player.roll(rotXLevel * abs(rotXLevel) * 3.0, -rotYLevel * abs(rotYLevel) * 3.0, 0.0f);
  }
  if (player.health>0) {//control the acceleration with CENTER button and space
    if ((keyPressed && key==' ')||(mousePressed && mouseButton==CENTER)) player.accel(0.04);
    //    else if ((keyPressed && key == 'r') ||(keyPressed && key == 'R')) setup();// this is not the best way to do it, performance problems
    else if ((mousePressed && mouseButton==RIGHT)) player.revert(0.04); //reverse control with right button
    else player.vel.mult(0.98);
  }
}

//--------------------------------------------------------------------------------------------------------
void mousePressed() {//Shoot control, just if the player is alive(player.health>0)
  if (player.health>0 && mouseButton==LEFT) player.shoot(30, 1);
}

//--------------------------------------------------------------------------------------------------------
void addExplosionEffect(Chara chara) {//call the explosion effect
  for (int i=0; i<10; i++) {
    Effect effect = new Effect(chara.pos.x, chara.pos.y, chara.pos.z, chara.radius);
    effect.vel.set(random_pm(3), random_pm(3), random_pm(3));
    effectList.add(effect);
  }
}

//--------------------------------------------------------------------------------------------------------

void setPlayerCamera() {//set the camera of the player in the matrix
  player.updateMatrix();
  float sl = cameraShake * 0.01;
  PVector sp = new PVector(random_pm(sl), random_pm(sl), random_pm(sl));
  camera(player.pos.x, 
  player.pos.y, 
  player.pos.z, 
  player.pos.x-player.matrix.m02+sp.x, 
  player.pos.y-player.matrix.m12+sp.y, 
  player.pos.z-player.matrix.m22+sp.z, 
  player.matrix.m01, 
  player.matrix.m11, 
  player.matrix.m21);
}

//--------------------------------------------------------------------------------------------------------
void setLights() {
  //ambientLight(255, 255, 255,0,0,0);
  //pointLight(255, 255, 255, -1, -1, -1);
  directionalLight(255, 255, 255, 0, 1, -1);
  ambientLight(64, 64, 64);
}

//--------------------------------------------------------------------------------------------------------
float modulo(float a, float b) {
  return a - floor(a / b) * b;
}

//--------------------------------------------------------------------------------------------------------

float random_pm(float range) {
  return random(-range, range);
}

//--------------------------------------------------------------------------------------------------------

void drawStars() {
  pushMatrix();
  translate(-player.pos.x+1500, -player.pos.y+1000, -player.pos.z+1500);//Draw the milky way at an especific distance from the player
  drawGalaxy();//draw the galaxy
  rotateZ(frameCount*PI * 0.05);//This control the rotation of the planets arround itself - THE TRANSLATION MOVEMENT
  popMatrix();
  pushMatrix();
  translate(player.pos.x, player.pos.y, player.pos.z);
  int seed = int(random(1000)); 
  randomSeed(0);
  float range = 500.0;
  PVector starPos = new PVector();
  for (int i=0; i<2000; i++) {//amount of stars on the space
    strokeWeight(int(random(1, 3))); //random size of the stars
    stroke(random(128, 255));
    starPos.set(random_pm(range*100), random_pm(range*100), random_pm(range*100));//random positions 
  

    starPos.set(random(range), random(range), random(range));
    starPos.x = modulo(-player.pos.x + starPos.x, range) - range * 0.5;
    starPos.y = modulo(-player.pos.y + starPos.y, range) - range * 0.5;
    starPos.z = modulo(-player.pos.z + starPos.z, range) - range * 0.5;
    line(starPos.x, starPos.y, starPos.z, starPos.x-player.vel.x*(range*0.001), starPos.y-player.vel.y*(range*0.001), starPos.z-player.vel.z*(range*0.001));
  }
  randomSeed(seed);

  noStroke();
  //fill(0, 0, 255);

  popMatrix();
}
//--------------------------------------------------------------------------------------------------------

void drawGalaxy() {
  //Planets = (SIZE, XDETAIL, YDETAIL, DISTANCE, DELAY,MOON(TRUE OR FALSE),TEXTURE)
  spheres[0] = new drawSphere(60, 40, 30, 0, 40, false, sun);//Size reduced 20x
  spheres[1] = new drawSphere(5, 40, 30, 80, 2, false, mercury);
  spheres[2] = new drawSphere(20.4, 40, 30, 150, 1, false, venus);
  spheres[3] = new drawSphere(20.9, 40, 30, 250, 4, true, earth);
  spheres[5] = new drawSphere(10.8, 40, 30, 350, 6, false, mars);
  spheres[6] = new drawSphere(40, 40, 30, 500, 4, false, jupiter);
  spheres[7] = new drawSphere(30, 40, 30, 650, 5, true, saturn);
  spheres[8] = new drawSphere(20, 40, 30, 700, 3, false, uranus);
  spheres[9] = new drawSphere(18, 40, 30, 750, 4, false, neptune);
  spheres[10] = new drawSphere(5000, 120, 90, 0, 40, false, galaxy);
}

void drawCockpit() {
}

void Sounds(int cod_sound) {
  // initialize sound
  int sound=cod_sound;

  switch(sound) {
  case 1://play the first laser sound 
    laserStruck = true;//set when is has been struck
    laser.rewind();
    laser.play(0);//play the sound
    break;
  case 2: //play the second laser sound 
    laserStruck2 = true;//set when is has been struck
    laser2.play(0);//play the sound
    laser2.rewind();
    break;
  case 3: //play the soundtrack
    soundtrackStruck = true;//set when is has been struck
    soundtrack.loop(0);//play the sound
    //soundtrack.rewind();
    break;
  case 4: //play the soundtrack
    explosionStruck = true;//set when is has been struck
    explosion.play(0);//play the sound
    explosion.rewind();
    break;
  case 5: //play the soundtrack
    redAlertStruck = true;//set when is has been struck
    redAlert.play(0);//play the sound
    redAlert.rewind();
    break;
  default:             // Default executes if the case labels
    println("DEFAULT");   // don't match the switch parameter
    break;
  }
}

// Minim requires that this function be added
void stop() {
  laser.close();
  laser2.close();
  soundtrack.close();
  explosion.close();
  redAlert.close();
  minim.stop();

  super.stop();
}

void mouseClicked() {
  if (MODE.equals("NIL")) {
    menu.passTo(mouseX, mouseY);
  }
  if (MODE.equals("GAMEOVER") || MODE.equals("INSTRUCTIONS") || MODE.equals("CREDITS")|| MODE.equals("EXIT")) {
    back.mClicked(mouseX, mouseY);
  }
}

void addEnemy(int n)
{
  fighterList.add(player);//create a new fighter, with the player created in the setup method
  for (int i=0; i<n; i++) {//create new enemies in random areas arround the player
    fighterList.add(new Enemy(random(-2000, 2000), random(-2000, 2000), random(-3000, -4000), 150, (random(1, 3))));
  }
}

