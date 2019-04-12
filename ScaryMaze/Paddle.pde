class Paddle {
  float x;
  float l; // length
  float speed;
  
  Paddle(float l, float speed) {
    this.x = width/2;
    this.l = l;
    this.speed = speed;
  }
  
  void update() {
    if (left && x - l/2 >= 0) {
      x -= speed;
    }
    if (right && x + l/2 <= width) {
      x += speed;
    }
  }
  
  void show() {
    rect(x - l/2, height - 30, l, 20);
  }
  
  void reset() {
    this.x = width/2;
  }
}
