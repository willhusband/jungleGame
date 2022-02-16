//NOTES:
//the rock class refers to the bananas (I realised bananas would be more fitting for a monkey to drop)
//a lot of the lizard parts of code dont have comments, this is because the bird comments also apply to lizard code in most instances


//importing needed packages

import java.io.File;
import java.io.FileWriter; 
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;


//Declaring objects of the animal class

Player player; //declares the player object

Bird[] birds = new Bird[200]; //makes an array to store all bird instances
int birdCounter = 0; //incremented every time draw() loops, then resets depending on value of delay
int birdIndex = 0; //tells us how many active birds there are in the array -> increments every time birdCounter resets

Rock[] rocks = new Rock[200];
int rockCounter = 0;
int rockIndex = 0;
boolean rockAvailable = true; //turns false after a rock is dropped, then true again depending on value of delay. Used to determine whether another rock can be dropped.

Lizard[] lizards = new Lizard[200]; 
int lizardCounter = 0; 
int lizardIndex = 0;


//Global variables

PImage backgroundDefault; //declare background image
PImage backgroundSplash; //declare alternate, darker background image for splash screens
PImage background;

int platform = 200; //determines how far from the top the platform is
int lineCount = 0; //defined in countLines() then used in makeEntrys() to calculate leaderboard
int score = 0; //starts the score at 0

String name = ""; //holds users inputted username
String finalMessage = ""; //this is used if the player runs out of ammo or enemys to kill

boolean nameTyped = false; //used to determine when the user is done typing username -> otherwise keystrokes used in game like left and right arrows will be recorded as part of username
boolean start = false; //used to determine when the game starts, depends on when user is done typing name
boolean entrysMade = false; //used when makeEntrys() is called to ensure draw() doesn't run it more than once
boolean scoreWritten = false; //used when appendTextToFile() is called to ensure draw() doesn't run it more than once


Entry[] top5 = new Entry[5]; //used to store the entrys with the top 5 scores for the leaderboard

File f = new File("C:\\AAA\\Current\\jungleGame\\JungleGame\\scores.txt"); //location of scores file


void setup()
{ 
  size(1000,1000); //size of screen
  
  frameRate(30); //lower framerate so that crash sequence images can be seen better
 
  backgroundDefault = loadImage("background.png");
  backgroundDefault.resize(width,height); //loads and resizes background
  backgroundSplash = loadImage("backgroundSplash.png");
  backgroundSplash.resize(width,height); //loads splash background
  
  player = new Player(500,0,15,0,3,100,0); //construct player object x,y,dx,dy,lives,size,delay
  player.y = platform - player.size/2; //puts the player on the platform, cant be done in the constructor as it requires another element in the same constructor
  
  for (int i = 0; i < birds.length; i++) //loops once for each element in bird array
  {
    int x = (int) random(width); //determines random x starting position for bird (int() because random() generates float by default, so doesnt cause error)
    birds[i] = new Bird(x,height,0,15,1,100,60,25); //constructs bird objects for each space in array
  }
  
  for (int i = 0; i < rocks.length; i++)
  {
    int x = player.x;
    int y = player.y; //needs to know what height to drop rock from
    rocks [i] = new Rock (x,y,0,15,1,50,60);
  }
  
  for (int i = 0; i < lizards.length; i++)
  {
    int x = (int) random(width);
    lizards[i] = new Lizard(x,height,5,10,1,100,120,100);
    lizards[i].platform = platform; //passes height of platform to lizard class
  }
}




void keyPressed() {
      if (key == '\n') //if enter is pressed
      {
        //nameTyped = true; //lets the program know to stop recording keystrokes as part of name
        start = true; //lets the program know to start the actual game
      }
      else
      {
        if (start == false)
        {          
          name = name + key; //keeps recording keystrokes as long as enter isn't pressed          
        }
      }
}




void draw()
{
  //displays score and different background depending on if the game is running
  if (start == true) 
  {
    image(backgroundDefault,width/2,height/2); //draws background
    fill(165,42,42); //brown
    rect(0,platform,width,50); //draws platform
    textSize(50);
    fill(255,68,23);
    textAlign(RIGHT); //using text align makes it easier to align text on the screen
    text("LIVES: " + player.lives, 19*(width/20), height/10); //displays the number of lives left
    textSize(25);
    textAlign(LEFT);
    text("SCORE: " + score, width/20 , height/10); //displays the number of lives left
  }
  else
  {
    imageMode(CORNER); //while the game is running the image mode gets changed to centre because of the collision algorithm
    image(backgroundSplash,0,0); //draws the splash background
  }
  //start screen
  if (player.lives > 0 && start == false) //determines if the username is still being written
  {
    textSize(60);
    fill(255,0,0);
    textAlign(CENTER); //all text HERE is centered
    text("JUNGLE GAME",width/2,height/3);
    textSize(40);
    text("ENTER YOUR NAME AND PRESS ENTER TO START", width/2, height/2);
    textSize(30);
    text("NAME: " + name,width/2, 2*(height/3)); //shows live name being typed
    //textSize(20);
    //text("HINT: DONT LET THE LIZARDS REACH THE TOP!", width/2,19*height/20);
  }
  //actual game
  else if (player.lives > 0 && start == true) //runs if the player has lives left
  {
    player.update(); //updates player
    birdCounter++; //used in tandem with delay attribute of birds
    rockCounter++; //used in tandem with delay for dropping rocks
    lizardCounter++;   
    
    //keeping player on screen
    if (player.x > width - player.size/2)
    {
      player.x = width - player.size/2;
    }
    if (player.x < 0 + player.size/2)
    {
      player.x = player.size/2;
    }
    
    //ends game if it runs out of enemys so it doesn't cause array out of bounds error
    
    if (birdIndex > birds.length - 1 || lizardIndex > lizards.length - 1)
    {
      finalMessage = "YOU GOT ALL THE ENEMYS, WELL DONE!";
      player.lives = 0; //satisfys the if statement for running the game - line 149
    }
    else if (rockIndex > rocks.length - 1) //or if it runs out of bananas
    {
      finalMessage = "RAN OUT OF AMMUNITION, CALM DOWN!";
      player.lives = 0;
    }
    
    
    //rocks
    //shooting
    if (player.shot == true && rockAvailable == true) //ensures the player has chosen to and is allowed to drop a rock
    {
      rocks[rockIndex].x = player.x; //drops rock from player's location
      rockIndex++; //next rock in array becomes active
      rockAvailable = false; //makes the player unable to drop a rock momentarily
    }
    //updating rocks
    for (int i = 0; i < rockIndex; i++) //loops through all active rocks
    {
      rocks[i].imgCount++; //used in spin animation (render function)
      rocks[i].update();
      for (int b = 0; b < birdIndex; b++) //loops through all active birds
      {
        if (rocks[i].crash(birds[b]))//if any active rock collides with any active bird
        {
          birds[b].crashImage(); //bird's crash image shows
          birds[b].x = width*2; //bird moves off screen, this is because otherwise the crash sequence will keep showing for dead birds when a rock collides with where the bird once was
          birds[b].lives--;//bird loses a life
          score = score + birds[i].value; //score increses depending on value of bird
        }
      }
      for (int b = 0; b < lizardIndex; b++) 
      {
        if (rocks[i].crash(lizards[b]))
        {
          lizards[b].crashImage(); 
          lizards[b].x = width*2;
          lizards[b].lives--; //lizard loses a life
          score = score + lizards[i].value;
        }
      }
    }   
    if (rockCounter > rocks[0].delay) //tells if it has been long enough for another rock to be available
    {
      rockCounter = 0; //resets counter
      rockAvailable = true; //makes another rock available when delay is over
    }
    
    
    //Birds
    
    if (birdCounter > birds[0].delay)//tells if it has been long enough for another bird to become active
    {
      birdCounter = 0; //resets birdCounter when it becomes larger than delay
      birdIndex++; //next bird
    }
    
    for (int i = 0; i < birdIndex; i++) //loops through all active birds
    {
      if (birds[i].lives > 0) //all alive birds, that is
      {
        birds[i].imgCount++; //img count increments for the animation sequence
        birds[i].update(); //updates every alive bird
      }
      if (player.crash(birds[i])) //detects if bird has hit player
      {
        player.crashImage();
        birds[i].x = width*2; //moves the bird off screen
        birds[i].lives--; //bird loses a life
        player.lives--;//player loses a life
      }
    }
    
    //Lizards
    if (lizardCounter > lizards[0].delay)
    {
      lizardCounter = 0; 
      lizardIndex++; 
    }
    
    for (int i = 0; i < lizardIndex; i++) 
    {
      if (lizards[i].lives > 0) 
      {
        lizards[i].playerX = player.x;
        lizards[i].imgCount++; 
        lizards[i].update();
      }
      if (player.crash(lizards[i])) 
      {
        player.crashImage();
        lizards[i].x = width*2;
        lizards[i].lives--; 
        player.lives--;
      }
    }
  }
  else
  {
    start = false; //tells the program to show splash screen again
    textSize(70);
    fill(255,0,0);
    textAlign(CENTER);
    text("GAME OVER!", width/2, height/3);
    textSize(20);
    text(finalMessage, width/2, 2*(height/5));
    textSize(60);
    text("FINAL SCORE: " + score, width/2, height/2);
    textSize(50);
    text("LEADERBOARD:",width/2, 3*(height/5)); //writes game over screen onto screen
    if (entrysMade == false) //makes sure that draw() doesn't write score + name more than once, nor try and calculate leaderboard positions more than once
    {
      appendTextToFile(score,name); //writes score and name to file
      makeEntrys(); //calculates leaderboard
      entrysMade = true;
    }
    textSize(30);
    for(int t = 0; t < 5; t++)
    {
      text(top5[t].score+ "     " + top5[t].name,width/2, 2*(height/3)+ t*50); //writes leaderboard on screen
    }
  }
}




void countLines() //counts the number of lines in scores file so that the array of entrys can be declared to the right size
{
  BufferedReader reader = createReader("C:\\AAA\\Current\\jungleGame\\JungleGame\\scores.txt"); //opens file for reading
  String line = null; //declares line variable
  
  try
  {
    while ((line = reader.readLine()) != null) //while the line being read holds some information...
    {      
      lineCount++; //increments for every line 
    }
    reader.close();//closes file
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
}



void makeEntrys()
{
  countLines(); //gets the number of lines in scores file
  BufferedReader reader = createReader("C:\\AAA\\Current\\jungleGame\\JungleGame\\scores.txt"); //opens file for reading
  String line = null;
  int i = 0;
  Entry[] entrys = new Entry[lineCount]; //declares an array for entrys
  Entry[] entrysBuffer = new Entry[lineCount]; //used to hold values of entrys while they're being sorted
  try
  {
    while ((line = reader.readLine()) != null)
    {
      String[] pieces = split(line, ","); //splits the data on each line where the comma is 
      entrys[i] = new Entry(int(pieces[0]),pieces[1]); //creates an entry object for every line
      i++; //increments to the next space in entrys array
    }
    reader.close();//closes file
  }
   catch (IOException e)
  {
    e.printStackTrace();
  }
  
  for (int j = 0; j < lineCount - 1; j++) //runs for every item in array
  {
    for (int index = 0; index < lineCount - 1 - j; index++) //runs once for every value above it
    {      
      if (entrys[index].score < entrys[index + 1].score) //if the score for one is entry is smaller than the next they switch positions (we want the largest to be in entrys[0])
      {
        entrysBuffer[index] = new Entry(entrys[index].score,entrys[index].name); //creates a duplicate of entry
        entrys[index].score = entrys[index + 1].score; //overwrites next entry
        entrys[index].name = entrys[index + 1].name;
        entrys[index + 1].score = entrysBuffer[index].score; //overwrites old entry with duplicate
        entrys[index + 1].name = entrysBuffer[index].name;
      }
    }
  }
  for (int t = 0; t < 5; t++)
  {
    top5[t] = new Entry(entrys[t].score,entrys[t].name); //populates the top5 array with the first 5 values of the now sorted entrys array. - needs to be a seperate array as the entrys array is local to makeEntrys()
  }
}





void appendTextToFile(int score, String name) //takes the achieved score and inputted name
{
    try
    {
      PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));  //opens file for appending - the file would be overwritten every time if this was set to false
      out.println(score + "," + name); //writes the name and score
      out.close(); //closes file
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
}
