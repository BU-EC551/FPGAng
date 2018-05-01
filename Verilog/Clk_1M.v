`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:58 03/24/2018 
// Design Name: 
// Module Name:    Clk_1M 
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
module Clk_1M(outclk, inclk, rst); //100M to 1M

output reg outclk;
input inclk, rst;
reg [21:0] count;
    initial begin
        count = 0;
        outclk = 0;
    end
    always @(posedge inclk or posedge rst) begin
        if(rst == 1)
            outclk <= 1'b0;
        else if (count == 49) begin//49
                count <=0;
                outclk <=~outclk;
        end
        else if (count < 49)//49
            count <= count +1;
				else;
				

    end
endmodule 