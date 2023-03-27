#include "stm8s.h"

#define R1_LED 'A', 1 //Pin A1
#define G1_LED 'A', 2
#define B1_LED 'A', 3
#define R2_LED 'C', 3 //Pin C3
#define G2_LED 'C', 4
#define B2_LED 'C', 6
#define A_Line 'C', 5
#define B_Line 'C', 7

#define CLK_LED 'D', 3 //Pin D3
#define OE_LED 'D', 4
#define STB_LED 'D', 2


uint8_t TOffLP;
uint32_t RAW_DISPLAY[3][16] = {16777219,41943162,16777225,729611,1141150841,2852426762,1141152779,723066,8388609,20979715,8393089,8210,30931,23234,27137,30819,1,268435579,671088649,269165066,1074041979,2684654602,1074043913,269158523,679477249,291053570,8983475,830808946,172194065,843934243,1112628145,831617906,1,2,3,2,71303169,178257923,71303169,268435458,679477251,289415170,8393553,8627,673,12626,13155,690};

void delay (int us) //create delay function
{
int i =0 ;
int j=0;
for (i=0; i<=us; i++)
{
for (j=0; j<16; j++)
_asm("nop"); //Perform no operation //assembly code
}
}

void digitalWrite(char Port, uint8_t NumP, bool stat) {
switch (Port) {
case 'A':
if(stat){
GPIOA->ODR |= 1 << NumP;
}else{
GPIOA->ODR &= ~(1 << NumP);
}
  break;
case 'C':
if(stat){
GPIOC->ODR |= 1 << NumP;
}else{
GPIOC->ODR &= ~(1 << NumP);
}
  break;
case 'D':
if(stat){
GPIOD->ODR |= 1 << NumP;
}else{
GPIOD->ODR &= ~(1 << NumP);
}
  break;
}
}

void SetRGB(uint8_t x_b, uint8_t y_b) { //задаем цвет пикселя, причем одновременно в верхней и нижней строке
  uint32_t RBG_mask=1uL<<x_b;
  digitalWrite(R1_LED, (RAW_DISPLAY[0][y_b] & RBG_mask)>0);
  digitalWrite(G1_LED, (RAW_DISPLAY[1][y_b] & RBG_mask)>0);
  digitalWrite(B1_LED, (RAW_DISPLAY[2][y_b] & RBG_mask)>0);
  digitalWrite(R2_LED, (RAW_DISPLAY[0][y_b + 8] & RBG_mask)>0);
  digitalWrite(G2_LED, (RAW_DISPLAY[1][y_b + 8]  & RBG_mask)>0);
  digitalWrite(B2_LED, (RAW_DISPLAY[2][y_b + 8]  & RBG_mask)>0);
}

void SetBrightness(uint8_t Panel_Brightness) {
  TOffLP = ~Panel_Brightness;
}

void LoadBlock(uint8_t start_x, uint8_t start_y, bool lost_block) { //загружаем блок пару выбранных TSA строк (одновременно верхний и нижний)
  int i;
  for (i = start_x; i > start_x - 8; i--) {
    SetRGB(i, start_y);
    digitalWrite(CLK_LED, 1);
    //delay(10);//delayMicroseconds(1);
    digitalWrite(CLK_LED, 0);
  }
  for (i = start_x - 7; i <= start_x; i++) {
    if ((i == start_x - 2) && lost_block) {
      digitalWrite(STB_LED, 1);
    }
    SetRGB(i, start_y + 2);
    digitalWrite(CLK_LED, 1);
    //delay(10);//delayMicroseconds(1);
    digitalWrite(CLK_LED, 0);
  }
}

void LoadAllBlocks(uint8_t TSA) {
  LoadBlock(7, 4 + TSA, 0);
  LoadBlock(15, 4 + TSA, 0);
  LoadBlock(23, 4 + TSA, 0);
  LoadBlock(31, 4 + TSA, 0);
  LoadBlock(7, TSA, 0);
  LoadBlock(15, TSA, 0);
  LoadBlock(23, TSA, 0);
  LoadBlock(31, TSA, 1);
}

void LoadAndShowBufOnPanel(void) {
	uint8_t TSA;
  for (TSA = 0; TSA < 2; TSA++) {//select activ string. TSA (top string activ)
    digitalWrite(OE_LED, 0);
    digitalWrite(A_Line, TSA);
    digitalWrite(B_Line, !TSA);
    LoadAllBlocks(TSA);
    digitalWrite(STB_LED, 0);
    digitalWrite(OE_LED, 1);
    delay(TOffLP);//delayMicroseconds(TOffLP);
  }
}

void SetPixel(uint8_t Xp, uint8_t Yp, uint8_t Color3){
	uint32_t Red_p=0;
	uint32_t Green_p=0;
	uint32_t Blue_p=0;
if (Color3 & 0b100) {Red_p=1uL<<Xp;}
if (Color3 & 0b10) {Green_p=1uL<<Xp;}
if (Color3 & 0b1) {Blue_p=1uL<<Xp;}
if (!(RAW_DISPLAY[0][Yp] & Red_p)){
if(Red_p){
RAW_DISPLAY[0][Yp] |= Red_p;
}
else{
RAW_DISPLAY[0][Yp] &= ~(1uL<<Xp);
}
}
if (!(RAW_DISPLAY[1][Yp] & Green_p)){
if(Green_p){
RAW_DISPLAY[1][Yp] |= Green_p;
}
else{
RAW_DISPLAY[1][Yp] &= ~(1uL<<Xp);
}
}
if (!(RAW_DISPLAY[2][Yp] & Blue_p)){
if(Blue_p){
RAW_DISPLAY[2][Yp] |= Blue_p;
}
else{
RAW_DISPLAY[2][Yp] &= ~(1uL<<Xp);
}
}
}

void main(void)
{
	GPIOA->DDR |= (1 << 1)|(1 << 2)|(1 << 3); // pins as output
	GPIOC->DDR |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
	GPIOD->DDR |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);
	GPIOA->CR1 |= (1 << 1)|(1 << 2)|(1 << 3); // pins as push-pull
	GPIOC->CR1 |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
	GPIOD->CR1 |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);
	GPIOA->CR2 |= (1 << 1)|(1 << 2)|(1 << 3); // pins speed 10Mhz
	GPIOC->CR2 |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
	GPIOD->CR2 |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);

    CLK_DeInit();
    CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1); // set 16 MHz for CPU
		
		SetBrightness(0); //0-255
		
		SetPixel(10, 0, 6); //x=10, y=0, color=6=0b110-RGB: R+G=Yellow
		SetPixel(11, 1, 1);
		SetPixel(12, 2, 2);
		SetPixel(13, 3, 3);
		SetPixel(14, 4, 4);
		SetPixel(15, 5, 5);
		SetPixel(16, 6, 7);
		SetPixel(17, 7, 0);

  /* Infinite loop */
  while (1)
  {
		LoadAndShowBufOnPanel();
	}
}

#ifdef USE_FULL_ASSERT
void assert_failed(u8* file, u32 line)
{ 
  while (1){}
}
#endif

