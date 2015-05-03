
//MenuItem holds the attributes and methods relating to each single item on the menu. Thus each item is treated as a separate object.
//Each MenuItem object comprises mainly of a foreground text and a background object. 
class MenuItem{

  String menuItem;
  PFont menuFont;
  float itemX;
  float itemY;
  float itemSize;
  color itemColor;
  color backColor;
  color pressedColor;
  color pressedBack;

  color presentItem;
  color presentBack;

  float textWidth;

  boolean clickState=false;  //This vairable is used to check the clickState of the menu item. If the mouse is clicked over the menu item, this variable becomes true.

  MenuItem(String menuItem,PFont menuFont,float itemX,float itemY,float itemSize,color itemColor,color backColor,color pressedColor,color pressedBack){
    this.menuItem=menuItem;
    this.menuFont=menuFont;
    this.itemX=itemX;
    this.itemY=itemY;
    this.itemSize=itemSize;
    this.itemColor=itemColor;
    this.backColor=backColor;
    this.pressedColor=pressedColor;
    this.pressedBack=pressedBack;
  }

  void render(){    //Handles the rendering for individual menu objects.
    textFont(menuFont);
    textSize(itemSize);
    textWidth=textWidth(menuItem);

    stroke(0);
    fill(presentBack);
    rectMode(CENTER);
    rect(itemX,itemY,textWidth*1.3,itemSize*1.4,50);

    fill(presentItem);
    text(menuItem,itemX-textWidth/2,itemY+itemSize*.3);
  }

  void update(){             //Constatnly checks for the state of the object. If the mouse is over it a certain style is show and otherwise another style is shown.
    if(mouseX<(itemX+(textWidth*1.3)/2) && mouseX>(itemX-(textWidth*1.3)/2) && mouseY<(itemY+(itemSize*1.4)/2) && mouseY>(itemY-(itemSize*1.4)/2)){
     presentItem=pressedColor;
    
     noStroke();
    }
    else{
     presentItem=itemColor;
     presentBack=backColor;
    }
  }

  boolean getClicked(){    //Returns the clickState of the object.
    return clickState;
  }

  void unClick(){      //Resets the click state after having been clicked once.
    clickState=false;
  }

  void mClicked(float mX,float mY){  //Changes the clickState of the object depending on the position of the mouse as inputs.
    if(mX<(itemX+(textWidth*1.3)/2) && mX>(itemX-(textWidth*1.3)/2) && mY<(itemY+(itemSize*1.4)/2) && mY>(itemY-(itemSize*1.4)/2)){
      clickState=true;
      println(menuItem);
    }
  }
}


