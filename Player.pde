//the Player is a Fighter, but can be created 
//with a different size and features:
class Player extends Fighter {
  Player(float _x, float _y, float _z, float _radius) { super(_x, _y, _z, _radius, PLAYER); }
  void drawShape() {
    //Here the player is drawn
    stroke(0, 255, 0, 64); strokeWeight(2); noFill();
    translate(0, 0, -10);//position of the player
    box(radius, radius, radius*5);//here, the player is a box
    noStroke();
  }
}
