//rock class changes to banana
class Rock extends Animal
{
  
  Rock(int x, int y, int dx, int dy, int lives, int size, int delay)
  {
    super(x,y,dx,dy,lives,size,delay);
    
    sprites[0] = loadImage("nana1.png");
    sprites[1] = loadImage("nana2.png");
    sprites[2] = loadImage("nana3.png");
    sprites[3] = loadImage("nana4.png");//populating sprites array with unique lizard images
    //no crash image for rock as it keeps falling even when it's hit another object
  }
  
  @Override
  void move()
  {
    y = y + dy; //rock moves at constant speed straight down
  }
  void render()
  {
    super.render(); //inherits superclass' render method
    if (imgCount < 8) //creates the spinning animation by switching to different images at certain intervals
    {
      currentImg = 0;
    }
    else if (imgCount < 15)
    {
      currentImg = 1;
    }
    else if (imgCount < 23)
    {
      currentImg = 2; 
    }
    else if (imgCount <= 30)
    {
      currentImg = 3; 
    } 
    else
    {
      imgCount = 0;
    }
  }
}
