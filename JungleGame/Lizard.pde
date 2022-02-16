class Lizard extends Enemy
{ 
  int platform; //determines how high the platform the player stands on is
  int playerX; //determines the players x position
  
  Lizard(int x, int y, int dx, int dy, int lives, int size, int delay, int value)
  {
    super(x,y,dx,dy,lives,size,delay,value);

    sprites[0] = loadImage("lizard1.png");
    sprites[1] = loadImage("lizard2.png");
    sprites[2] = loadImage("lizard3.png");
    sprites[3] = loadImage("lizard4.png");
    sprites[4] = loadImage("lizard5.png");
    sprites[5] = loadImage("lizard6.png"); //populating sprites array with unique lizard images
    
    sprites[6] = loadImage("lizardCrash.png");
  }
  
  void render()
  {
    super.render(); //inherits superclass' render method
    if (y < platform - size/2) //images used when the lizard has reached the platform
    {
      if (playerX > x) //images used when the lizard is to the left of the player
      {
        if (imgCount < 20) //creates the walking animation by switching to different images at certain intervals
        {
          currentImg = 2;
        }
        else if (imgCount < 40)
        {
          currentImg = 3;
        }
        else
        {
          imgCount = 0;
        }
      }
      else //images used when the lizard is to the right of the player
      {
        if (imgCount < 20) 
        {
          currentImg = 4;
        }
        else if (imgCount < 40)
        {
          currentImg = 5;
        }
        else
        {
          imgCount = 0;
        }
      }
    }
    else //images used while the lizard is climbing the screen
    {
      if (imgCount < 20) //creates the climbing animation by switching to different images at certain intervals
      {
        currentImg = 0;
      }
      else if (imgCount < 40)
      {
        currentImg = 1;
      }
      else
      {
        imgCount = 0;
      }
    }
  }
  
  @Override
  void move() //lizard has more complex movement, it moves up the screen while following the player. Then once it's on the platform it walks towards the player
  {
    if (y < platform - size/2) //walking towards player once lizard is on the platform
    {
      if (playerX > x)//determines wich way lizard should be walking
      {
        x = x + dx;
      }
      else
      {
        x = x - dx;
      }
    }
    else //following the player and climbing the screen
    {
      y = y - dy; //climbing screen
      if (playerX > x + size/2) //determines which way the lizard should be moving in x to follow player
      {
        x = x + dx;
      }
      else if (playerX < x - size/2) //+- size/2 is used here because without it the lizard starts vibrating while it is directly under the player
      {
        x = x - dx;
      }
    }
  }
}
