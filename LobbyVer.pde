import processing.serial.*;
Serial comPort;
String pulse1 = "";
String pulse2 = "";
int value1 = 0;
int value2 = 0;
int X1 = 250;
int X2 = 250;
int xObb = 300;
int yObb = 300;
int xVel = 5;
int yVel = 0;
int lobby = 0;
int type = 0;
int Y = 0;
int score1 = 0;
int score2 = 0;
int bounce1 = 0;
int bounce2 = 0;
int AISpeed = 3;
int pause = 1;

void setup() {
  size(600, 600);    //設定介面大小
  comPort = new Serial(this, "COM7", 115200);  //取得開發版相關資訊
  yVel = int(random(-7, 7));
  textSize(20);      //設定文字大小
}

void draw() {
  pulse1 = comPort.readStringUntil('\t');    //取得"\t"以前的值
  pulse2 = comPort.readStringUntil('\n');    //取得"\n"以前的值
  if (lobby == 0) {        //大廳參數
    drawLobby();
  }
  if (lobby != 0) {
    if (pause == 1) {
      updatePosition();
    }
    drawObjects();
  }
}

void keyReleased() {
  if (lobby == 0) {      //大廳狀態
    if (key == 's' || keyCode == DOWN) {
      Y = Y + 1;
    }
    if (key == 'w' || keyCode == UP) {
      Y = Y - 1;
    }
    if (Y < 0) {
      Y = 0;
    }
    if (Y > 1) {
      Y = 1;
    }
    if (key == ' ' || keyCode == ENTER || key == 'd' || keyCode == RIGHT) {
      lobby = 1;
      type = Y;
      score1 = 0;
      score2 = 0;
      bounce1 = 0;
      bounce2 = 0;
    }
  }
  if (key == 'l') {
    if(lobby == 0) {
      lobby = 1;
    }
    else {
      lobby = 0;
    }
  }
  if (lobby == 1) {
    if (keyPressed && key == ' ') {
      if (pause == 1) {
        pause = 0;
      } 
      else {
        pause = 1;
      }
    }
  }
}

/*void mouseClicked() {
  if (mouseY <= 50) {
      if (lobby == 1) {
        lobby = 0;
      }
      else {
        lobby = 1;
      }
    }
}*/

void drawLobby() {    
  if (mouseX >= 10 && mouseX <= 590 && mouseY >= 10 && mouseY <= 590) {
    if (mouseY <= 200) {
      Y = 0;
    }
    if (mouseY >= 200 && mouseY <= 350) {
      Y = 1;
    }
    if (mousePressed == true) {
      lobby = 1;
      type = Y;
      score1 = 0;
      score2 = 0;
      bounce1 = 0;
      bounce2 = 0;
    }
  }
  background(50);    //介面
  text("PING PONG", 250, 25);
  text("singleplayer", 245, 100);
  text("multiplayer", 245, 250);
  rect(25, 250, 10, 100);
  rect(565, 250, 10, 100);
  if (Y == 0) {
    ellipse(200, 93, 20, 20);    //ellipie在這是圓形
  }
    if (Y == 1) {
    ellipse(200, 243, 20, 20);
  }
}

void updatePosition() {
  if (lobby == 1) {
    if (mousePressed == true && mouseY < X2 + 50) {
        X2 = X2 - 10;
      }
      if (mousePressed == true && mouseY > X2 + 50) {
        X2 = X2 + 10;
      }
    if (type == 0) {
      X1 = X2;
    }
  }
  if(comPort.available() > 0){
    if (pulse1 != null&& pulse2 != null) {
      pulse1 = pulse1.trim();    //去空白
      pulse2 = pulse2.trim();
      pulse1 = pulse1.replaceAll("[^0-9]", "");    //正則式 轉0~9
      pulse2 = pulse2.replaceAll("[^0-9]", "");
      //print("p");//println(pulse);
    }
    value1 = Integer.parseInt(pulse1);     //轉int  
    value2 = Integer.parseInt(pulse2);
    if (type == 0){
      println(value1);
      println(value2);
      if (value1 >= 20) {
        X2 = X2 - 10;
      }
      if (value1 >= 15 && value1 < 20) {
        X2 = X2 - 5;
      }
      if (value1 >= 10 && value1 < 15) {
        X2 = X2 + 5;
      }
      if (value1 < 10) {
        X2 = X2 + 10;
      }
      if (value2 >= 20) {
        X2 = X2 - 10;
      }
      if (value2 >= 15 && value2 < 20) {
        X2 = X2 - 5;
      }
      if (value2 >= 10 && value2 < 15) {
        X2 = X2 + 5;
      }
      if (value2 < 10) {
        X2 = X2 + 10;
      }
      X1 = X2;
    }
    if (type == 1){
      println(value1);
      println(value2);
      if (value1 >= 20) {
        X2 = X2 - 10;
      }
      if (value1 >= 15 && value1 < 20) {
        X2 = X2 - 5;
      }
      if (value1 >= 10 && value1 < 15) {
        X2 = X2 + 5;
      }
      if (value1 < 10) {
        X2 = X2 + 10;
      }
      if (value2 >= 20) {
        X1 = X1 - 10;
      }
      if (value2 >= 15 && value2 < 20) {
        X1 = X1 - 5;
      }
      if (value2 >= 10 && value2 < 15) {
        X1 = X1 + 5;
      }
      if (value2 < 10) {
        X1 = X1 + 10;
      }
    }
  }
  if (keyPressed) {
    if (type == 0) {
      if (keyCode == UP) {
        X2 = X2 - 10;
      }
      if (keyCode == DOWN) {
        X2 = X2 + 10;
      }
      if (key == 'w') {
        X2 = X2 - 10;
      }
      if (key == 's') {
        X2 = X2 + 10;
      }
      X1 = X2;
    }
    if (type == 1) {
      if (keyCode == UP) {
        X2 = X2 - 10;
      }
      if (keyCode == DOWN) {
        X2 = X2 + 10;
        }
      if (key == 'w') {
        X1 = X1 - 10;
      }
      if (key == 's') {
        X1 = X1 + 10;
      }
    }
  }
  /*if (type == 1) {  //AUTO
    if (yObb > X1 + 50 && xObb <= 300) {
      X1 = X1 + int(random(AISpeed - 2, AISpeed + 2));
    }
    if (yObb < X1 + 50 && xObb <= 300) {
      X1 = X1 - int(random(AISpeed - 2, AISpeed + 2));
    }
  }*/
  /*if (type == 1) {  //AUTO
    if (yObb > X1 + 50 && xObb <= 300) {
      X1 = X1 + int(random(AISpeed - 2, AISpeed + 2));
    }
    if (yObb < X1 + 50 && xObb <= 300) {
      X1 = X1 - int(random(AISpeed - 2, AISpeed + 2));
    }
    if (yObb > X2 + 50 && xObb >= 300) {
      X2 = X2 + int(random(AISpeed - 2, AISpeed + 2));
    }
    if (yObb < X2 + 50 && xObb >= 300) {
      X2 = X2 - int(random(AISpeed - 2, AISpeed + 2));
    }
  }*/        //邊界
  if (X1 >= 455) {
      X1 = 455;
      }
  if (X1 <= 45) {
    X1 = 45;
  }
  if (X2 >= 455) {
      X2 = 455;
      }
  if (X2 <= 45) {
    X2 = 45;
  }
  
  if (xVel > 0) {        //彈
    xObb = xObb + xVel + ((bounce1 + bounce2) / 10);
  }
  if (xVel < 0) {
    xObb = xObb + xVel - ((bounce1 + bounce2) / 10);
  }
  yObb = yObb + yVel;
  
  if (xObb <= 45 && xObb >= 35 && X1 <= yObb && (X1 + 100) >= yObb && xVel <= 0) {    //碰判 算分
    xVel = xVel * -1;
    yVel = int(random(-7 - ((bounce1 + bounce2) / 10), 7 + ((bounce1 + bounce2) / 10)));
    bounce1 = bounce1 + 1;
  }
  if (xObb >= 555 && xObb <= 565 && X2 <= yObb && (X2 + 100) >= yObb && xVel >= 0) {
    xVel = xVel * -1;
    yVel = int(random(-7, 7));
    bounce2 = bounce2 + 1;
  }
  if (yObb <= 45 && yVel <= 0) {    //向量反轉
    yVel = yVel * -1;
  }
  if (yObb >= 555 && yVel >= 0) {
    yVel = yVel * -1;
  }
  if (xObb <= 0) {        //分數增加
    xVel = xVel * -1;
    yVel = int(random(-7, 7));
    xObb = 300;
    yObb = 300;
    score1 = score1 + 1;
    bounce1 = 0;
    bounce2 = 0;
  }
  if (xObb >= 600) {
    xVel = xVel * -1;
    yVel = int(random(-7, 7));
    xObb = 300;
    yObb = 300;
    score2 = score2 + 1;
    bounce2 = 0;
    bounce1 = 0;
  }
}

void drawObjects() {
  background(50);    //遊戲介面
  if (type == 0) {
    text("score:", 250, 20);
    text((bounce1 + bounce2) / 10, 315, 20);
  }
  if (type == 1) {
    text("score:", 10, 20);
    text(score2, 75, 20);
    text("score:", 310, 20);
    text(score1, 375, 20);
  }
  rect(25, X1, 10, 100);
  rect(565, X2, 10, 100);
  ellipse(xObb, yObb, 20, 20);
  if (pause == 0) {
    rect(272, 260, 15, 80);
    rect(308, 260, 15, 80);
    text("pause", 270, 380);
  }
}
