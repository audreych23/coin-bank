**Parameter (if needed)**

**109006273_Coin_bank**
* .lib "/users/course/2023F/cs312000110001/u109006273/spice/pre_sim/cic018.l" TT

**Environment setting**
* .param vdd = 1.8v
* .temp 30
* .option post
***********************

**I/O signal**
* input: M3 M2 M1 M0 Store Power Clk VDD VSS
* output: State1 State0 S3 S2 S1 S0 Mo3 Mo2 Mo1 Mo0 Init3 Init2 Init1 Init0

**Main circuit**
**Don't modify the circuit name or the ordering of signal**
.subckt Coin_bank State1 State0 S3 S2 S1 S0 Mo3 Mo2 Mo1 Mo0 Init3 Init2 Init1 Init0 M3 M2 M1 M0 Store Power Clk VDD VSS
Xnext_st_cal State1 State0 Power Store next_st1 next_st0 VDD VSS next_st_cal
Xdff_2bs Clk next_st1 next_st0 State1 State0 VDD VSS DFF_2b
Xdecoder_2x4 State1 State0 S3 S2 S1 S0 VDD VSS decoder_2x4

Xand_2b1 State1 State0 store_enable VDD VSS and_2b
Xinv State1 state1_bar VDD VSS inv 
Xand_3b state1_bar State0 Store money_enable VDD VSS and_3b

Xdff_4bm1 money_enable M3 M2 M1 M0 m3_in m2_in m1_in m0_in VDD VSS DFF_4b
Xadder_4b m3_in m2_in m1_in m0_in Init3 Init2 Init1 Init0 m3_store m2_store m1_store m0_store VDD VSS adder_4b
Xdff_4bm2 store_enable m3_store m2_store m1_store m0_store Init3 Init2 Init1 Init0 VDD VSS DFF_4b 
Xmux_4x1_4b m3_in m2_in m1_in m0_in Init3 Init2 Init1 Init0 State1 State0 Mo3 Mo2 Mo1 Mo0 VDD VSS MUX_4x1_4b 
.ends Coin_bank

**Subcircuit (if needed)**
** DFF **
.subckt DFF_4b Clk D3 D2 D1 D0 Q3 Q2 Q1 Q0 VDD VSS
Xdff1 Clk D3 Q3 VDD VSS DFF
Xdff2 Clk D2 Q2 VDD VSS DFF
Xdff3 Clk D1 Q1 VDD VSS DFF
Xdff4 Clk D0 Q0 VDD VSS DFF
.ends DFF_4b

.subckt DFF_2b Clk D1 D0 Q1 Q0 VDD VSS
Xdff1 Clk D1 Q1 VDD VSS DFF
Xdff2 Clk D0 Q0 VDD VSS DFF
.ends DFF_2b

.subckt DFF Clk D Q VDD VSS
mp1 out1  D   VDD  VDD p_18 w=3u l=0.18u
mp2 X     Clk out1 VDD p_18 w=3u l=0.18u
mn1 X     D   VSS  VSS n_18 w=1.4u l=0.18u
mp3 Y     Clk VDD  VDD p_18 w=3u l=0.18u
mn2 out2  Clk VSS  VSS n_18 w=1.4u l=0.18u
mn3 Y     X   out2 VSS n_18 w=1.4u l=0.18u
mp4 Q_bar Y   VDD  VDD p_18 w=3u l=0.18u
mn4 out3  Y   VSS  VSS n_18 w=1.4u l=0.18u
mn5 Q_bar Clk out3 VSS n_18 w=1.4u l=0.18u
Xinv Q_bar Q VDD VSS inv
.ends DFF

** adder **
.subckt adder_4b a3 a2 a1 a0 b3 b2 b1 b0 s3 s2 s1 s0 VDD VSS 
Xadder1 a0 b0 VSS s0 c1 VDD VSS adder
Xadder2 a1 b1 c1  s1 c2 VDD VSS adder
Xadder3 a2 b2 c2  s2 c3 VDD VSS adder
Xadder4 a3 b3 c3  s3 c4 VDD VSS adder
.ends adder_4b

.subckt adder a b c s cout VDD VSS 
mp1 out1     a VDD VDD p_18 w=3u l=0.18u
mp2 out1     b VDD VDD p_18 w=3u l=0.18u
mp3 cout_bar c out1 VDD p_18 w=3u l=0.18u
mn1 out2     a VSS VSS n_18 w=1.4u l=0.18u
mn2 out2     b VSS VSS n_18 w=1.4u l=0.18u
mn3 cout_bar c out2 VSS n_18 w=1.4u l=0.18u

mp4 out3     a VDD VDD p_18 w=3u l=0.18u
mp5 cout_bar b out3 VDD p_18 w=3u l=0.18u
mn4 out4     b VSS VSS n_18 w=1.4u l=0.18u
mn5 cout_bar a out4 VSS n_18 w=1.4u l=0.18u
Xinv1 cout_bar cout VDD VSS inv

mp6 out5 a VDD VDD p_18 w=3u l=0.18u
mp7 out5 b VDD VDD p_18 w=3u l=0.18u
mp8 out5 c VDD VDD p_18 w=3u l=0.18u
mp9 s_bar cout_bar out5 VDD p_18 w=3u l=0.18u
mn6 out6 a VSS VSS n_18 w=1.4u l=0.18u
mn7 out6 b VSS VSS n_18 w=1.4u l=0.18u
mn8 out6 c VSS VSS n_18 w=1.4u l=0.18u
mn9 s_bar cout_bar out6 VSS n_18 w=1.4u l=0.18u

mp10 out7  a VDD VDD p_18 w=3u l=0.18u
mp11 out8  b out7 VDD p_18 w=3u l=0.18u
mp12 s_bar c out8 VDD p_18 w=3u l=0.18u
mn10 out9  c VSS VSS n_18 w=1.4u l=0.18u
mn11 out10 b out9 VSS n_18 w=1.4u l=0.18u
mn12 s_bar a out10 VSS n_18 w=1.4u l=0.18u
Xinv2 s_bar s VDD VSS inv
.ends adder

** calculate next state block diagram **
.subckt next_st_cal st1 st0 power store next_st1 next_st0 VDD VSS
Xnext_st1_cal power st1 st0 store next_st1 VDD VSS next_st1_cal
Xnext_st0_cal power st1 st0 store next_st0 VDD VSS next_st0_cal
.ends next_st_cal

.subckt next_st0_cal a b c d out VDD VSS
** AB + AC'D + ACD' **
Xinv1 c c_bar VDD VSS inv
Xinv2 d d_bar VDD VSS inv
Xand_2b a b out1 VDD VSS and_2b 
Xand_3b1 a c_bar d     out2 VDD VSS and_3b
Xand_3b2 a c     d_bar out3 VDD VSS and_3b
Xor_3b out1 out2 out3 out VDD VSS or_3b
.ends next_st0_cal

.subckt next_st1_cal a b c d out VDD VSS
** ABC' + AB'CD
Xinv1 c c_bar VDD VSS inv
Xinv2 b b_bar VDD VSS inv
Xand_3b a b     c_bar   out1 VDD VSS and_3b
Xand_4b a b_bar c     d out2 VDD VSS and_4b
* Xbuffer1 out1_buffer out1 VDD VSS buffer
* Xbuffer2 out2_buffer out2 VDD VSS buffer
Xor_2b out1 out2 out VDD VSS or_2b
.ends next_st1_cal 

** decoder ** 
.subckt decoder_2x4 b1 b0 out3 out2 out1 out0 VDD VSS
Xinv1 b1 b1_bar VDD VSS inv
Xinv2 b0 b0_bar VDD VSS inv
Xnor_2b1 b1     b0     out0 VDD VSS nor_2b
Xnor_2b2 b1     b0_bar out1 VDD VSS nor_2b
Xnor_2b3 b1_bar b0     out2 VDD VSS nor_2b
Xnor_2b4 b1_bar b0_bar out3 VDD VSS nor_2b
* Xbuffer1 out1_buf out1 VDD VSS buffer 
* Xbuffer2 out2_buf out2 VDD VSS buffer
* Xbuffer3 out3_buf out3 VDD VSS buffer
* Xtg1 b1_bar b1 b0_bar out0 VDD VSS tg 
* Xtg2 b1_bar b1 b0     out1 VDD VSS tg
* Xtg3 b1 b1_bar b0_bar out2 VDD VSS tg
* Xtg4 b1 b1_bar b0     out3 VDD VSS tg
.ends decoder_2x4

** MUX **
.subckt MUX_4x1_4b a3 a2 a1 a0 b3 b2 b1 b0 s1 s0 out3 out2 out1 out0 VDD VSS
Xmux_4x1_1 a3 b3 s1 s0 out3 VDD VSS MUX_4x1
Xmux_4x1_2 a2 b2 s1 s0 out2 VDD VSS MUX_4x1
Xmux_4x1_3 a1 b1 s1 s0 out1 VDD VSS MUX_4x1
Xmux_4x1_4 a0 b0 s1 s0 out0 VDD VSS MUX_4x1
.ends MUX_4x1_4b

.subckt MUX_4x1 a b s1 s0 out VDD VSS 
** special case **
** The other 2 outputs are 0 so inputs are not 2^2 **
Xmux_2x1_1 a b s0 out1 VDD VSS MUX_2x1
Xmux_2x1_2 VSS out1 s1 out VDD VSS MUX_2x1
.ends MUX_4x1

.subckt MUX_2x1 a b s out VDD VSS
Xinv s s_bar VDD VSS inv
Xtg1 s_bar s a OUT VDD VSS tg
Xtg2 s s_bar b OUT VDD VSS tg
.ends MUX_2x1

** gate level **
.subckt inv in1 out VDD VSS
mp1 out in1 VDD VDD p_18 w=6u l=0.18u
mn1 out in1 VSS VSS n_18 w=5u l=0.18u
.ends inv

.subckt tg c c_bar a b VDD VSS
mp1 b c_bar a VDD p_18 w=3u l=0.18u
mn1 b c     a VSS n_18 w=1.4u l=0.18u
.ends tg

.subckt nand_4b a b c d out VDD VSS
mp1 out  a VDD  VDD p_18 w=3u l=0.18u
mp2 out  b VDD	VDD p_18 w=3u l=0.18u
mp3 out  c VDD	VDD p_18 w=3u l=0.18u
mp4 out  d VDD  VDD p_18 w=3u l=0.18u
mn1 out1 a VSS	VSS n_18 w=1.4u l=0.18u
mn2 out2 b out1 VSS n_18 w=1.4u l=0.18u
mn3 out3 c out2 VSS n_18 w=1.4u l=0.18u
mn4 out  d out3 VSS n_18 w=1.4u l=0.18u
.ends nand_4b

.subckt nand_3b a b c out VDD VSS
mp1 out  a VDD  VDD p_18 w=3u l=0.18u
mp2 out  b VDD  VDD p_18 w=3u l=0.18u
mp3 out  c VDD  VDD p_18 w=3u l=0.18u
mn1 out1 a VSS  VSS n_18 w=1.4u l=0.18u
mn2 out2 b out1 VSS n_18 w=1.4u l=0.18u
mn3 out	 c out2 VSS n_18 w=1.4u l=0.18u
.ends nand_3b

.subckt nand_2b a b out VDD VSS
mp1 out  a VDD  VDD p_18 w=3u l=0.18u
mp2 out  b VDD	VDD p_18 w=3u l=0.18u
mn1 out1 a VSS	VSS n_18 w=1.4u l=0.18u
mn2 out  b out1 VSS n_18 w=1.4u l=0.18u
.ends nand_2b

.subckt and_2b a b out VDD VSS
Xnand_2b a b out_bar VDD VSS nand_2b
Xinv out_bar out VDD VSS inv
.ends and_3b

.subckt and_3b a b c out VDD VSS
Xnand_3b a b c out_bar VDD VSS nand_3b
Xinv out_bar out VDD VSS inv
.ends and_3b

.subckt and_4b a b c d out VDD VSS
Xnand_4b a b c d out_bar VDD VSS nand_4b
Xinv out_bar out VDD VSS inv
.ends and_4b

.subckt nor_2b a b out VDD VSS
mp1 out1 a VDD	VDD p_18 w=3u l=0.18u
mp2 out  b out1 VDD p_18 w=3u l=0.18u
mn1 out  a VSS  VSS n_18 w=1.4u l=0.18u
mn2 out  b VSS  VSS n_18 w=1.4u l=0.18u
.ends nor_2b

.subckt nor_3b a b c out VDD VSS
mp1 out1 a VDD	VDD p_18 w=3u l=0.18u
mp2 out2 b out1 VDD p_18 w=3u l=0.18u
mp3 out  c out2 VDD p_18 w=3u l=0.18u
mn1 out  a VSS  VSS n_18 w=1.4u l=0.18u
mn2 out  b VSS  VSS n_18 w=1.4u l=0.18u
mn3 out  c VSS  VSS n_18 w=1.4u l=0.18u
.ends nor_3b

.subckt or_2b a b out VDD VSS
Xnor_3b a b out_bar VDD VSS nor_2b
Xinv out_bar out VDD VSS inv
.ends or_2b

.subckt or_3b a b c out VDD VSS
Xnor_3b a b c out_bar VDD VSS nor_3b
Xinv out_bar out VDD VSS inv
.ends or_3b

.subckt buffer a out VDD VSS 
Xinv1 a a_bar VDD VSS inv
Xinv2 a_bar out VDD VSS inv
.ends buffer

** main circuit for debugging **
** debugging main **
* Xdecoder_2x4 A B out_d3 out_d2 out_d1 out_d0 VDD VSS decoder_2x4
* Xmux_4x1 A B S1 S0 out_mux VDD VSS MUX_4x1
* next_st_cal st1 st0 power store next_st1 next_st0 VDD VSS
* Xnext_st_cal s0 B s1 A next_st1 next_st0 VDD VSS next_st_cal
* Xdff CLK D Q VDD VSS DFF
* .subckt nand_3b a b c out VDD VSS
* Xnand_3b B S0 S1 nand3out VDD VSS nand_3b
* Xnor_3b A B S0 nor3out VDD VSS nor_3b
* Xnand_4b A B S0 S1 nand4out VDD VSS nand_4b
* Xadder A B S0 sum_out c_out VDD VSS adder

** debugging signal **
* Vvdd VDD gnd dc vdd
* Vvss VSS 0 0
* VA A gnd pulse (0v 1.8v 2.4ns 100ps 100ps 2.4ns 5ns)
* VB B gnd pulse (0v 1.8v 4.9ns 100ps 100ps 4.9ns 10ns)
* VS0 S0 gnd pulse (0v 1.8v 9.9ns 100ps 100ps 9.9ns 20ns)
* VS1 S1 gnd pulse (0v 1.8v 19.9ns 100ps 100ps 19.9ns 40ns)

* Vclk CLK gnd pulse (0v 1.8v 0ns 100ps 100ps 4.9ns 10ns)
* Vd   D   gnd pulse (0v 1.8v 5ns 100ps 100ps 9.9ns 20ns)

**Simulation setting**
* .tran 0.01n 120n
* .measure tran power AVG POWER
* .end