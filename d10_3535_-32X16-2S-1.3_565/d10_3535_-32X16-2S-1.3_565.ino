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

uint16_t RAW_DISPLAY[32][16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65504, 0, 0, 0, 0, 0, 63488, 63488, 63488, 63488, 63488, 63488, 0, 0, 0, 65504, 65504, 65504, 0, 0, 0, 0, 63488, 63488, 63488, 63488, 63488, 63488, 0, 0, 65504, 65504, 65504, 65504, 65504, 0, 0, 0, 63488, 0, 63488, 63488, 0, 0, 0, 0, 0, 65504, 65504, 65504, 0, 0, 0, 0, 63488, 0, 63488, 0, 63488, 0, 0, 0, 0, 0, 65504, 0, 0, 0, 0, 0, 63488, 63488, 63488, 0, 0, 63488, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2016, 2016, 2016, 2016, 2016, 2016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2016, 2016, 2016, 2016, 2016, 2016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2016, 0, 0, 0, 0, 2016, 0, 0, 0, 65535, 65535, 65535, 65535, 0, 0, 0, 2016, 0, 0, 2016, 0, 2016, 0, 0, 65535, 65535, 0, 65535, 0, 0, 0, 0, 2016, 0, 0, 2016, 2016, 2016, 0, 0, 0, 65535, 65535, 65535, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 65535, 65535, 65535, 65535, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0, 0, 0, 65535, 0, 0, 0, 31, 31, 31, 31, 31, 31, 0, 0, 0, 0, 0, 0, 65535, 0, 0, 0, 31, 0, 31, 0, 0, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31, 0, 31, 0, 0, 31, 0, 0, 65535, 65535, 65535, 65535, 65535, 0, 0, 0, 0, 31, 31, 31, 31, 31, 0, 0, 65535, 0, 65535, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 65535, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 0, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65535, 0, 0, 0, 65535, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
boolean getStarted;
boolean recievedFlag;
uint16_t i_sp;
uint16_t j_sp;
String string_convert = "";
bool FlagRevers = false;

void parsing() {
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
// $0 0 8484;

// библиотека для работы с матрицей
//#include <RGBmatrixPanel.h>
// установите и скачайте также библиотеку «Adafruit GFX Library»
// «RGBmatrixPanel» наследуется от «Adafruit GFX Library»


// объявляем объект для работы с матрицей
//RGBmatrixPanel matrix(A_Line, B_Line, C_Line, CLK_LED, STB_LED, OE_LED, false);

long color;

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

  Serial.begin(57600);
}

void PANEL_BLACK_ALL() {
  for (byte i = 0; i < 16; i++) {
    for (byte j = 0; j < 32; j++) {
      RAW_DISPLAY[j][i] = 0;
    }
  }
}

byte rgb_i;
void loop() {
  parsing();       // функция парсинга
  if (!getStarted) {
    for (rgb_i = 0; rgb_i < 5; rgb_i++) { //перебираем байты цветов системы rgb (необходимо для задания цвета, сложнее 6 цветов комбинации RGB, системы rgb565 (в зеленом один байт отбрасывается))
      for (byte TSA = 0; TSA < 2; TSA++) {//select activ string. TSA (top string activ)
        digitalWrite(OE_LED, 0);
        digitalWrite(A_Line, !TSA);
        digitalWrite(B_Line, TSA);

        LoadBlock(7, 4 + TSA, 0);
        LoadBlock(15, 4 + TSA, 0);
        LoadBlock(23, 4 + TSA, 0);
        LoadBlock(31, 4 + TSA, 0);
        LoadBlock(7, TSA, 0);
        LoadBlock(15, TSA, 0);
        LoadBlock(23, TSA, 0);
        LoadBlock(31, TSA, 1);

        digitalWrite(STB_LED, 0);
        digitalWrite(OE_LED, 1);
      }
    }
  }
}


void SetRGB(byte x_b, byte y_b) { //задаем цвет пикселя, причем одновременно в верхней и нижней строке
  digitalWrite(R1_LED, ((RAW_DISPLAY[x_b][y_b] & 0xF800) >> 11) & (1 << rgb_i));
  digitalWrite(G1_LED, ((RAW_DISPLAY[x_b][y_b] & 0x7C0) >> 6) & (1 << rgb_i));
  digitalWrite(B1_LED, (RAW_DISPLAY[x_b][y_b] & 0x1F) & (1 << rgb_i));
  digitalWrite(R2_LED, ((RAW_DISPLAY[x_b][y_b + 8] & 0xF800) >> 11) & (1 << rgb_i));
  digitalWrite(G2_LED, ((RAW_DISPLAY[x_b][y_b + 8] & 0x7C0) >> 6) & (1 << rgb_i));
  digitalWrite(B2_LED, (RAW_DISPLAY[x_b][y_b + 8] & 0x1F) & (1 << rgb_i));
}
void Pause_4NOP() {
  asm volatile(
    "nop\n\t"
    "nop\n\t"
    "nop\n\t"
    "nop\n\t"
  );
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
