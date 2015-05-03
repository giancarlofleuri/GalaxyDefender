//Enemy is a Fighter as well, but here it control other aspects such as:
//movement, speed and shape:
float inc2 = TWO_PI / 200;
float dec=0, decX=0, decZ=0, oldY=0, oldX=0;
float diag = 0, deepth=1;
int dummy=0;
int CX,CY;
float move;

class Enemy extends Fighter {
  int level;
  Enemy(float _x, float _y, float _z, float _radius, float _move) {
    super(_x, _y, _z, _radius, ENEMY);
    level = int(random(3));
    move = _move;
  }
  void update() {
    PVector vz = new PVector(pos.x-player.pos.x, pos.y-player.pos.y, pos.z-player.pos.z);
    vz.normalize();
    float leapLevel = 0.05 * (1 + level);//create the leapLevel and contorl it bellow:
    vz.x = lerp(matrix.m02, vz.x, leapLevel);
    vz.y = lerp(matrix.m12, vz.y, leapLevel);
    vz.z = lerp(matrix.m22, vz.z, leapLevel);
    vz.normalize();
 
    lookAt(vz);//where the Enemy will look at
    accel(0.01 * level);//update the acceleration
    super.update();
    //When the enemy will shoot, a kind of AI:
    if ( millis()>3000*(1+level) && 0==(millis() % (100-level*20)) && (player.health>0)) 
    shoot(10, radians(10 + 10*level));
  }
  void drawShape() {
    drawEnemy(500);
  
  }
}

//---------------------- Primitive tore ------------------v
void tore(int section, int rayon){
  for( float i = 0; i < TWO_PI; i +=TWO_PI/60 ){
    rotateY(TWO_PI/60);
    //-------------------------------------------------------
    if(dummy%20==0) cylinder(30,rayon,section/2,20); //rayons
    noStroke(); //--------------------------------------------
    pushMatrix();
    translate(0,0,rayon);
    rotateY(radians(90));
    dummy ++;
    cylinder(-rayon/18,rayon/18,section,30);
    popMatrix(); 
  } 
}
 
//---------------------------------------------------
// some new usefull primitive
//cylinder(base, top , radius, resolution)
 
 public void drawEnemy(int seed){
 oldY=mouseY;oldX=mouseX;
  // --------------------------------------- positions and moves
  rotateX(90);
  rotateZ(0); 
  rotateY(0);
  //------------------------------------------- dessin du moyeu
  pushMatrix();  
  fill(180,192,192);
  rotateX(radians(90)); cylinder(-10,10,30,40);
  stroke(92,92,24); strokeWeight(1);
  fill(180,192,192); sphereDetail(15,15);
  rotateZ(-dec);
  translate(0,0,10); sphere(29.5);
  translate(0,0,-20); sphere(29.5);noStroke(); 
  fill(120,128,128);
  popMatrix();
  //------------------------------------------ dessin de la roue
  dummy=0;
  tore(15,150);
 }
 
  public void cylinder( int base, int top, float w, int res )
  {
    float inc = TWO_PI / res;
    beginShape( QUADS );
    for( float i = 0; i < TWO_PI; i += inc )
    {
      float cw=cos(i)*w,sw=sin(i)*w,cw1=cos(i+inc)*w,sw1=sin(i+inc)*w;
      if(dummy%2==0){ fill(180,192,192);}else{fill(120,128,128);}
      if ((i%(inc*6)==0)&(dummy%3==0)) fill(255,0,0); // fenêtres
      vertex( cw, sw, base);
      vertex( cw1, sw1, base );
      vertex( cw1, sw1, top );
      vertex( cw, sw, top ); 
    }
    endShape();
  }



