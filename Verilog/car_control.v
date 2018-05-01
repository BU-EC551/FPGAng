`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:56 04/24/2018 
// Design Name: 
// Module Name:    car_control 
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
module car_control(
		clk,
		serial,
		control_out
    );
	// IO Declarations
	input 			clk;
	input 			serial;
	output [7:0]	control_out;
	
	// Internal Declarations
	wire 			rx_drive_out;
	wire [7:0]	byte_o;
	wire			ready;
	wire [2:0]	key_val;
	wire			press;
	wire [1:0]  mode;
	
	uart_bluetooth_rx rx(clk, serial, rx_drive_out, byte_o);
	command_parser	parse(rx_drive_out, byte_o, key_val, press, ready,mode);
	controller control(mode, ready, key_val, press, control_out, clk);

endmodule
