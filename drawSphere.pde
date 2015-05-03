//CODE used to help to texturize the sphere: http://processing.org/discourse/beta/num_1274893475.html
//All the moviments and adaptations made independently
//All the planets are created according with the following parameters:
    //(SIZE, XDETAIL, YDETAIL, DISTANCE, DELAY,MOON(TRUE OR FALSE),TEXTURE)
    
class drawSphere {

  drawSphere(float R, int xDetail, int yDetail, float distance, float delay, boolean moon, PImage texmap) {
       //rotateZ(frameCount*PI/-delay * 0.005);//This control the rotation of the planets arround the sun

    pushMatrix(); 

    //Orbits
    noFill();
    stroke(200, 90);//control the color of the line/orbit
    strokeWeight(2);//weight of the stroke
    ellipse(0, 0, 2*distance, 2*distance);//create the white ellipse to simulate the route
    //
     noStroke();

    rotateZ(frameCount*PI/-delay * 0.005);//This control the rotation of the planets arround the sun, the ROTATION MOVEMENT
    
    translate(distance, 0, 0);//insert the planets at DISTANCE from the sun
     
  

    //moon-------------------------------------------------------------------------------------------------------------
    if (moon == true)//if a planet has a moon arround it
    {
      pushMatrix();
      noStroke();
      rotateZ(frameCount * -PI/3 * 0.05);//Rotate the moon arround the planet
      translate(0, 40, 0);//distance from the planet
      fill(#aea7a7);//Gray color, no texture used to save image processing
      sphere(5);//size of the moon
      popMatrix();
    }
    //-------------------------------------------------------------------------------------------------------------------
    float[] xGrid = new float[xDetail+1];//Create a xGrid vector according with the xDetail provided
    float[] yGrid = new float[yDetail+1];//Create a yGrid vector according with the yDetail provided
    float[][][] allPoints = new float[xDetail+1][yDetail+1][3];// create a new vector with both, xDetail and yDetail


    // Create a 2D grid of standardized mercator coordinates
    for (int i = 0; i <= xDetail; i++) {
      xGrid[i]= i / (float) xDetail;
    } 
    for (int i = 0; i <= yDetail; i++) {
      yGrid[i]= i / (float) yDetail;
    }

    textureMode(NORMAL);
    // Transform the 2D grid into a grid of points on the sphere, using the inverse mercator projection
    for (int i = 0; i <= xDetail; i++) {
      for (int j = 0; j <= yDetail; j++) {
        allPoints[i][j] = mercatorPoint(R, xGrid[i], yGrid[j]);
      }
    }

    for (int j = 0; j < yDetail; j++) {
      beginShape(TRIANGLE_STRIP);//create a new TRIANGLE_STRIP shape, the sphere as a general shape
      texture(texmap);//used to draw the texture arround the grid of triangles 
      for (int i = 0; i <= xDetail; i++) {//create new triangles to  create a sphere of triangles
        vertex(allPoints[i][j+1][0], allPoints[i][j+1][1], allPoints[i][j+1][2], xGrid[i], yGrid[j+1]);
        vertex(allPoints[i][j][0], allPoints[i][j][1], allPoints[i][j][2], xGrid[i], yGrid[j]);
      }
      endShape(CLOSE);//ends the shape
    }
    popMatrix();
  }    
  float[] mercatorPoint(float R, float x, float y) {//function responsible to create the mercatorPoint, wich will be passed to create 'allPoints'
    float[] thisPoint = new float[3];
    float phi = x*2*PI;
    float theta = PI - y*PI;
    thisPoint[0] = R*sin(theta)*cos(phi);
    thisPoint[1] = R*sin(theta)*sin(phi);
    thisPoint[2] = R*cos(theta);  
    return thisPoint;
  }
  
}


