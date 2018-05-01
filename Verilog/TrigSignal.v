`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:01 03/24/2018 
// Design Name: 
// Module Name:    TrigSignal 
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
module TrigSignal(clk_1m, rst, trig); //Send 10us signal
input clk_1m, rst;
output trig;

reg trig;
reg[19:0] count;
// ?1000 000???
always@(posedge clk_1m, posedge rst)
begin
    if (rst ==1)
        count <= 0;
    else
    begin
        if (9 == count)
        begin
            trig <= 0;
            count <= count + 1;
        end
        else 
        begin
            if (100000 == count)//100_000
            begin
                trig <= 1;
                count <= 0;
            end
            else
                count <= count + 1;
        end
    end
end
endmodule