`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:47 03/24/2018 
// Design Name: 
// Module Name:    Display 
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
module NumberDisplay(clk, Data, seven_seg_out, Select, rst);
input clk, rst;
input [11:0] Data;
output reg [7:0] seven_seg_out;
output reg [3:0] Select;//onehot
reg [3:0] display;
reg [17:0] count;
reg outclk;
wire [3:0] hundreds, tens, ones;

BCD_Conversion BCD(.hundreds(hundreds), .tens(tens), .ones(ones), .binary(Data));

always @(posedge clk or posedge rst) begin
    if(rst == 1) begin
       outclk <= 1'b0;
		 count <=  0;
	 end
    else if (count == 249999) begin//249999
        count <=0;
        outclk <=~outclk;
    end
    else if (count < 249999)//249999
        count <= count +1;

end

always@(posedge outclk, posedge rst)
begin
	if(rst)
	begin
		Select <=4'b0111;
	end
	else


case(Select)
	4'b0111:
	begin
	Select <= 4'b1011;  //0
	display <= hundreds;//ObserveData[11:8];
	end
	4'b1011:
	begin
	Select <= 4'b1101;  //1
	display <= tens;//ObserveData[7:4];
	end
	4'b1101:
	begin
	Select <= 4'b1110;  //2
	display <= ones;//ObserveData[3:0];
	end
	4'b1110:
	begin
	Select <= 4'b0111;  //3
	display <= 4'b0000;//ObserveData[15:12];
	end
	default:
	begin
	Select <=4'b0000;
	display <= 4'b0000;
	end
endcase			
end
always @(display)
begin
case(display)
4'b0000 :      	//Hexadecimal 0
seven_seg_out <= 8'b00000011;
4'b0001 :    		//Hexadecimal 1
seven_seg_out <= 8'b10011111 ;
4'b0010 :  		// Hexadecimal 2
seven_seg_out <= 8'b00100101 ; 
4'b0011 : 		// Hexadecimal 3
seven_seg_out <= 8'b00001101 ;
4'b0100 :		// Hexadecimal 4
seven_seg_out <= 8'b10011001 ;
4'b0101 :		// Hexadecial 5
seven_seg_out <= 8'b01001001 ;  
4'b0110 :		// Hexadecimal 6
seven_seg_out <= 8'b01000001 ;
4'b0111 :		// Hexadecimal 7
seven_seg_out <= 8'b00011111;
4'b1000 :     	//Hexadecimal 8
seven_seg_out <= 8'b00000001 ;
4'b1001 :       //Hexadecimal 9
seven_seg_out <= 8'b00001001 ;
4'b1010 :  		// Hexadecimal A
seven_seg_out <= 8'b00010001 ; 
4'b1011 : 		// Hexadecimal B
seven_seg_out <= 8'b11000001 ;
4'b1100 :		// Hexadecimal C
seven_seg_out <= 8'b01100011 ;
4'b1101 :		// Hexadecimal D
seven_seg_out <= 8'b10000101 ;
4'b1110 :		// Hexadecimal E
seven_seg_out <= 8'b01100001 ;
4'b1111 :		// Hexadecimal F
seven_seg_out <= 8'b01110001 ;
default:
seven_seg_out <= 8'b00000100;
endcase
end
endmodule
