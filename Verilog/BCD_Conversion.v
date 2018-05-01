`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:33 03/24/2018 
// Design Name: 
// Module Name:    BCD_Conversion 
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
module BCD_Conversion(hundreds, tens, ones, binary);
output reg [3:0] hundreds, tens, ones;
input [11:0] binary;

integer i;
always @(binary)
begin
	hundreds = 4'd0;
	tens = 4'd0;
	ones = 4'd0;
	
	for(i=11;i>=0;i=i-1)
	begin
		if(hundreds>=5)
			hundreds = hundreds +3;
		if(tens>=5)
			tens = tens +3;
		if(ones>=5)
			ones = ones + 3;
		
		hundreds = hundreds<<1;
		hundreds[0] = tens[3];
		tens = tens<<1;
		tens[0] = ones[3];
		ones = ones<<1;
		ones[0] = binary[i];
	end
end

endmodule
