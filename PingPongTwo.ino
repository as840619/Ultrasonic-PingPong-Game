int const trigRightPin= 3;  //腳位3 trigRight
int const echoRightPin= 2;  //腳位2 echoRight
int const trigLeftPin= 13;  //腳位13 trigLeft
int const echoLeftPin= 12;  //腳位12 echoLeft
int durationLeft;
int durationRight;
int distanceLeft;
int distanceRight;

void setup() {
  Serial.begin(115200);
  pinMode(trigRightPin,OUTPUT);
  pinMode(trigLeftPin,OUTPUT);
  pinMode(echoRightPin,INPUT);
  pinMode(echoLeftPin,INPUT);
  digitalWrite(trigRightPin,LOW);
  digitalWrite(trigLeftPin,LOW);
  }
void loop() {
  digitalWrite(trigRightPin,HIGH); //發射超音波
  delayMicroseconds(10);
  digitalWrite(trigRightPin,LOW);
  durationRight = pulseIn(echoRightPin,HIGH); //超音波發射到接收的時間
  distanceRight = durationRight*0.034/2; //計算距離(cm)
  digitalWrite(trigLeftPin,HIGH); //發射超音波
  delayMicroseconds(10);
  digitalWrite(trigLeftPin,LOW);
  durationLeft = pulseIn(echoLeftPin,HIGH); //超音波發射到接收的時間
  distanceLeft = durationLeft*0.034/2; //計算距離(cm)
  Serial.print(distanceRight);
  Serial.print("\t"); //判斷\t前
  Serial.print(distanceLeft);
  Serial.print("\n"); //判斷\n前
  }
