`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:55:48 04/21/2018 
// Design Name: 
// Module Name:    turn 
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
module turn(
	input [11:0] fd1,
	input [11:0] fd2,
	input [11:0] ld,
	input [11:0] rd,
	input clk_1M,
	input rst,
	output reg stop,
	output reg backward,
	output reg turn_left,
	output reg turn_right,
	output reg [2:0] state
    );
reg [2:0] nextstate;	 
reg [23:0] count;
parameter frontTh = 80, sideTh =50, backTh = 40;
always @(posedge clk_1M, posedge rst)
begin
	if(rst == 1)
	begin
		stop <= 0;
		backward <= 0;
		turn_left <= 0;
		turn_right <=0;
	end
	else
	begin
		case(state)
			3'b000://running
				begin
				stop <= 0;//go = 1;
				backward <= 0;
				turn_left <= 0;
				turn_right <=0;
				if(fd1<frontTh||fd2<frontTh)
					nextstate<=3'b01;
				end
			3'b001://stop
				begin
				stop <= 1;
				backward<=0;
				if(fd1<backTh||fd2<backTh)
				    begin
				    nextstate <= 3'b011;
				    end
				else begin
				    if(ld>sideTh||rd>sideTh)
		  			    nextstate <= 3'b010;
	   			    else//ld<sideTh && rd<sideTh
    					nextstate <= 3'b011;
				    end
				end
			3'b010://turning
				begin
				if(fd1<backTh||fd2<backTh)
				    begin
				    nextstate<=3'b011;
				    end
				else begin
				    if(ld>rd)
				        begin
					   nextstate<=3'b100;
					   end
				    else//rd>=ld
				        begin
					   nextstate<=3'b101;
					   end
				    end
				end
			3'b011://back
				begin
				backward<=1;
				stop<=1;
				turn_left <= 0;
				turn_right <=0;
				nextstate<=3'b001;
				end
			3'b100://turn left
				begin
				turn_left <=1;
				stop<=0;
				backward<=0;
				nextstate<=3'b000;
				if(fd1<backTh||fd2<backTh)
				    begin
                    stop <=1;
                    nextstate <= 3'b001;
                    end
				end
			3'b101://turn right
				begin
				turn_right <=1;
				stop<=0;
				backward<=0;
				nextstate<=3'b000;
				if(fd1<backTh||fd2<backTh)
				    begin
                    stop <=1;
                    nextstate <= 3'b001;
                    end
                end
		endcase
	end
end

always@(posedge clk_1M,posedge rst)
begin
	if(rst==1)
	begin
		state<=0;
		count<=0;
	end
	else
	begin
		case(state)
			3'b000:state<=nextstate;//running
			3'b001://stop
				begin
				if(count==1000_000)//1000_000=1s
				begin
					state<=nextstate;
					count<=0;
				end
				else
					count<=count+1;
				end
			3'b010:state<=nextstate;//turnning check
			3'b011://back 2s
				begin
				if(count==2000_000)//1000_000=1s
				begin
					state<=nextstate;
					count<=0;
				end
				else
					count<=count+1;
				end
			3'b100://turn left 2s
				begin
				if(count==1500_000)//1000_000=1s
				begin
					state<=nextstate;
					count<=0;
				end
				else
					count<=count+1;
				end
			3'b101://turn right 2s
				begin
				if(count==1500_000)//1000_000=1s
				begin
					state<=nextstate;
					count<=0;
				end
				else
					count<=count+1;
				end
		endcase
	end
end
endmodule
/*

	begin
		if((fd1<frontTh||fd2<frontTh)
			begin
			stop=1;
			if(rd>ld)
				begin
				if(rd>sideTh)
					trun_right=1;
				else//rd<sideTh
					backward=1;
				end
			else//ld>rd
				begin
				if(ld>sideTh)
					turn_left=1;
				else
					backward=0;
				end
			end
	end
*/
