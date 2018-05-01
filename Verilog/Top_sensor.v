`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:00 04/19/2018 
// Design Name: 
// Module Name:    Top_sensor 
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
module Top_sensor(clk_50m,rst,Trig_l,Trig_r,Trig_f1,Trig_f2,Echo_l,Echo_r,Echo_f1,Echo_f2,seven_seg_out,Select,stop,backward,turn_left,turn_right,state,run);
input clk_50m, rst;
input Echo_l,Echo_r,Echo_f1,Echo_f2;
output Trig_l,Trig_r,Trig_f1,Trig_f2;
output [7:0] seven_seg_out;
output [3:0] Select;
output stop,backward,turn_left,turn_right;
output [2:0] state;
output run;
wire [11:0] fd1,fd2,ld,rd;
wire clk_1M;

NumberDisplay nd1(.clk(clk_50m), .Data(fd1), .seven_seg_out(seven_seg_out), .Select(Select), .rst(rst));
sonic_detect l1(.clk_50m(clk_50m), .rst(rst), .Trig(Trig_l), .Echo(Echo_l), .dis(rd));
sonic_detect r1(.clk_50m(clk_50m), .rst(rst), .Trig(Trig_r), .Echo(Echo_r), .dis(ld));
sonic_detect f1(.clk_50m(clk_50m), .rst(rst), .Trig(Trig_f1), .Echo(Echo_f1), .dis(fd1));
sonic_detect f2(.clk_50m(clk_50m), .rst(rst), .Trig(Trig_f2), .Echo(Echo_f2), .dis(fd2));
Clk_1M clk1(.outclk(clk_1M), .inclk(clk_50m), .rst(rst));
turn t1(.fd1(fd1),.fd2(fd2),.ld(ld),.rd(rd),.clk_1M(clk_1M),.rst(rst),.stop(stop),.backward(backward),.turn_left(turn_left),.turn_right(turn_right),.state(state));

assign run = ~stop;

/*
always@(posedge clk_50m)
begin
if(dis_m1 <50 || dis_m2 <50)
	stop = 1; 
	if(dis_l<dis_r)
	begin
		if(dis_r < threshold)
			backward
		else
			turn right
	end
	else//dis_l>dis_r
		if(dis_l<threshold)
			backward
		else
			turn left
else
	stop = 0;
	
//
if(dis_l <50)
	led_l = 1;
else
	led_l = 0;

if(dis_r <)
	led_r = 1;
else
	led_r = 0;
end
*/
endmodule
