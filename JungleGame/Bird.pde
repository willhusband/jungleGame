class Bird extends Enemy
{
  
  Bird(int x, int y, int dx, int dy, int lives, int size, int delay, int value)
  {
    super(x,y,dx,dy,lives,size,delay,value);
    
    sprites[0] = loadImage("bird1.png");
    sprites[1] = loadImage("bird5.png");
    sprites[2] = loadImage("bird3.png");
    
    sprites[6] = loadImage("birdCrash.png"); //populating sprites array with unique bird images
  }
  
  @Override
  void move()
  {
    y = y - dy; //bird moves up at constant speed
  }
  
  void render() //works by incrementing imgCount every time draw runs(), then changes value of currentImg depending on value of imgCount
  {
    super.render(); //inherits superclass' render method
    if (imgCount < 30) //creates the flapping animation by switching to different images at certain intervals
    {
      currentImg = 0;
    }
    else if (imgCount < 38)
    {
      currentImg = 1;
    }
    else if (imgCount < 45)
    {
      currentImg = 2; 
    }
    else
    {
      imgCount = 0; //imgCount resets to restart animation
    }
  }
}
