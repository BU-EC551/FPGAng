`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:22 03/24/2018 
// Design Name: 
// Module Name:    Sonic_detect 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sonic_detect(clk_50m, rst, Trig, Echo, dis);
input clk_50m, rst, Echo;
output Trig;
output [11:0] dis; // ?????????us 
// Vcc--GPIO10
// Gnd--GPIO11
wire clk_1m;

//wire[19:0] d;   // ??(??cm),5????,??????
Clk_1M c1(.outclk(clk_1m), .inclk(clk_50m), .rst(rst)); // 50??
TrigSignal t1(.clk_1m(clk_1m), .rst(rst), .trig(Trig));
PosCounter p1(.clk_1m(clk_1m), .rst(rst), .echo(Echo), .dis_count(dis));

//assign Led =((d[19:16] < 1)&(d[15:12] < 1)) ? 1 : 0;
/*
translator u3(.in(d[19:16]), .out(distance[34:28])); // ????
translator u4(.in(d[15:12]), .out(distance[27:21]));
translator u5(.in(d[11:8]), .out(distance[20:14]));
translator u6(.in(d[7:4]), .out(distance[13:7]));
translator u7(.in(d[3:0]), .out(distance[6:0]));
assign d[19:16] = dis/10000;    // ??
assign d[15:12] = dis/1000%10;  // ??
assign d[11:8]  = dis/100%10;   // ??
assign d[7:4]   = dis/10%10;    // 0.1
assign d[3:0]   = dis%10;       // 0.01
*/
endmodule