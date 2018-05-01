`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:37:22 04/25/2018
// Design Name:   command_parser
// Module Name:   X:/Desktop/BLUETOOTH_uart/uart_Bluetooth/command_parser_tb.v
// Project Name:  uart_Bluetooth
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: command_parser
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module command_parser_tb;

	// Inputs
	reg drive_line;
	reg [7:0] data_in;

	// Outputs
	wire [2:0] key_val;
	wire press;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	command_parser uut (
		.drive_line(drive_line), 
		.data_in(data_in), 
		.key_val(key_val), 
		.press(press), 
		.ready(ready)
	);

	initial begin
		// Initialize Inputs
		#10;
		drive_line = 0;
		data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
      data_in = 8'h21; // !
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h42; // B
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h33; // button 3
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h30; // release
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		
		data_in = 8'h21; // !
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h62; // b
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h35; // up button
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;
		data_in = 8'h30; // release
		#10;
		drive_line = 1;
		#10;
		drive_line = 0;
		#10;

		
		// Add stimulus here

	end
      
endmodule

