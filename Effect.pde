//Creates the explosion effect when a ENEMY is destroyed

class Effect extends Chara {
  Effect(float _x, float _y, float _z, float _radius) { 
    super(_x, _y, _z, _radius, EFFECT);
        Sounds(4);
  }
  void drawShape() {
    damage(2);
    matrix.scale(1.04);//explosion effect
    matrix.rotateX(0.1);//explosion effect
    fill(255, 64, 32, map(health, 0, 100, 0, 128));//explosion effect, with a red collor
    sphereDetail(7); //detail of the spheres of the explosion. If higher, more rounded it will be
    sphere(radius);//Draw the effect itself
  }
}
  
