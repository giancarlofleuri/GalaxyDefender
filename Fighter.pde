//Fighter is a character as well, but here it control other aspects such as:
//Size of the bullet and acceleration
class Fighter extends Chara {
  Fighter(float _x, float _y, float _z, float _radius, int _group) { 
    super(_x, _y, _z, _radius, _group);
  }
  Bullet shoot(int power, float radian) {
    Sounds(2);
    //Return all the features of the bullet, such as acceleration, position and power
    Bullet bullet = new Bullet(pos.x, pos.y, pos.z, 7, group, power);//create a new bullet
    bullet.matrix.set(matrix);
    if (radian>0) bullet.roll(random_pm(radian), random_pm(radian), random_pm(radian));
    bullet.accel(70);//speed of the bullet/laser
    bulletList.add(bullet);//add a new bullet
    return bullet;//return the bullet
  }
}

