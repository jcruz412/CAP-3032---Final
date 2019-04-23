import processing.sound.*;

// Sounds
SoundFile winSound;
SoundFile gameSound;
SoundFile loseSound;


//Variable for menu/buttons
int menuX = 30;
int menuY = 20;
int rectW = 105;
int rectH = 50;

// Counter variables
int savedTime;
int totalTime = 1000;

// For maze hapes
int rectWidth = 200;
int rectHeight = 600;

//Font variable
PFont menuFont;

// Declare Images
PImage flyer;
PImage dennis;
PImage Little;
PImage classPic;

//Score tracking variable
int score = 20000;

// Helps to show the number of barriers in maze
int check = 50;

//highest scores - Store all the scores
int easyHigh = 0;
int hardHigh = 0;
int highScore = 0;

//Booleans to hold screens
boolean play = false;
boolean lockEasy = false;
boolean lockHard = false;
boolean lockWelcome = false;
boolean lose = false;
boolean win = false;
boolean printEasy=false;
boolean printHard=false;
boolean winPlay = false;
boolean losePlay = false;

// Paddle 
boolean left, right;
Paddle easyPaddle, hardPaddle;

// Ball
Ball b;

//Setup Method - loads/defaults
void setup() {

  size(800, 600);
  noStroke();

  // Load all Images
  flyer = loadImage("flyering.jpg");
  flyer.resize(width, height);
  dennis = loadImage("Dennis.jpg");
  dennis.resize(150, 140);
  Little = loadImage("Little.jpg");
  Little.resize(100, 100);
  classPic = loadImage("class.jpg");
  classPic.resize(width, height);
  imageMode(CENTER);
  // Get fonts
  menuFont = loadFont("ComicSansMS-BoldItalic-48.vlw");
  textAlign(CENTER);
  // Set timer
  savedTime = millis();

  // Sounds
  gameSound = new SoundFile(this, "Miisong.mp3");
  winSound = new SoundFile(this, "kids.mp3");
  loseSound = new SoundFile(this, "lose.mp3");

  // Play song
  gameSound.play();

  // Paddle init
  easyPaddle = new Paddle(150, 10);
  hardPaddle = new Paddle(75, 15);
  
  // Ball init
  b = new Ball(width*3/4, height/2, 30, 6, 135);
}

//Draw Method - defaults/runs methods
void draw() {
  // user lost
  if (lose) {
    lost();
    return;
  }

  // if user wins
  if (win) {
    win();
    return;
  }
  background(255);
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(10, 10, 780, 580);

  //Game Methods
  if (play) { // user is in play
    level();
    score();
  } else { // User is in menu
    //Starting Methods
    welcome();
    menu();
    score();
  }
}

//Menu Method - Start/Quit Selection
void menu() {

  // Dennis picture
  image(dennis, width/2, 90+height/2);

  noStroke();

  //Quit button
  fill(255, 0, 0);
  //Change color of box while hovering
  if (mouseX >= menuX && mouseX <= menuX + rectW && mouseY >= menuY && mouseY <= menuY + rectH) {
    fill(255, 0, 0, 50);
  }
  rect(menuX, menuY, rectW, rectH, 5);
  //Text - Quit
  fill(0);
  textFont(menuFont, 40);
  text("Quit", menuX+50, menuY+40);
}

//Welcome Menu Method - Choosing levels, Prompt
void welcome() {
  noStroke();
  //Welcome Text
  fill(0);
  textFont(menuFont, 40);
  text("Escape from Turlington", width/2, height/2 - 100);

  textFont(menuFont, 35);
  text("Choose a level to begin", width/2, height/2);

  textFont(menuFont, 20);
  text("Instructions: ", width/2, height/2+180);

  textFont(menuFont, 16);
  text("Use your mouse to get to the class. You do NOT want to get caught in the black tabling areas", width/2-10, height/2+200);

  pushMatrix();
  //Font Setup
  textAlign(CENTER);
  textFont(menuFont, 25);
  translate(width/2, 2*(height/3));

  //Rectangle Buttons
  fill(255, 255, 0);
  rect(-200, 0, rectW, rectH);


  fill(255, 0, 0);
  rect(100, 0, rectW, rectH);

  //Text for Level Selection Buttons
  fill(0);
  text("easy", -150, 35);
  text("hard", 150, 35);


  //Changes color when hovering
  if (mouseX >= width/2 - 200 && mouseX <= width/2 - rectW && mouseY >= 2*(height/3) && mouseY <= 2*(height/3)+rectH) {
    fill(0, 50);
    rect(-200, 0, rectW, rectH);
  }

  if (mouseX >= width/2 + 100 && mouseX <= width/2 + 200 && mouseY >= 2*(height/3) && mouseY <= 2*(height/3)+rectH) {
    fill(0, 50);
    rect(100, 0, rectW, rectH);
  }
  popMatrix();
}

//Level Play Method - Contains information for game play
void level() {
  resetMatrix();
  //Reset screen
  noFill();
  stroke(0);
  strokeWeight(2);

  //Easy Level
  if (lockEasy) {
    noStroke();
    background(0, 191, 255);
    //Tabling Area - set up maze
    color tableColor = color(0);
    fill(tableColor);

    //Borders
    rect(0, 0, 10, 600);
    rect(0, 0, 800, 8);
    rect(795, 0, 10, 600);

    // Maze
    rect(0, 450, 800, 200);
    rect(0, 500, 800, rectHeight);
    rect(300, 400, 800, 50);
    rect(50, 350, 800, 50);
    rect(0, 250, 750, 50);
    rect(50, 150, 750, 50);
    rect(0, 50, 750, 50);

    //Prompt 
    fill(255);
    text("Get to Little Hall! Time is ticking!", width/2+50, 500);

    // image of class
    image(Little, 50, 50);
    color currColor = color(getRed(), getGreen(), getBlue());

    // If user has hit restricted area. Compared by color
    if (currColor == tableColor) {
      lose = true;
      losePlay = true;
    }

    // User has made it to Little Hall - Update scores and state of the game
    if (mouseX<=100 && mouseY<=50) {
      win = true;
      winPlay = true;
      if (score>easyHigh) {
        easyHigh = score;
        highScore = easyHigh;
      }
    }

    // Countdown - Works as a time that resets. Decreases the Score
    int passedTime = millis()-savedTime;
    if (passedTime>totalTime) {
      savedTime = millis();
      score-=500;
      if (score==0) {
        lose = true;
        losePlay = true;
      }
    }

    easyPaddle.update(b);
    easyPaddle.show();
    b.update();
    b.show();
  }


  //Hard Level
  if (lockHard) {
    background(0, 191, 255);

    noStroke();
    //Tabling Area - set up maze
    color tableColor = color(0);
    fill(tableColor);

    // Draw unrestricted area - if else statements for flashing barriers in maze

    //Borders
    rect(0, 0, 10, 600);
    rect(0, 0, 800, 8);
    rect(795, 0, 10, 600);

    // Flashing barriers
    rect(0, 470, 800, 200);
    if (check%2==0) {
      rect(0, 350, 800, 50);
    } else {
      rect(50, 350, 800, 50);
    }
    if (check%2==0) {
      rect(0, 250, 750, 50);
    } else {
      rect(0, 250, 800, 50);
    }
    if (check%2==0) {
      rect(0, 150, 750, 50);
    } else {
      rect(50, 150, 750, 50);
    }
    if (check%2==0) {
      rect(0, 50, 750, 50);
    } else {
      rect(0, 50, 800, 50);
    }

    // Barriers in the middle of the path
    if (check%2==0) {
      rect(width/2-200, 300, 50, 50);
    } else {
    }
    if (check%2==0) {
      rect(width/2+200, 200, 50, 50);
    } else {
    }
    if (check%2==0) {
      rect(width/2-200, 200, 50, 50);
    } else {
    }
    if (check%2==0) {
      rect(width/2-300, 100, 50, 50);
    } else {
    }
    if (check%2==0) {
      rect(width/2-50, 400, 50, 70);
    } else {
      rect(0, 50, 800, 50);
    }
    if (check%2==0) {
      rect(width/2+100, 300, 50, 50);
    } else {
      //rect(0, 50, 800, 50);
    }

    //Prompt 
    fill(255);
    text("Get to Little Hall! Time is ticking!", width/2+50, 500);
    text("Be careful ;)", width/2-15, 540);

    // image of class
    image(Little, 50, 50);
    color currColor = color(getRed(), getGreen(), getBlue());


    // Check if user has gone to restricted tabling area
    if (currColor == tableColor) {
      lose = true;
      losePlay = true;
    }

    // User has made it to Little hall - Update scores and state of the game
    if (mouseX<=100 && mouseY<=50) {
      win = true;
      winPlay = true;
      if (score>hardHigh) {
        hardHigh = score;
        highScore = hardHigh;
      }
    }

    // Countdown - Works as a time that resets. Decreases the Score
    int passedTime = millis()-savedTime;
    if (passedTime>totalTime) {
      savedTime = millis();
      score-=500;

      check--;
    }

    hardPaddle.update(b);
    hardPaddle.show();
    b.update();
    b.show();
  }

  //Resets welcome screen
  if (lockWelcome) {
    welcome();
    menu();
    score();
  }
}

//Score Method - sets up format for score box
void score() {
  stroke(2);
  fill(0, 0, 255);
  rect(width - menuX - 100, menuY, rectW, rectH);
  fill(255);
  textFont(menuFont, 15);
  text("Score", width - menuX - 50, menuY+20);
  textFont(menuFont, 25);
  text(score, width - menuX - 50, menuY+45);
}

//Mouse Click Method - Chooses and locks screens in play
void mouseClicked() {
  // Lost & reset game
  if (mouseX >= width/2 - 125 && mouseX <= width/2 +125 && mouseY >= height/2-50 && mouseY <= height/2+50 && lose) {
    reset();
  }

  // Win & reset game
  if (mouseX >= width/2 - 125 && mouseX <= width/2 +125 && mouseY >= height/2-50 && mouseY <= height/2+50 && win) {
    reset();
  }
  //Start/Quit Button sets screen to Welcome Screen
  if (mouseX >= menuX && mouseX <= menuX + rectW && mouseY >= menuY && mouseY <= menuY + rectH && play==false) {

    exit();
  }

  //Starts Easy game play
  if (mouseX >= width/2 - 200 && mouseX <= width/2 - rectW && mouseY >= 2*(height/3) && mouseY <= 2*(height/3)+rectH) {
    play = true;
    lockEasy = true;
  }


  //Start Hard game play
  if (mouseX >= width/2 + 100 && mouseX <= width/2 + 200 && mouseY >= 2*(height/3) && mouseY <= 2*(height/3)+rectH) {
    play = true;
    lockHard = true;
  }
}

// Called when a key is pressed
void keyPressed() {
  if (key == 'a' || key == 'A') {
    left = true;
  }
  if (key == 'd' || key == 'D') {
    right = true;
  }
}

// Called when a key is released
void keyReleased() {
  if (key == 'a' || key == 'A') {
    left = false;
  }
  if (key == 'd' || key == 'D') {
    right = false;
  }
}


// Loops in this state once loser has lost. Create lose object 
void lost() {
  lose myLoser = new lose();
  myLoser.loser();
}
// Loops in this state once loser has won. Create win object 
void win() {
  win myWinner = new win();
  myWinner.winner();
}
// Reset game
void reset() {
  lockWelcome = false;
  play = false;
  lockEasy = false;
  lockHard = false;
  lose = false;
  win = false;
  //Reset
  score = 20000;
  easyPaddle.reset();
  hardPaddle.reset();
  b.reset();
}

// Each of the following get the (r,g,b) components of wherever the mouse is pointing to 
float getRed()
{
  loadPixels();
  float red = red(pixels[mouseX + mouseY * width]);
  return red;
}
float getGreen() {
  loadPixels();
  float green = green(pixels[mouseX + mouseY * width]);
  return green;
}
float getBlue() {
  loadPixels();
  float blue = green(pixels[mouseX + mouseY * width]);
  return blue;
}
