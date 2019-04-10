// State where user wins

class win {
  // myWinner object calls this method
  public void winner() {
    
    // play winning sound once
    if (winPlay) {
      winSound.play();
      winPlay = false;
    }
    
    // Updates the background and notifies user that they have won and score
    background(classPic);
    textFont(menuFont, 40);
    fill(255);
    text("Congratulations. You made it to class! :)", width/2, height/2 - 80);
    //Restart button
    fill(255, 0, 0);
    if (mouseX >= width/2 - 125 && mouseX <= width/2 +125 && mouseY >= height/2-50 && mouseY <= height/2+50) {
      fill(0, 50);
    }
    rect(width/2-125, height/2-50, 250, 75, 5);
    //Text - Restart
    fill(255);
    textFont(menuFont, 40);
    text("Restart", width/2, height/2+10);
    
    // Scores
    text("Score: " + score, width/2, height/2+150);
    if (lockEasy) {
      text("Easy High Score: " + easyHigh, width/2, height/2+200);
    }
    if (lockHard) {
      text("Hard high Score: " + hardHigh, width/2, height/2+200);
    }
  }
}
