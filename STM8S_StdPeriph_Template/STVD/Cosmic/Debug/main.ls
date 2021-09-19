   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
   4                     ; Optimizer V4.5.3 - 16 Jun 2021
  21                     	bsct
  22  0000               _RAW_DISPLAY:
  23  0000 01000003      	dc.l	16777219
  24  0004 0280007a      	dc.l	41943162
  25  0008 01000009      	dc.l	16777225
  26  000c 000b220b      	dc.l	729611
  27  0010 44049479      	dc.l	1141150841
  28  0014 aa04940a      	dc.l	-1442540534
  29  0018 44049c0b      	dc.l	1141152779
  30  001c 000b087a      	dc.l	723066
  31  0020 00800001      	dc.l	8388609
  32  0024 01402003      	dc.l	20979715
  33  0028 00801181      	dc.l	8393089
  34  002c 00002012      	dc.l	8210
  35  0030 000078d3      	dc.l	30931
  36  0034 00005ac2      	dc.l	23234
  37  0038 00006a01      	dc.l	27137
  38  003c 00007863      	dc.l	30819
  39  0040 00000001      	dc.l	1
  40  0044 1000007b      	dc.l	268435579
  41  0048 28000009      	dc.l	671088649
  42  004c 100b220a      	dc.l	269165066
  43  0050 4004947b      	dc.l	1074041979
  44  0054 a004940a      	dc.l	-1610312694
  45  0058 40049c09      	dc.l	1074043913
  46  005c 100b087b      	dc.l	269158523
  47  0060 28800001      	dc.l	679477249
  48  0064 11592002      	dc.l	291053570
  49  0068 008913b3      	dc.l	8983475
  50  006c 31852372      	dc.l	830808946
  51  0070 0a437911      	dc.l	172194065
  52  0074 324d6a23      	dc.l	843934243
  53  0078 42515bb1      	dc.l	1112628145
  54  007c 31917b72      	dc.l	831617906
  55  0080 00000001      	dc.l	1
  56  0084 00000002      	dc.l	2
  57  0088 00000003      	dc.l	3
  58  008c 00000002      	dc.l	2
  59  0090 04400001      	dc.l	71303169
  60  0094 0aa00003      	dc.l	178257923
  61  0098 04400001      	dc.l	71303169
  62  009c 10000002      	dc.l	268435458
  63  00a0 28800003      	dc.l	679477251
  64  00a4 11402002      	dc.l	289415170
  65  00a8 00801351      	dc.l	8393553
  66  00ac 000021b3      	dc.l	8627
  67  00b0 000002a1      	dc.l	673
  68  00b4 00003152      	dc.l	12626
  69  00b8 00003363      	dc.l	13155
  70  00bc 000002b2      	dc.l	690
 129                     ; 20 void delay (int us) //create delay function
 129                     ; 21 {
 131                     .text:	section	.text,new
 132  0000               _delay:
 134  0000 89            	pushw	x
 135  0001 5204          	subw	sp,#4
 136       00000004      OFST:	set	4
 139                     ; 22 int i =0 ;
 141                     ; 23 int j=0;
 143                     ; 24 for (i=0; i<=us; i++)
 145  0003 5f            	clrw	x
 147  0004 200d          	jra	L34
 148  0006               L73:
 149                     ; 26 for (j=0; j<16; j++)
 151  0006 5f            	clrw	x
 153  0007               L74:
 154                     ; 27 _asm("nop"); //Perform no operation //assembly code
 158  0007 9d            	nop	
 160                     ; 26 for (j=0; j<16; j++)
 162  0008 5c            	incw	x
 165  0009 a30010        	cpw	x,#16
 166  000c 2ff9          	jrslt	L74
 167  000e 1f03          	ldw	(OFST-1,sp),x
 169                     ; 24 for (i=0; i<=us; i++)
 171  0010 1e01          	ldw	x,(OFST-3,sp)
 172  0012 5c            	incw	x
 173  0013               L34:
 174  0013 1f01          	ldw	(OFST-3,sp),x
 178  0015 1305          	cpw	x,(OFST+1,sp)
 179  0017 2ded          	jrsle	L73
 180                     ; 29 }
 183  0019 5b06          	addw	sp,#6
 184  001b 81            	ret	
 257                     ; 31 void digitalWrite(char Port, uint8_t NumP, bool stat) {
 258                     .text:	section	.text,new
 259  0000               _digitalWrite:
 261  0000 89            	pushw	x
 262       00000000      OFST:	set	0
 265                     ; 32 switch (Port) {
 267  0001 9e            	ld	a,xh
 269                     ; 53   break;
 270  0002 a041          	sub	a,#65
 271  0004 2709          	jreq	L55
 272  0006 a002          	sub	a,#2
 273  0008 272e          	jreq	L75
 274  000a 4a            	dec	a
 275  000b 2751          	jreq	L16
 276  000d 2073          	jra	L321
 277  000f               L55:
 278                     ; 33 case 'A':
 278                     ; 34 if(stat){
 280  000f 7b05          	ld	a,(OFST+5,sp)
 281  0011 2712          	jreq	L521
 282                     ; 35 GPIOA->ODR |= 1 << NumP;
 284  0013 7b02          	ld	a,(OFST+2,sp)
 285  0015 ad6d          	call	LC003
 286  0017 2704          	jreq	L01
 287  0019               L21:
 288  0019 48            	sll	a
 289  001a 5a            	decw	x
 290  001b 26fc          	jrne	L21
 291  001d               L01:
 292  001d ca5000        	or	a,20480
 293  0020 c75000        	ld	20480,a
 295  0023 205d          	jra	L321
 296  0025               L521:
 297                     ; 37 GPIOA->ODR &= ~(1 << NumP);
 299  0025 7b02          	ld	a,(OFST+2,sp)
 300  0027 ad5b          	call	LC003
 301  0029 2704          	jreq	L41
 302  002b               L61:
 303  002b 48            	sll	a
 304  002c 5a            	decw	x
 305  002d 26fc          	jrne	L61
 306  002f               L41:
 307  002f 43            	cpl	a
 308  0030 c45000        	and	a,20480
 309  0033 c75000        	ld	20480,a
 310  0036 204a          	jra	L321
 311  0038               L75:
 312                     ; 40 case 'C':
 312                     ; 41 if(stat){
 314  0038 7b05          	ld	a,(OFST+5,sp)
 315  003a 270f          	jreq	L131
 316                     ; 42 GPIOC->ODR |= 1 << NumP;
 318  003c 7b02          	ld	a,(OFST+2,sp)
 319  003e ad44          	call	LC003
 320  0040 2704          	jreq	L02
 321  0042               L22:
 322  0042 48            	sll	a
 323  0043 5a            	decw	x
 324  0044 26fc          	jrne	L22
 325  0046               L02:
 326  0046 ca500a        	or	a,20490
 328  0049 200e          	jp	LC002
 329  004b               L131:
 330                     ; 44 GPIOC->ODR &= ~(1 << NumP);
 332  004b 7b02          	ld	a,(OFST+2,sp)
 333  004d ad35          	call	LC003
 334  004f 2704          	jreq	L42
 335  0051               L62:
 336  0051 48            	sll	a
 337  0052 5a            	decw	x
 338  0053 26fc          	jrne	L62
 339  0055               L42:
 340  0055 43            	cpl	a
 341  0056 c4500a        	and	a,20490
 342  0059               LC002:
 343  0059 c7500a        	ld	20490,a
 344  005c 2024          	jra	L321
 345  005e               L16:
 346                     ; 47 case 'D':
 346                     ; 48 if(stat){
 348  005e 7b05          	ld	a,(OFST+5,sp)
 349  0060 270f          	jreq	L531
 350                     ; 49 GPIOD->ODR |= 1 << NumP;
 352  0062 7b02          	ld	a,(OFST+2,sp)
 353  0064 ad1e          	call	LC003
 354  0066 2704          	jreq	L03
 355  0068               L23:
 356  0068 48            	sll	a
 357  0069 5a            	decw	x
 358  006a 26fc          	jrne	L23
 359  006c               L03:
 360  006c ca500f        	or	a,20495
 362  006f 200e          	jp	LC001
 363  0071               L531:
 364                     ; 51 GPIOD->ODR &= ~(1 << NumP);
 366  0071 7b02          	ld	a,(OFST+2,sp)
 367  0073 ad0f          	call	LC003
 368  0075 2704          	jreq	L43
 369  0077               L63:
 370  0077 48            	sll	a
 371  0078 5a            	decw	x
 372  0079 26fc          	jrne	L63
 373  007b               L43:
 374  007b 43            	cpl	a
 375  007c c4500f        	and	a,20495
 376  007f               LC001:
 377  007f c7500f        	ld	20495,a
 378  0082               L321:
 379                     ; 55 }
 382  0082 85            	popw	x
 383  0083 81            	ret	
 384  0084               LC003:
 385  0084 5f            	clrw	x
 386  0085 97            	ld	xl,a
 387  0086 a601          	ld	a,#1
 388  0088 5d            	tnzw	x
 389  0089 81            	ret	
 443                     ; 57 void SetRGB(uint8_t x_b, uint8_t y_b) { //задаем цвет пикселя, причем одновременно в верхней и нижней строке
 444                     .text:	section	.text,new
 445  0000               _SetRGB:
 447  0000 89            	pushw	x
 448  0001 5204          	subw	sp,#4
 449       00000004      OFST:	set	4
 452                     ; 58   uint32_t RBG_mask=1uL<<x_b;
 454  0003 ae0001        	ldw	x,#1
 455  0006 bf02          	ldw	c_lreg+2,x
 456  0008 5f            	clrw	x
 457  0009 bf00          	ldw	c_lreg,x
 458  000b 7b05          	ld	a,(OFST+1,sp)
 459  000d cd0000        	call	c_llsh
 461  0010 96            	ldw	x,sp
 462  0011 5c            	incw	x
 463  0012 cd0000        	call	c_rtol
 466                     ; 59   digitalWrite(R1_LED, (RAW_DISPLAY[0][y_b] & RBG_mask)>0);
 468  0015 7b06          	ld	a,(OFST+2,sp)
 469  0017 cd00cb        	call	LC005
 470  001a 1c0000        	addw	x,#_RAW_DISPLAY
 471  001d cd0000        	call	c_ltor
 473  0020 96            	ldw	x,sp
 474  0021 cd00c4        	call	LC004
 476  0024 2704          	jreq	L44
 477  0026 a601          	ld	a,#1
 478  0028 2001          	jra	L64
 479  002a               L44:
 480  002a 4f            	clr	a
 481  002b               L64:
 482  002b 88            	push	a
 483  002c ae4101        	ldw	x,#16641
 484  002f cd0000        	call	_digitalWrite
 486  0032 84            	pop	a
 487                     ; 60   digitalWrite(G1_LED, (RAW_DISPLAY[1][y_b] & RBG_mask)>0);
 489  0033 7b06          	ld	a,(OFST+2,sp)
 490  0035 cd00cb        	call	LC005
 491  0038 1c0040        	addw	x,#_RAW_DISPLAY+64
 492  003b cd0000        	call	c_ltor
 494  003e 96            	ldw	x,sp
 495  003f cd00c4        	call	LC004
 497  0042 2704          	jreq	L25
 498  0044 a601          	ld	a,#1
 499  0046 2001          	jra	L45
 500  0048               L25:
 501  0048 4f            	clr	a
 502  0049               L45:
 503  0049 88            	push	a
 504  004a ae4102        	ldw	x,#16642
 505  004d cd0000        	call	_digitalWrite
 507  0050 84            	pop	a
 508                     ; 61   digitalWrite(B1_LED, (RAW_DISPLAY[2][y_b] & RBG_mask)>0);
 510  0051 7b06          	ld	a,(OFST+2,sp)
 511  0053 ad76          	call	LC005
 512  0055 1c0080        	addw	x,#_RAW_DISPLAY+128
 513  0058 cd0000        	call	c_ltor
 515  005b 96            	ldw	x,sp
 516  005c ad66          	call	LC004
 518  005e 2704          	jreq	L06
 519  0060 a601          	ld	a,#1
 520  0062 2001          	jra	L26
 521  0064               L06:
 522  0064 4f            	clr	a
 523  0065               L26:
 524  0065 88            	push	a
 525  0066 ae4103        	ldw	x,#16643
 526  0069 cd0000        	call	_digitalWrite
 528  006c 84            	pop	a
 529                     ; 62   digitalWrite(R2_LED, (RAW_DISPLAY[0][y_b + 8] & RBG_mask)>0);
 531  006d 7b06          	ld	a,(OFST+2,sp)
 532  006f ad5a          	call	LC005
 533  0071 1c0020        	addw	x,#_RAW_DISPLAY+32
 534  0074 cd0000        	call	c_ltor
 536  0077 96            	ldw	x,sp
 537  0078 ad4a          	call	LC004
 539  007a 2704          	jreq	L66
 540  007c a601          	ld	a,#1
 541  007e 2001          	jra	L07
 542  0080               L66:
 543  0080 4f            	clr	a
 544  0081               L07:
 545  0081 88            	push	a
 546  0082 ae4303        	ldw	x,#17155
 547  0085 cd0000        	call	_digitalWrite
 549  0088 84            	pop	a
 550                     ; 63   digitalWrite(G2_LED, (RAW_DISPLAY[1][y_b + 8]  & RBG_mask)>0);
 552  0089 7b06          	ld	a,(OFST+2,sp)
 553  008b ad3e          	call	LC005
 554  008d 1c0060        	addw	x,#_RAW_DISPLAY+96
 555  0090 cd0000        	call	c_ltor
 557  0093 96            	ldw	x,sp
 558  0094 ad2e          	call	LC004
 560  0096 2704          	jreq	L47
 561  0098 a601          	ld	a,#1
 562  009a 2001          	jra	L67
 563  009c               L47:
 564  009c 4f            	clr	a
 565  009d               L67:
 566  009d 88            	push	a
 567  009e ae4304        	ldw	x,#17156
 568  00a1 cd0000        	call	_digitalWrite
 570  00a4 84            	pop	a
 571                     ; 64   digitalWrite(B2_LED, (RAW_DISPLAY[2][y_b + 8]  & RBG_mask)>0);
 573  00a5 7b06          	ld	a,(OFST+2,sp)
 574  00a7 ad22          	call	LC005
 575  00a9 1c00a0        	addw	x,#_RAW_DISPLAY+160
 576  00ac cd0000        	call	c_ltor
 578  00af 96            	ldw	x,sp
 579  00b0 ad12          	call	LC004
 581  00b2 2704          	jreq	L201
 582  00b4 a601          	ld	a,#1
 583  00b6 2001          	jra	L401
 584  00b8               L201:
 585  00b8 4f            	clr	a
 586  00b9               L401:
 587  00b9 88            	push	a
 588  00ba ae4306        	ldw	x,#17158
 589  00bd cd0000        	call	_digitalWrite
 591  00c0 84            	pop	a
 592                     ; 65 }
 595  00c1 5b06          	addw	sp,#6
 596  00c3 81            	ret	
 597  00c4               LC004:
 598  00c4 5c            	incw	x
 599  00c5 cd0000        	call	c_land
 601  00c8 cc0000        	jp	c_lrzmp
 602  00cb               LC005:
 603  00cb 97            	ld	xl,a
 604  00cc a604          	ld	a,#4
 605  00ce 42            	mul	x,a
 606  00cf 81            	ret	
 641                     ; 67 void SetBrightness(uint8_t Panel_Brightness) {
 642                     .text:	section	.text,new
 643  0000               _SetBrightness:
 647                     ; 68   TOffLP = ~Panel_Brightness;
 649  0000 43            	cpl	a
 650  0001 b700          	ld	_TOffLP,a
 651                     ; 69 }
 654  0003 81            	ret	
 718                     ; 71 void LoadBlock(uint8_t start_x, uint8_t start_y, bool lost_block) { //загружаем блок пару выбранных TSA строк (одновременно верхний и нижний)
 719                     .text:	section	.text,new
 720  0000               _LoadBlock:
 722  0000 89            	pushw	x
 723  0001 89            	pushw	x
 724       00000002      OFST:	set	2
 727                     ; 73   for (i = start_x; i > start_x - 8; i--) {
 729  0002 9e            	ld	a,xh
 730  0003 5f            	clrw	x
 731  0004 97            	ld	xl,a
 733  0005 200a          	jra	L342
 734  0007               L732:
 735                     ; 74     SetRGB(i, start_y);
 737  0007 7b04          	ld	a,(OFST+2,sp)
 738  0009 97            	ld	xl,a
 739  000a 7b02          	ld	a,(OFST+0,sp)
 740  000c ad4a          	call	LC006
 741                     ; 73   for (i = start_x; i > start_x - 8; i--) {
 743  000e 1e01          	ldw	x,(OFST-1,sp)
 744  0010 5a            	decw	x
 745  0011               L342:
 746  0011 1f01          	ldw	(OFST-1,sp),x
 750  0013 5f            	clrw	x
 751  0014 7b03          	ld	a,(OFST+1,sp)
 752  0016 97            	ld	xl,a
 753  0017 1d0008        	subw	x,#8
 754  001a 1301          	cpw	x,(OFST-1,sp)
 755  001c 2fe9          	jrslt	L732
 756                     ; 79   for (i = start_x - 7; i <= start_x; i++) {
 758  001e 5f            	clrw	x
 759  001f 97            	ld	xl,a
 760  0020 1d0007        	subw	x,#7
 762  0023 2022          	jra	L352
 763  0025               L742:
 764                     ; 80     if ((i == start_x - 2) && lost_block) {
 766  0025 5f            	clrw	x
 767  0026 97            	ld	xl,a
 768  0027 1d0002        	subw	x,#2
 769  002a 1301          	cpw	x,(OFST-1,sp)
 770  002c 260d          	jrne	L752
 772  002e 7b07          	ld	a,(OFST+5,sp)
 773  0030 2709          	jreq	L752
 774                     ; 81       digitalWrite(STB_LED, 1);
 776  0032 4b01          	push	#1
 777  0034 ae4402        	ldw	x,#17410
 778  0037 cd0000        	call	_digitalWrite
 780  003a 84            	pop	a
 781  003b               L752:
 782                     ; 83     SetRGB(i, start_y + 2);
 784  003b 7b04          	ld	a,(OFST+2,sp)
 785  003d ab02          	add	a,#2
 786  003f 97            	ld	xl,a
 787  0040 7b02          	ld	a,(OFST+0,sp)
 788  0042 ad14          	call	LC006
 789                     ; 79   for (i = start_x - 7; i <= start_x; i++) {
 791  0044 1e01          	ldw	x,(OFST-1,sp)
 792  0046 5c            	incw	x
 793  0047               L352:
 794  0047 1f01          	ldw	(OFST-1,sp),x
 798  0049 5f            	clrw	x
 799  004a 7b03          	ld	a,(OFST+1,sp)
 800  004c 97            	ld	xl,a
 801  004d bf00          	ldw	c_x,x
 802  004f 1e01          	ldw	x,(OFST-1,sp)
 803  0051 b300          	cpw	x,c_x
 804  0053 2dd0          	jrsle	L742
 805                     ; 88 }
 808  0055 5b04          	addw	sp,#4
 809  0057 81            	ret	
 810  0058               LC006:
 811  0058 95            	ld	xh,a
 812  0059 cd0000        	call	_SetRGB
 814                     ; 75     digitalWrite(CLK_LED, 1);
 816  005c 4b01          	push	#1
 817  005e ae4403        	ldw	x,#17411
 818  0061 cd0000        	call	_digitalWrite
 820  0064 84            	pop	a
 821                     ; 77     digitalWrite(CLK_LED, 0);
 823  0065 4b00          	push	#0
 824  0067 ae4403        	ldw	x,#17411
 825  006a cd0000        	call	_digitalWrite
 827  006d 84            	pop	a
 828  006e 81            	ret	
 863                     ; 90 void LoadAllBlocks(uint8_t TSA) {
 864                     .text:	section	.text,new
 865  0000               _LoadAllBlocks:
 867  0000 88            	push	a
 868       00000000      OFST:	set	0
 871                     ; 91   LoadBlock(7, 4 + TSA, 0);
 873  0001 4b00          	push	#0
 874  0003 ab04          	add	a,#4
 875  0005 ae0700        	ldw	x,#1792
 876  0008 97            	ld	xl,a
 877  0009 cd0000        	call	_LoadBlock
 879  000c 84            	pop	a
 880                     ; 92   LoadBlock(15, 4 + TSA, 0);
 882  000d 4b00          	push	#0
 883  000f 7b02          	ld	a,(OFST+2,sp)
 884  0011 ab04          	add	a,#4
 885  0013 ae0f00        	ldw	x,#3840
 886  0016 97            	ld	xl,a
 887  0017 cd0000        	call	_LoadBlock
 889  001a 84            	pop	a
 890                     ; 93   LoadBlock(23, 4 + TSA, 0);
 892  001b 4b00          	push	#0
 893  001d 7b02          	ld	a,(OFST+2,sp)
 894  001f ab04          	add	a,#4
 895  0021 ae1700        	ldw	x,#5888
 896  0024 97            	ld	xl,a
 897  0025 cd0000        	call	_LoadBlock
 899  0028 84            	pop	a
 900                     ; 94   LoadBlock(31, 4 + TSA, 0);
 902  0029 4b00          	push	#0
 903  002b 7b02          	ld	a,(OFST+2,sp)
 904  002d ab04          	add	a,#4
 905  002f ae1f00        	ldw	x,#7936
 906  0032 97            	ld	xl,a
 907  0033 cd0000        	call	_LoadBlock
 909  0036 84            	pop	a
 910                     ; 95   LoadBlock(7, TSA, 0);
 912  0037 4b00          	push	#0
 913  0039 7b02          	ld	a,(OFST+2,sp)
 914  003b ae0700        	ldw	x,#1792
 915  003e 97            	ld	xl,a
 916  003f cd0000        	call	_LoadBlock
 918  0042 84            	pop	a
 919                     ; 96   LoadBlock(15, TSA, 0);
 921  0043 4b00          	push	#0
 922  0045 7b02          	ld	a,(OFST+2,sp)
 923  0047 ae0f00        	ldw	x,#3840
 924  004a 97            	ld	xl,a
 925  004b cd0000        	call	_LoadBlock
 927  004e 84            	pop	a
 928                     ; 97   LoadBlock(23, TSA, 0);
 930  004f 4b00          	push	#0
 931  0051 7b02          	ld	a,(OFST+2,sp)
 932  0053 ae1700        	ldw	x,#5888
 933  0056 97            	ld	xl,a
 934  0057 cd0000        	call	_LoadBlock
 936  005a 84            	pop	a
 937                     ; 98   LoadBlock(31, TSA, 1);
 939  005b 4b01          	push	#1
 940  005d 7b02          	ld	a,(OFST+2,sp)
 941  005f ae1f00        	ldw	x,#7936
 942  0062 97            	ld	xl,a
 943  0063 cd0000        	call	_LoadBlock
 945                     ; 99 }
 948  0066 5b02          	addw	sp,#2
 949  0068 81            	ret	
 988                     ; 101 void LoadAndShowBufOnPanel(void) {
 989                     .text:	section	.text,new
 990  0000               _LoadAndShowBufOnPanel:
 992  0000 88            	push	a
 993       00000001      OFST:	set	1
 996                     ; 103   for (TSA = 0; TSA < 2; TSA++) {//select activ string. TSA (top string activ)
 998  0001 0f01          	clr	(OFST+0,sp)
1000  0003               L513:
1001                     ; 104     digitalWrite(OE_LED, 0);
1003  0003 4b00          	push	#0
1004  0005 ae4404        	ldw	x,#17412
1005  0008 cd0000        	call	_digitalWrite
1007  000b 84            	pop	a
1008                     ; 105     digitalWrite(A_Line, !TSA);
1010  000c 7b01          	ld	a,(OFST+0,sp)
1011  000e 2603          	jrne	L061
1012  0010 4c            	inc	a
1013  0011 2001          	jra	L261
1014  0013               L061:
1015  0013 4f            	clr	a
1016  0014               L261:
1017  0014 88            	push	a
1018  0015 ae4305        	ldw	x,#17157
1019  0018 cd0000        	call	_digitalWrite
1021  001b 84            	pop	a
1022                     ; 106     digitalWrite(B_Line, TSA);
1024  001c 7b01          	ld	a,(OFST+0,sp)
1025  001e 88            	push	a
1026  001f ae4307        	ldw	x,#17159
1027  0022 cd0000        	call	_digitalWrite
1029  0025 84            	pop	a
1030                     ; 107     LoadAllBlocks(TSA);
1032  0026 7b01          	ld	a,(OFST+0,sp)
1033  0028 cd0000        	call	_LoadAllBlocks
1035                     ; 108     digitalWrite(STB_LED, 0);
1037  002b 4b00          	push	#0
1038  002d ae4402        	ldw	x,#17410
1039  0030 cd0000        	call	_digitalWrite
1041  0033 84            	pop	a
1042                     ; 109     digitalWrite(OE_LED, 1);
1044  0034 4b01          	push	#1
1045  0036 ae4404        	ldw	x,#17412
1046  0039 cd0000        	call	_digitalWrite
1048  003c 84            	pop	a
1049                     ; 110     delay(TOffLP);//delayMicroseconds(TOffLP);
1051  003d b600          	ld	a,_TOffLP
1052  003f 5f            	clrw	x
1053  0040 97            	ld	xl,a
1054  0041 cd0000        	call	_delay
1056                     ; 103   for (TSA = 0; TSA < 2; TSA++) {//select activ string. TSA (top string activ)
1058  0044 0c01          	inc	(OFST+0,sp)
1062  0046 7b01          	ld	a,(OFST+0,sp)
1063  0048 a102          	cp	a,#2
1064  004a 25b7          	jrult	L513
1065                     ; 112 }
1068  004c 84            	pop	a
1069  004d 81            	ret	
1149                     ; 114 void SetPixel(uint8_t Xp, uint8_t Yp, uint8_t Color3){
1150                     .text:	section	.text,new
1151  0000               _SetPixel:
1153  0000 89            	pushw	x
1154  0001 520c          	subw	sp,#12
1155       0000000c      OFST:	set	12
1158                     ; 115 	uint32_t Red_p=0;
1160  0003 5f            	clrw	x
1161  0004 1f03          	ldw	(OFST-9,sp),x
1162  0006 1f01          	ldw	(OFST-11,sp),x
1164                     ; 116 	uint32_t Green_p=0;
1166  0008 1f07          	ldw	(OFST-5,sp),x
1167  000a 1f05          	ldw	(OFST-7,sp),x
1169                     ; 117 	uint32_t Blue_p=0;
1171  000c 1f0b          	ldw	(OFST-1,sp),x
1172  000e 1f09          	ldw	(OFST-3,sp),x
1174                     ; 118 if (Color3 & 0b100) {Red_p=1uL<<Xp;}
1176  0010 7b11          	ld	a,(OFST+5,sp)
1177  0012 a504          	bcp	a,#4
1178  0014 2710          	jreq	L563
1181  0016 5c            	incw	x
1182  0017 cd015a        	call	LC010
1183  001a 7b0d          	ld	a,(OFST+1,sp)
1184  001c cd0000        	call	c_llsh
1186  001f 96            	ldw	x,sp
1187  0020 5c            	incw	x
1188  0021 cd0000        	call	c_rtol
1191  0024 7b11          	ld	a,(OFST+5,sp)
1192  0026               L563:
1193                     ; 119 if (Color3 & 0b10) {Green_p=1uL<<Xp;}
1195  0026 a502          	bcp	a,#2
1196  0028 2714          	jreq	L763
1199  002a ae0001        	ldw	x,#1
1200  002d cd015a        	call	LC010
1201  0030 7b0d          	ld	a,(OFST+1,sp)
1202  0032 cd0000        	call	c_llsh
1204  0035 96            	ldw	x,sp
1205  0036 1c0005        	addw	x,#OFST-7
1206  0039 cd0000        	call	c_rtol
1209  003c 7b11          	ld	a,(OFST+5,sp)
1210  003e               L763:
1211                     ; 120 if (Color3 & 0b1) {Blue_p=1uL<<Xp;}
1213  003e a501          	bcp	a,#1
1214  0040 2712          	jreq	L173
1217  0042 ae0001        	ldw	x,#1
1218  0045 cd015a        	call	LC010
1219  0048 7b0d          	ld	a,(OFST+1,sp)
1220  004a cd0000        	call	c_llsh
1222  004d 96            	ldw	x,sp
1223  004e 1c0009        	addw	x,#OFST-3
1224  0051 cd0000        	call	c_rtol
1227  0054               L173:
1228                     ; 121 if (!(RAW_DISPLAY[0][Yp] & Red_p)){
1230  0054 7b0e          	ld	a,(OFST+2,sp)
1231  0056 cd0140        	call	LC007
1232  0059 1c0000        	addw	x,#_RAW_DISPLAY
1233  005c cd0000        	call	c_ltor
1235  005f 96            	ldw	x,sp
1236  0060 5c            	incw	x
1237  0061 cd0000        	call	c_land
1239  0064 cd0000        	call	c_lrzmp
1241  0067 2639          	jrne	L373
1242                     ; 122 if(Red_p){
1244  0069 96            	ldw	x,sp
1245  006a 5c            	incw	x
1246  006b cd0000        	call	c_lzmp
1248  006e 271d          	jreq	L573
1249                     ; 123 RAW_DISPLAY[0][Yp] |= Red_p;
1251  0070 7b0e          	ld	a,(OFST+2,sp)
1252  0072 cd0140        	call	LC007
1253  0075 7b04          	ld	a,(OFST-8,sp)
1254  0077 b703          	ld	c_lreg+3,a
1255  0079 7b03          	ld	a,(OFST-9,sp)
1256  007b b702          	ld	c_lreg+2,a
1257  007d 7b02          	ld	a,(OFST-10,sp)
1258  007f b701          	ld	c_lreg+1,a
1259  0081 7b01          	ld	a,(OFST-11,sp)
1260  0083 b700          	ld	c_lreg,a
1261  0085 1c0000        	addw	x,#_RAW_DISPLAY
1262  0088 cd0000        	call	c_lgor
1265  008b 2015          	jra	L373
1266  008d               L573:
1267                     ; 126 RAW_DISPLAY[0][Yp] &= ~(1uL<<Xp);
1269  008d 7b0e          	ld	a,(OFST+2,sp)
1270  008f cd0140        	call	LC007
1271  0092 cd014f        	call	LC009
1272  0095 7b0d          	ld	a,(OFST+1,sp)
1273  0097 cd0145        	call	LC008
1274  009a 1c0000        	addw	x,#_RAW_DISPLAY
1275  009d 3300          	cpl	c_lreg
1276  009f cd0000        	call	c_lgand
1278  00a2               L373:
1279                     ; 129 if (!(RAW_DISPLAY[1][Yp] & Green_p)){
1281  00a2 7b0e          	ld	a,(OFST+2,sp)
1282  00a4 cd0140        	call	LC007
1283  00a7 1c0040        	addw	x,#_RAW_DISPLAY+64
1284  00aa cd0000        	call	c_ltor
1286  00ad 96            	ldw	x,sp
1287  00ae 1c0005        	addw	x,#OFST-7
1288  00b1 cd0000        	call	c_land
1290  00b4 cd0000        	call	c_lrzmp
1292  00b7 2637          	jrne	L104
1293                     ; 130 if(Green_p){
1295  00b9 96            	ldw	x,sp
1296  00ba 1c0005        	addw	x,#OFST-7
1297  00bd cd0000        	call	c_lzmp
1299  00c0 271c          	jreq	L304
1300                     ; 131 RAW_DISPLAY[1][Yp] |= Green_p;
1302  00c2 7b0e          	ld	a,(OFST+2,sp)
1303  00c4 ad7a          	call	LC007
1304  00c6 7b08          	ld	a,(OFST-4,sp)
1305  00c8 b703          	ld	c_lreg+3,a
1306  00ca 7b07          	ld	a,(OFST-5,sp)
1307  00cc b702          	ld	c_lreg+2,a
1308  00ce 7b06          	ld	a,(OFST-6,sp)
1309  00d0 b701          	ld	c_lreg+1,a
1310  00d2 7b05          	ld	a,(OFST-7,sp)
1311  00d4 b700          	ld	c_lreg,a
1312  00d6 1c0040        	addw	x,#_RAW_DISPLAY+64
1313  00d9 cd0000        	call	c_lgor
1316  00dc 2012          	jra	L104
1317  00de               L304:
1318                     ; 134 RAW_DISPLAY[1][Yp] &= ~(1uL<<Xp);
1320  00de 7b0e          	ld	a,(OFST+2,sp)
1321  00e0 ad5e          	call	LC007
1322  00e2 ad6b          	call	LC009
1323  00e4 7b0d          	ld	a,(OFST+1,sp)
1324  00e6 ad5d          	call	LC008
1325  00e8 1c0040        	addw	x,#_RAW_DISPLAY+64
1326  00eb 3300          	cpl	c_lreg
1327  00ed cd0000        	call	c_lgand
1329  00f0               L104:
1330                     ; 137 if (!(RAW_DISPLAY[2][Yp] & Blue_p)){
1332  00f0 7b0e          	ld	a,(OFST+2,sp)
1333  00f2 ad4c          	call	LC007
1334  00f4 1c0080        	addw	x,#_RAW_DISPLAY+128
1335  00f7 cd0000        	call	c_ltor
1337  00fa 96            	ldw	x,sp
1338  00fb 1c0009        	addw	x,#OFST-3
1339  00fe cd0000        	call	c_land
1341  0101 cd0000        	call	c_lrzmp
1343  0104 2637          	jrne	L704
1344                     ; 138 if(Blue_p){
1346  0106 96            	ldw	x,sp
1347  0107 1c0009        	addw	x,#OFST-3
1348  010a cd0000        	call	c_lzmp
1350  010d 271c          	jreq	L114
1351                     ; 139 RAW_DISPLAY[2][Yp] |= Blue_p;
1353  010f 7b0e          	ld	a,(OFST+2,sp)
1354  0111 ad2d          	call	LC007
1355  0113 7b0c          	ld	a,(OFST+0,sp)
1356  0115 b703          	ld	c_lreg+3,a
1357  0117 7b0b          	ld	a,(OFST-1,sp)
1358  0119 b702          	ld	c_lreg+2,a
1359  011b 7b0a          	ld	a,(OFST-2,sp)
1360  011d b701          	ld	c_lreg+1,a
1361  011f 7b09          	ld	a,(OFST-3,sp)
1362  0121 b700          	ld	c_lreg,a
1363  0123 1c0080        	addw	x,#_RAW_DISPLAY+128
1364  0126 cd0000        	call	c_lgor
1367  0129 2012          	jra	L704
1368  012b               L114:
1369                     ; 142 RAW_DISPLAY[2][Yp] &= ~(1uL<<Xp);
1371  012b 7b0e          	ld	a,(OFST+2,sp)
1372  012d ad11          	call	LC007
1373  012f ad1e          	call	LC009
1374  0131 7b0d          	ld	a,(OFST+1,sp)
1375  0133 ad10          	call	LC008
1376  0135 1c0080        	addw	x,#_RAW_DISPLAY+128
1377  0138 3300          	cpl	c_lreg
1378  013a cd0000        	call	c_lgand
1380  013d               L704:
1381                     ; 145 }
1384  013d 5b0e          	addw	sp,#14
1385  013f 81            	ret	
1386  0140               LC007:
1387  0140 97            	ld	xl,a
1388  0141 a604          	ld	a,#4
1389  0143 42            	mul	x,a
1390  0144 81            	ret	
1391  0145               LC008:
1392  0145 cd0000        	call	c_llsh
1394  0148 3303          	cpl	c_lreg+3
1395  014a 3302          	cpl	c_lreg+2
1396  014c 3301          	cpl	c_lreg+1
1397  014e 81            	ret	
1398  014f               LC009:
1399  014f 35010003      	mov	c_lreg+3,#1
1400  0153 3f02          	clr	c_lreg+2
1401  0155 3f01          	clr	c_lreg+1
1402  0157 3f00          	clr	c_lreg
1403  0159 81            	ret	
1404  015a               LC010:
1405  015a bf02          	ldw	c_lreg+2,x
1406  015c 5f            	clrw	x
1407  015d bf00          	ldw	c_lreg,x
1408  015f 81            	ret	
1436                     ; 147 void main(void)
1436                     ; 148 {
1437                     .text:	section	.text,new
1438  0000               _main:
1442                     ; 149 	GPIOA->DDR |= (1 << 1)|(1 << 2)|(1 << 3); // pins as output
1444  0000 c65002        	ld	a,20482
1445  0003 aa0e          	or	a,#14
1446  0005 c75002        	ld	20482,a
1447                     ; 150 	GPIOC->DDR |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
1449  0008 c6500c        	ld	a,20492
1450  000b aaf8          	or	a,#248
1451  000d c7500c        	ld	20492,a
1452                     ; 151 	GPIOD->DDR |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);
1454  0010 c65011        	ld	a,20497
1455  0013 aa1c          	or	a,#28
1456  0015 c75011        	ld	20497,a
1457                     ; 152 	GPIOA->CR1 |= (1 << 1)|(1 << 2)|(1 << 3); // pins as push-pull
1459  0018 c65003        	ld	a,20483
1460  001b aa0e          	or	a,#14
1461  001d c75003        	ld	20483,a
1462                     ; 153 	GPIOC->CR1 |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
1464  0020 c6500d        	ld	a,20493
1465  0023 aaf8          	or	a,#248
1466  0025 c7500d        	ld	20493,a
1467                     ; 154 	GPIOD->CR1 |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);
1469  0028 c65012        	ld	a,20498
1470  002b aa1c          	or	a,#28
1471  002d c75012        	ld	20498,a
1472                     ; 155 	GPIOA->CR2 |= (1 << 1)|(1 << 2)|(1 << 3); // pins speed 10Mhz
1474  0030 c65004        	ld	a,20484
1475  0033 aa0e          	or	a,#14
1476  0035 c75004        	ld	20484,a
1477                     ; 156 	GPIOC->CR2 |= (1 << 3)|(1 << 4)|(1 << 5)|(1 << 6)|(1 << 7);
1479  0038 c6500e        	ld	a,20494
1480  003b aaf8          	or	a,#248
1481  003d c7500e        	ld	20494,a
1482                     ; 157 	GPIOD->CR2 |= (1 << 2)|(1 << 3)|(1 << 4);//|(1 << 5)|(1 << 6);
1484  0040 c65013        	ld	a,20499
1485  0043 aa1c          	or	a,#28
1486  0045 c75013        	ld	20499,a
1487                     ; 159     CLK_DeInit();
1489  0048 cd0000        	call	_CLK_DeInit
1491                     ; 160     CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1); // set 16 MHz for CPU
1493  004b 4f            	clr	a
1494  004c cd0000        	call	_CLK_SYSCLKConfig
1496                     ; 162 		SetBrightness(0); //0-255
1498  004f 4f            	clr	a
1499  0050 cd0000        	call	_SetBrightness
1501                     ; 164 		SetPixel(10, 0, 6); //x=10, y=0, color=6=0b110-RGB: R+G=Yellow
1503  0053 4b06          	push	#6
1504  0055 ae0a00        	ldw	x,#2560
1505  0058 cd0000        	call	_SetPixel
1507  005b 84            	pop	a
1508                     ; 165 		SetPixel(11, 1, 1);
1510  005c 4b01          	push	#1
1511  005e ae0b01        	ldw	x,#2817
1512  0061 cd0000        	call	_SetPixel
1514  0064 84            	pop	a
1515                     ; 166 		SetPixel(12, 2, 2);
1517  0065 4b02          	push	#2
1518  0067 ae0c02        	ldw	x,#3074
1519  006a cd0000        	call	_SetPixel
1521  006d 84            	pop	a
1522                     ; 167 		SetPixel(13, 3, 3);
1524  006e 4b03          	push	#3
1525  0070 ae0d03        	ldw	x,#3331
1526  0073 cd0000        	call	_SetPixel
1528  0076 84            	pop	a
1529                     ; 168 		SetPixel(14, 4, 4);
1531  0077 4b04          	push	#4
1532  0079 ae0e04        	ldw	x,#3588
1533  007c cd0000        	call	_SetPixel
1535  007f 84            	pop	a
1536                     ; 169 		SetPixel(15, 5, 5);
1538  0080 4b05          	push	#5
1539  0082 ae0f05        	ldw	x,#3845
1540  0085 cd0000        	call	_SetPixel
1542  0088 84            	pop	a
1543                     ; 170 		SetPixel(16, 6, 7);
1545  0089 4b07          	push	#7
1546  008b ae1006        	ldw	x,#4102
1547  008e cd0000        	call	_SetPixel
1549  0091 84            	pop	a
1550                     ; 171 		SetPixel(17, 7, 0);
1552  0092 4b00          	push	#0
1553  0094 ae1107        	ldw	x,#4359
1554  0097 cd0000        	call	_SetPixel
1556  009a 84            	pop	a
1557  009b               L524:
1558                     ; 176 		LoadAndShowBufOnPanel();
1560  009b cd0000        	call	_LoadAndShowBufOnPanel
1563  009e 20fb          	jra	L524
1598                     ; 181 void assert_failed(u8* file, u32 line)
1598                     ; 182 { 
1599                     .text:	section	.text,new
1600  0000               _assert_failed:
1604  0000               L744:
1605  0000 20fe          	jra	L744
1640                     	xdef	_main
1641                     	xdef	_SetPixel
1642                     	xdef	_LoadAndShowBufOnPanel
1643                     	xdef	_LoadAllBlocks
1644                     	xdef	_LoadBlock
1645                     	xdef	_SetBrightness
1646                     	xdef	_SetRGB
1647                     	xdef	_digitalWrite
1648                     	xdef	_delay
1649                     	xdef	_RAW_DISPLAY
1650                     	switch	.ubsct
1651  0000               _TOffLP:
1652  0000 00            	ds.b	1
1653                     	xdef	_TOffLP
1654                     	xdef	_assert_failed
1655                     	xref	_CLK_SYSCLKConfig
1656                     	xref	_CLK_DeInit
1657                     	xref.b	c_lreg
1658                     	xref.b	c_x
1678                     	xref	c_lgand
1679                     	xref	c_lgor
1680                     	xref	c_lzmp
1681                     	xref	c_lrzmp
1682                     	xref	c_land
1683                     	xref	c_ltor
1684                     	xref	c_rtol
1685                     	xref	c_llsh
1686                     	end
