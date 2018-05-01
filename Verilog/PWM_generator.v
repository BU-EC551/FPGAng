`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:55 03/18/2018 
// Design Name: 
// Module Name:    PWM_generator 
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
module PWM_generator(speed, pwm, clk, rst);
	input clk, rst;
	input [1:0] speed;
	reg [6:0] D;
	output reg pwm;
	reg [31:0] counter;
	
	always @(speed)
	begin
		case(speed)
			2'b00 : D = 7'd0; // stop
			2'b01 : D = 7'd65; // 65% duty cycle
			2'b10 : D = 7'd80; // 80% duty cycle
			2'b11 : D = 7'd95; // 95% duty cycle
		endcase
	end
	
	always @(posedge clk)
	begin
		if(rst)
		begin
			pwm <= 1;
			counter <= 0;
		end
		else if(D == 7'd0)
		begin
			pwm <= 0;
		end
		else
		begin
			counter <= counter + 32'b1;
			
			if(counter == D*1000) // every 1000 100MHz clock pulses is 10 us, or 1% of a 1kHz square wave
			begin
				pwm <= 0;
			end
			else if(counter == 32'd100_000) // 100,000 100 MHz clock pulses is 1kHz
			begin
				pwm <= 1;
				counter <= 32'b0;
			end
		end
	end
			
endmodule
