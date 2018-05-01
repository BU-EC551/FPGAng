`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:29:45 04/25/2018
// Design Name:   controller
// Module Name:   X:/Desktop/BLUETOOTH_uart/uart_Bluetooth/controller_tb.v
// Project Name:  uart_Bluetooth
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controller_tb;

	// Inputs
	reg ready;
	reg [2:0] key_val;
	reg press;

	// Outputs
	wire [7:0] controls_out;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.ready(ready), 
		.key_val(key_val), 
		.press(press), 
		.controls_out(controls_out)
	);

	initial begin
		// Initialize Inputs
		ready = 0;
		key_val = 0;
		press = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// release forward
		key_val = 3'b100;
		press = 0; 
		#10
		ready = 1;
		#10
		ready = 0;
		#10
		// release speed 3
      key_val = 3'b010;
		press = 0; 
		#10
		ready = 1;
	end
      
endmodule

