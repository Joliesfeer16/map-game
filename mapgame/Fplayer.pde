class FPlayer extends FGameObject {

  int frame;
  int direction;



  FPlayer() {
    super();
    setPosition(380, 800);
    setName("player");
    setRotatable(false);
    setFillColor(red);
    timer=8;
    direction = R;
  }

  void act() {
    collision();
    handleInput();
    animate();
  }
  void collision() {
    if (isTouching("spike")) {
      setPosition(90, 600);
      lives--;
      if (lives==0) {
        setPosition(90, 600);
        lives=5;
      }
    }
    if (isTouching("Lava")) {
      timer--;
      setVelocity(getVelocityX(), -300);
      if (timer==0) {
        setPosition(90, 600);
        lives--;
      }
    }
     if (isTouching("boulder")) { //make it so that only the bottom of boulder and top of player collide
        setPosition(380, 900);
     }
  }

  void handleInput() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (abs(vy) < 0.1) {
      action = idle;
    }

    if (akey) {
      setVelocity(-300, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(300, vy);
      action = run;
      direction = R;
    }
    if (hitGround(player)) {
      if (skey) {
        setVelocity(vx, 300);
      }

      if (wkey) {
        setVelocity(vx, -300);
      }
    }
    if (abs(vy) > 0.1)
      action = jump;
  }

  void animate() {
    if (frame>= action.length) frame=0;
    if (frameCount % 5 ==0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
