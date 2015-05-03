//Bullet is the 'laser' wich comes from one of the fighters, player or enemy and hit another.
//Here, it is a laser, drawn as a shape in the end of the class

class Bullet extends Chara {
  int power;//power of the bullet, can be different according with the power of each player/enemy
  
  Bullet(float _x, float _y, float _z, float _radius, int _group, int _power) {
    //receive all the parameters form the parent class
    super(_x, _y, _z, _radius, _group);
    power = _power;
  }
  void drawShape() {
    //Draw the bullet, a 'laser' retangle:
    damage(0.5);
    if (group==PLAYER) {
      stroke(0, 255, 155, 128);//Create a 'glow' effect arround the laser
      fill(0, 255, 0);//color of the laser bullet
      translate(0, radius*7, 0);
      box(radius, radius, radius*20);//create the 'laser' itself
    }
    else //create the same 'laser' with the same features:
    {
      stroke(200, 0, 0, 128);
      strokeWeight(8); 
      fill(255, 0, 0);//color of the laser bullet,red color, to look different from the player
      translate(0, radius*7, 0);
      box(radius, radius/2, radius*30);//create the 'laser' itself
    }
  }
}

