PImage sock;

int SOCK_COUNT = 29;
float[] Xs = new float[SOCK_COUNT];
float[] Ys = new float[SOCK_COUNT];
color[] Colors = new color[SOCK_COUNT];
float[] rots = new float[SOCK_COUNT];

float startTime =0;

int sameIndex =0;
int score = 1;

int scene = 0;

PImage bg;
void setup()
{
  size(800, 800);
  imageMode(CENTER);
  sock = loadImage("sock.png");
  sock.resize(100, 100);

  for (int i=0; i < SOCK_COUNT; i++)
  {
    Xs[i] = random(100, 700);
    Ys[i] = random(100, 700);
    Colors[i] = color(random(255), random(255), random(255));
    rots[i] = random(0, TWO_PI);
  }

  sameIndex = (int)random(0, SOCK_COUNT);
  
  bg = loadImage("sock.png");
  
  bg.resize(800,800);
}




void draw()
{
  //splash screen
  if (scene == 0)
  {
    Intro();
  }
  
  //begin game screen
  if (scene == 1)
  {
    Game();
  }
}







void mousePressed()
{
  
  if(scene == 0)
  {
    scene = 1;
    startTime = millis();
  }
  
  
  
  float distance = dist(mouseX, mouseY, Xs[sameIndex], Ys[sameIndex]);

  if (distance < 50)
  {
    for (int i=0; i < SOCK_COUNT; i++)
    {
      Xs[i] = random(100, 700);
      Ys[i] = random(100, 700);
      Colors[i] = color(random(255), random(255), random(255));
      rots[i] = random(0, TWO_PI);
    }
    sameIndex = (int)random(0, SOCK_COUNT);
    score++;
  } else
  {
    background(255, 0, 0);
    score -= 1;
  }
}


void Game()
{
  background(0);


  textSize(20);
  text(millis()-startTime, width - 100, 30);
  text(score, 30, 30);
  for (int i=0; i < SOCK_COUNT; i++)
  {
    pushMatrix();
    translate(Xs[i], Ys[i]);
    rotate(rots[i]);
    tint(Colors[i]);
    image(sock, 0, 0);
    popMatrix();
  }

  tint(Colors[sameIndex]);
  image(sock, mouseX, mouseY);
}

boolean introSetup = false;
void Intro()
{
  background(0);

  if (!introSetup)
  {
    tint(random(255), random(255), random(255));
    introSetup =true;
  }
  image(sock, 400, 400, 300, 300);
  
  textSize(75);
  textAlign(CENTER);
  text("SOCK MAINIA", 400, 400);
}