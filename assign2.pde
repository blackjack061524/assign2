PImage start1, start2, bg1, bg2, fighter, enemy, hp, treasure, end1, end2;
int bg2_x=0;
int hpValue=200;
int treasureWidth=40, treasureHeight=40, treasureX=floor(random(640-treasureWidth)), treasureY=floor(random(40,480-treasureHeight));
int fighterWidth=50, fighterHeight=50, fighterX=580, fighterY=240, fighterSpeed=5;
int enemyWidth=60, enemyHeight=60, enemyX=0, enemyY=floor(random(40,480-enemyHeight)), enemySpeed=3;
boolean upPressed=false, downPressed=false, rightPressed=false, leftPressed=false;

// game state
final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_END=2;
int gameState=GAME_START;


void setup () {
  size(640, 480);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  fighter=loadImage("img/fighter.png");
  enemy=loadImage("img/enemy.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
}


void draw() {
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>380 && mouseY<410){ // detect mouse location
        image(start1,0,0);
        if(mousePressed){
          gameState=GAME_RUN;
        }
      }
      break;
      
      
    case GAME_RUN:
      // background
      image(bg1,bg2_x-640,0);
      image(bg2,bg2_x,0);
      image(bg2,bg2_x-1280,0);
      bg2_x++;
      bg2_x%=1280;
      
      // hp
      colorMode(RGB);
      fill(255,0,0);
      rect(18,15,hpValue,15);
      image(hp,10,10);
      
      // treasure
      image(treasure,treasureX,treasureY);
      
      // fighter movement
      image(fighter,fighterX,fighterY);
      if(rightPressed){
        fighterX+=fighterSpeed;
      }
      if(leftPressed){
        fighterX-=fighterSpeed;
      }
      if(upPressed){
        fighterY-=fighterSpeed;
      }
      if(downPressed){
        fighterY+=fighterSpeed;
      }
      // limit fighter location
      if(fighterX>=width-fighterWidth){
        fighterX=width-fighterWidth;
      }
      if(fighterX<=0){
        fighterX=0;
      }
      if(fighterY>=height-fighterHeight){
        fighterY=height-fighterHeight;
      }
      if(fighterY<=0){
        fighterY=0;
      }
      
      // enemy
      image(enemy,enemyX,enemyY);
      enemyX+=enemySpeed;
      // enemy follow fighter
      if(fighterY>enemyY+1 || fighterY<enemyY-1){
        if(fighterY>enemyY){
          enemyY+=enemySpeed;
        }
        else{
          enemyY-=enemySpeed;
        }
      }
      // limit enemy location
      if(enemyX>width || enemyY+enemyHeight<0 || enemyY>height){
        enemyX=0;
        enemyY=floor(random(40,480-enemyHeight));
      }
      
      // get treasure
      if(fighterX+fighterWidth>=treasureX && fighterX<=treasureX+treasureWidth && fighterY+fighterHeight>=treasureY && fighterY<=treasureY+treasureHeight){
        hpValue+=20;
        if(hpValue>200){ // limit hpValue
          hpValue=200;
        }
        treasureX=floor(random(640-treasureWidth));
        treasureY=floor(random(40,480-treasureHeight));
      }
      
      // hit enemy
      if(fighterX+fighterWidth>=enemyX && fighterX<=enemyX+enemyWidth && fighterY+fighterHeight>=enemyY && fighterY<=enemyY+enemyHeight){
        hpValue-=20;
        enemyX=0;
        enemyY=floor(random(40,480-enemyHeight));
      }
      
      // game end
      if(hpValue==0){
        gameState=GAME_END;
      }
      
      break;
      
      
    case GAME_END:
      image(end2,0,0);
      if(mouseX>210 && mouseX<430 && mouseY>315 && mouseY<345){ // detect mouse location
        image(end1,0,0);
        if(mousePressed){
          gameState=GAME_START;
        }
      }
      break;
  }
}
void keyPressed(){
    if (key==CODED){
      switch(keyCode){
        case UP:
          upPressed=true;
          break;
        case DOWN:
          downPressed=true;
          break;
        case LEFT:
          leftPressed=true;
          break;
        case RIGHT:
          rightPressed=true;
          break;
      }
    }
}


void keyReleased(){
   if (key==CODED){
     switch(keyCode){
       case UP:
         upPressed=false;
         break;
       case DOWN:
         downPressed=false;
         break;
       case LEFT:
         leftPressed=false;
         break;
       case RIGHT:
         rightPressed=false;
         break;
     }
   }
}
