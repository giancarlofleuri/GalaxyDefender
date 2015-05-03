//All the Character details, that will be applied to the other classes, such as Fighter

class Chara {
  //this create all the character data, such as size(radius), health and group
  PMatrix3D matrix = new PMatrix3D();
  PVector pos = new PVector(), vel = new PVector();//create new position and velocity of the character
  float radius, health;
  int group;
  
  Chara(float _x, float _y, float _z, float _radius, int _group) {
    //Receive all the parameter that comes from the for in the draw method:
    pos.x = _x; 
    pos.y = _y; 
    pos.z = _z;
    radius = _radius; 
    health = 100.0; 
    group = _group;
  }
  
  void roll(float rotX, float rotY, float rotZ) {
    //Rotate arround all the axis, acording with the parameters received from the main
    matrix.rotateY(radians(rotY));  
    matrix.rotateX(radians(rotX));  
    matrix.rotateZ(radians(rotZ));
  }
  void accel(float speed) {
    //Acceleration function
    vel.x += matrix.m02 * -speed;  
    vel.y += matrix.m12 * -speed;  
    vel.z += matrix.m22 * -speed;
  }
  
    void revert(float speed) {
    //Reverse gear function, 
    vel.x -= matrix.m02 * -speed;  
    vel.y -= matrix.m12 * -speed;  
    vel.z -= matrix.m22 * -speed;
  }
  void lookAt(PVector vz) {
    //The function responsible for control the 'camera' and to where the player look according with the parameters
    PVector vx = vz.cross(new PVector(0, 1, 0)); //Return the vector made of the cross between VZ and (0,1,0) 
    vx.normalize();//normalize the vector
    PVector vy = vz.cross(vx); //Return the vector made of the cross between VZ and VX, crossed above
    vy.normalize();//normalize the vector
    matrix.set(vx.x, vy.x, vz.x, pos.x, vx.y, vy.y, vz.y, pos.y, vx.z, vy.z, vz.z, pos.z, 0, 0, 0, 1);//set the matrix of all the vectors created above
  }
  void updateMatrix() {
    //Update the matrix with the positions POS
    matrix.m03 = pos.x; 
    matrix.m13 = pos.y; 
    matrix.m23 = pos.z;
  }
  void update() {
   //Update the position with the velocity POS
    pos.x += vel.x; 
    pos.y += vel.y; 
    pos.z += vel.z;
  }
  boolean isHit(Chara chara) {
    //if is hit
    if (group==chara.group) return false;
    else return pos.dist(chara.pos) <= radius + chara.radius;
  }
  boolean damage(float _damage) {
    //decrease the health according with the damage
    health -= _damage;
    //if(health <40){ Sounds(5);}
    return health <=0.0;
  }
  void draw() {
    //Draw the character in general
    pushMatrix(); 
    updateMatrix(); 
    applyMatrix(matrix);//mutiply it fot the matrix 'matrix'
    drawShape();//Draw the spaceship
    popMatrix();
    update();
  }
  void drawShape() {
    //Create the shape of the spaceship
    fill(255); 
    box(radius);//size of the 
  }

};

