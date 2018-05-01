`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:14 03/18/2018 
// Design Name: 
// Module Name:    clk_divider 
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
module clk_divider(clk, clk_out, rst);
	input clk, rst;
	output reg clk_out;
	reg [31:0] counter; 

	always @(posedge clk)
	begin
		if(rst)
		begin
			counter <= 0;
			clk_out <= 0;
		end
		else
		begin
			counter <= counter + 32'b1;
			if(counter == 32'd50000)
			begin
				clk_out <= ~clk_out;
				counter <= 0;
			end
		end
	end
	
endmodule
