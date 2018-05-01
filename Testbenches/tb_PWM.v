`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:32:43 03/21/2018
// Design Name:   PWM_generator
// Module Name:   X:/Documents/EC551/motor_driver/tb_PWM.v
// Project Name:  motor_driver
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PWM_generator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_PWM;

	// Inputs
	reg [6:0] D;
	reg clk;
	reg rst;

	// Outputs
	wire pwm;

	// Instantiate the Unit Under Test (UUT)
	PWM_generator uut (
		.D(D), 
		.pwm(pwm), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		D = 7'd20;;
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#10 rst = 0;
		#100 D = 7'd70;

	end
	
	always #1 clk = ~clk;
      
endmodule

