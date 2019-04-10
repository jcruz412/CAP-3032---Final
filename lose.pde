
// Gets into this state once user has lost
class lose {
  // this is the method that the myLoser object calls
  public void loser() {
    // plays the losr sound once
    if (losePlay) {
      loseSound.play();
      losePlay = false;
    }
    
    // Prints the necessary background. Notifies the user they did not make it class and final score
    background(flyer);
    textFont(menuFont, 40);
    fill(255);
    text("You did not make it to class! :(", width/2, height/2 - 80);
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
    if (score==0) {
      text("Time ran out", width/2, height/2+150);
    }
    text("Score: " + score, width/2, height/2+200);
  }
}
