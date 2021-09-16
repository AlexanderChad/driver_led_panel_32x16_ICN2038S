#define R1_LED 2
#define G1_LED 3
#define B1_LED 4
#define R2_LED 5
#define G2_LED 6
#define B2_LED 7
#define A_Line 14
#define B_Line 15

#define CLK_LED 8
#define OE_LED 9
#define STB_LED 10

#define DEBUG

uint16_t TOnLP;
uint16_t TOffLP;
uint8_t RAW_DISPLAY[32][16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 6, 6, 6, 6, 6, 0, 0, 0, 4, 0, 4, 4, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 0, 4, 0, 4, 0, 4, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 4, 4, 4, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 0, 0, 0, 7, 7, 7, 7, 0, 0, 0, 2, 0, 0, 2, 0, 2, 0, 0, 7, 7, 0, 7, 0, 0, 0, 0, 2, 0, 0, 2, 2, 2, 0, 0, 0, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 7, 7, 7, 7, 7, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 7, 0, 7, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 7, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

#ifdef DEBUG
boolean getStarted;
boolean recievedFlag;
uint16_t i_sp;
uint16_t j_sp;
String string_convert = "";
bool FlagRevers = false;
void parsing() {// start char: '$', <data>, stop: ';'.
  if (Serial.available() > 0) {
    char incomingByte = Serial.read();        // обязательно ЧИТАЕМ входящий символ
    if (getStarted) {                         // если приняли начальный символ (парсинг разрешён)
      if (incomingByte != ',' && incomingByte != ';') {   // если это не , И не конец
        string_convert += incomingByte;       // складываем в строку
      } else {                                // если это , или ; конец пакета
        if (j_sp == 32) {
          i_sp++;
          j_sp = 0;
        }
        RAW_DISPLAY[j_sp][i_sp] = string_convert.toInt();  // преобразуем строку в число и кладём в массив
        string_convert = "";                  // очищаем строку
        j_sp++;                              // переходим к парсингу следующего элемента массива
      }
    }
    if (incomingByte == '$') {                // если это $
      getStarted = true;                      // поднимаем флаг, что можно парсить
      i_sp = 0;
      j_sp = 0;
      // сбрасываем индекс
      string_convert = "";                    // очищаем строку
    }
    if (incomingByte == ';') {                // если таки приняли ; - конец парсинга
      getStarted = false;                     // сброс
      recievedFlag = true;                    // флаг на принятие
    }
  }
}
#endif


void setup() {
  pinMode(R1_LED, OUTPUT);
  pinMode(G1_LED, OUTPUT);
  pinMode(B1_LED, OUTPUT);
  pinMode(R2_LED, OUTPUT);
  pinMode(G2_LED, OUTPUT);
  pinMode(B2_LED, OUTPUT);
  pinMode(A_Line, OUTPUT);
  pinMode(B_Line, OUTPUT);

  pinMode(CLK_LED, OUTPUT);
  pinMode(OE_LED, OUTPUT);
  pinMode(STB_LED, OUTPUT);
  digitalWrite(R1_LED, 0);
  digitalWrite(G1_LED, 0);
  digitalWrite(B1_LED, 0);
  digitalWrite(R2_LED, 0);
  digitalWrite(G2_LED, 0);
  digitalWrite(B2_LED, 0);
  digitalWrite(A_Line, 0);
  digitalWrite(B_Line, 0);

  digitalWrite(CLK_LED, 0);
  digitalWrite(OE_LED, 1);
  digitalWrite(STB_LED, 0);
#ifdef DEBUG
  Serial.begin(57600);
#endif
  SetBrightness(10000); //0-65535
}
#ifdef DEBUG
void PANEL_BLACK_ALL() {
  for (byte i = 0; i < 16; i++) {
    for (byte j = 0; j < 32; j++) {
      RAW_DISPLAY[j][i] = 0;
    }
  }
}
#endif


void loop() {
#ifdef DEBUG
  parsing();       // функция парсинга
  if (!getStarted) {
#endif

    //SetBrightness(44);
    LoadAndShowBufOnPanel();


#ifdef DEBUG
  }
#endif
}


void SetRGB(byte x_b, byte y_b) { //задаем цвет пикселя, причем одновременно в верхней и нижней строке
  digitalWrite(R1_LED, RAW_DISPLAY[x_b][y_b] & 0x4);
  digitalWrite(G1_LED, RAW_DISPLAY[x_b][y_b] & 0x2);
  digitalWrite(B1_LED, RAW_DISPLAY[x_b][y_b] & 0x1);
  digitalWrite(R2_LED, RAW_DISPLAY[x_b][y_b + 8] & 0x4);
  digitalWrite(G2_LED, RAW_DISPLAY[x_b][y_b + 8]  & 0x2);
  digitalWrite(B2_LED, RAW_DISPLAY[x_b][y_b + 8]  & 0x1);
}
void Pause_4NOP() {
  asm volatile(
    "nop\n\t"
    "nop\n\t"
    "nop\n\t"
    "nop\n\t"
  );
}

void SetBrightness(uint16_t Panel_Brightness) {
  TOnLP = Panel_Brightness;
  TOffLP = ~Panel_Brightness;
#ifdef DEBUG
  Serial.print("TOnLP=");
  Serial.println(TOnLP);
  Serial.print("TOffLP=");
  Serial.println(TOffLP);
#endif
}

void LoadAndShowBufOnPanel() {
  for (byte TSA = 0; TSA < 2; TSA++) {//select activ string. TSA (top string activ)
    digitalWrite(OE_LED, 0);
    digitalWrite(A_Line, !TSA);
    digitalWrite(B_Line, TSA);
    LoadAllBlocks(TSA);
    digitalWrite(STB_LED, 0);
    //delayMicroseconds(TOnLP);
    digitalWrite(OE_LED, 1);
    delayMicroseconds(TOffLP);
  }
}

void LoadAllBlocks(byte TSA) {
  LoadBlock(7, 4 + TSA, 0);
  LoadBlock(15, 4 + TSA, 0);
  LoadBlock(23, 4 + TSA, 0);
  LoadBlock(31, 4 + TSA, 0);
  LoadBlock(7, TSA, 0);
  LoadBlock(15, TSA, 0);
  LoadBlock(23, TSA, 0);
  LoadBlock(31, TSA, 1);
}

void LoadBlock(byte start_x, byte start_y, boolean lost_block) { //загружаем блок пару выбранных TSA строк (одновременно верхний и нижний)
  int i;
  for (i = start_x; i > start_x - 8; i--) {
    SetRGB(i, start_y);
    digitalWrite(CLK_LED, 1);
    Pause_4NOP();//delayMicroseconds(1);
    digitalWrite(CLK_LED, 0);
  }
  for (i = start_x - 7; i <= start_x; i++) {
    if ((i == start_x - 2) && lost_block) {
      digitalWrite(STB_LED, 1);
    }
    SetRGB(i, start_y + 2);
    digitalWrite(CLK_LED, 1);
    Pause_4NOP();//delayMicroseconds(1);
    digitalWrite(CLK_LED, 0);
  }
}
