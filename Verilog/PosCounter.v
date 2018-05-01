`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:52 03/24/2018 
// Design Name: 
// Module Name:    PosCounter 
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
module PosCounter(clk_1m, rst, echo, dis_count); // ???????????
input clk_1m, rst, echo;
output[11:0] dis_count;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; // ???? S0:??, S1:??????, S2:??????
reg[1:0] curr_state, next_state;
reg echo_reg1, echo_reg2;
assign start = echo_reg1&~echo_reg2;  //??posedge
assign finish = ~echo_reg1&echo_reg2; //??negedge
reg[19:0] count ;
reg[19:0] dis_reg; //????

always@(posedge clk_1m, posedge rst)
begin
    if(rst==1)
    begin
        echo_reg1 <= 0;
        echo_reg2 <= 0;
        count <= 0;
        dis_reg <= 0;
        curr_state <= S0;
    end
    else
    begin
        echo_reg1 <= echo;          // ??
        echo_reg2 <= echo_reg1;     // ???
        case(curr_state)
        S0:begin
                if (start==1) // ??????
                    curr_state <= next_state; //S1
                else
                    count <= 0;
            end
        S1:begin
                if (finish==1) // ??????
                    curr_state <= next_state; //S2
                else
                    begin
                        count <= count + 1;
                    end
            end
        S2:begin
                dis_reg <= count; // ??????
                count <= 0;
                curr_state <= next_state; //S0
            end
        endcase
    end
end

always@(curr_state)
begin
    case(curr_state)
    S0:next_state <= S1;
    S1:next_state <= S2;
    S2:next_state <= S0;
    endcase
end

assign dis_count = dis_reg/58; // ??,?100????? 12 (/58)

endmodule