3D Space Shooting Game - Processing/Java Game created on 2014 as final assignment for the AudioVisual computing course at Goldsmiths - University of London Development time: 2 weeks

Known bugs:
- Limited FOV (black hole when is too far from the galaxy)

Next steps:
- Implement collisions (when hitting another planet)
- Design and use a cockpit
- Create new and decent models for the enemies


DESCRIPRION:

SUMMARY: 

Galaxy Defender is a 3d shooting game created using Processing (2.1.1) and the Minim Library [1] and my own ‘library’ for the camera (see session 3 or the code for more details). The main scenario is the Milky Way, with all the planets moving around the sun, but the current version enables you to go beyond and explore. The score is based on number of enemies destroyed. The interaction was made to be easiest as possible, being also possible to play using only the mouse. The physics concepts used in the development aims to deliver a cool immersion effect to the player.

CORE elements of the game:

   The main menu – With options like: Play, Instructions, Credits and Exit.
   The player – The main spaceship (1st person camera) with the goal to kill the maximum of enemies possible without run out of health.
   Enemies – Spaceships with different behaviours with the goal to kill the player.
   Scenario – The Milky Way
   Sounds – Sounds effects archived using the Minim library and include different sounds such as the soundtrack, shots, explosions and a red alert.

CONTROLS: 

 Mouse:
    o Moves the camera on X and Y axis.
    o Left button: shoot
    o Middle button: accelerate
    o Right button: reverse gear
    
 Keyboard:
    o SPACE to accelerate and
    o ESC to exit at any time

GAMEPLAY:

The gameplay is quite intuitive. The goal is to survive and kill the maximum of enemies possible without run out of health as explained in the section 2.1. The game flow would be: Open the application →Select your menu option→ (if option = = Start) then play → Kill or be killed → Play again. The player can dodge the shots combining camera movements and rotations.
Next version (already started with an Android version) improvements to turn the game play even more exciting:
     Flocking between the enemies
     Improvement on the Artificial intelligence
     Collision with the planets and effects when it get shot
     Implementation of power-ups randomly placed, such as health and more powerful shots
     Creation of bosses for each X points with extra rewards
     Complex movements such as barrel roll

ADITIONAL ELEMENTS: 

There are some effects to improve the immersion during the gameplay, accomplished by physics or Audio Visual Effects:
     Explosion – When an enemy is killed, also plays a Minim sound when it happens
     Stars – Comes towards the player's direction when accelerates
     Camera Shaking – When the player gets shot
     Fade effect – When the player leaves the galaxy
     Sounds – Themed Soundtrack[2],
    
References
[1] Minim library is available at: http://code.compartmental.net/tools/minim/
[2] Soundtrack by GameBalance available at: http://www.newgrounds.com/audio/listen/561358
[3] Audio effects by Freesound available at: https://www.freesound.org/
[4] Processing reference used during the whole development, available at: http://processing.org/reference/
[5] NASA website, used to set the scale of distance, size and proportion of the solar system used: http://www.nasa.gov/
[6] Solar system scale tool, available at: http://www.exploratorium.edu/ronh/solar_system/
