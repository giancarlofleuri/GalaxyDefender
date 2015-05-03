//Menu class uses the objects from the MenuItem and forms a menu with a title and a list of MenuItem objects.

/*
  Constructor: Str-MenuTitle, Str[]-MenuItems, PF-MenuFont, PF-MenuItemFont, c-TitleColor, c-ItemTextColor, c-ItemBackColor, c-ItemHoverTextColor, c-ItemHoverBackColor.

  Methods:
      void render() - Renders the MenuTitle and the MenuItems.
      void passTo(float,float) - Passes the mouse coords to each MenuItem to check whether it has been clicked.
      void passTo(int) - Resets the clickState of the specified MenuItem by calling the unClick() method on that MenuItem.
      String whichItem() - Checks all the MenuItems for a their clickState and returns the one that's been clicked.
*/

class Menu{
  String titleT;

  PFont titleF;
  PFont menuItem;

  color titleC;

  float spacer;    //This is used to define the space between successive MenuItem objects.
  float iniY=height/2;

  MenuItem[] menuItems;

  Menu(String titleT,String[] menuItemsNames,PFont titleF,PFont menuItemF,color titleC,color menuItemC,color menuBackC,color itemHoverC,color backHoverC){
    this.titleT=titleT;
    this.titleF=titleF;
    this.titleC=titleC;

    menuItems=new MenuItem[menuItemsNames.length];  //Initializes the MenuItem objects depending on the array passed to it. This makes the menu system very flexible.
    spacer=48;
    for(int i=0;i<menuItemsNames.length;i++){      
      menuItems[i]=new MenuItem(menuItemsNames[i],menuItemF,width/2,iniY+(spacer*i),height/25,menuItemC,menuBackC,itemHoverC,backHoverC);
    }
  }

  void render(){  //Renders the menu.
    textFont(titleF);
    textSize(92);
    fill(titleC);
    text(titleT,width/2-(textWidth(titleT)/2),height/3.8);

    for(int i=0;i<menuItems.length;i++){
      menuItems[i].update();
      menuItems[i].render();
    }
  }

  void passTo(float mX,float mY){    //This accepts the X,Y mouse coords when the mouse is clicked and passes it to the relevant MenuItem object to check if the click occurs on that object.
    for(int i=0;i<menuItems.length;i++){
      menuItems[i].mClicked(mX,mY);
    }
  }

  /*void passTo(int item){  //This accepts an ineteger value and resets that particular menu item's click state.
    menuItems[item].unClick();
  }*/

  String whichItem(){  //Checks each time if the clickState of any MenuItem object is true. If it is, returns the array position of the relevant object.
    for(int i=0;i<menuItems.length;i++){
      if(menuItems[i].getClicked()){
        menuItems[i].unClick();
        return menuItems[i].menuItem;
      }
    }
    return "NIL";
  }
}

//MenuItem holds the attributes and methods relating to each single item on the menu. Thus each item is treated as a separate object.
//Each MenuItem object comprises mainly of a foreground text and a background object. 

