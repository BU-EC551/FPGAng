`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:59 03/18/2018 
// Design Name: 
// Module Name:    driver_top 
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
module driver_top(A1, A2, A3, A4, EN12, clk, Trig_l, Trig_r, Trig_f1, Trig_f2, Echo_l, Echo_r, Echo_f1, Echo_f2, serial);

	output A1, A2, A3, A4, EN12;
	
	
	input clk;
	input Echo_l,Echo_r,Echo_f1,Echo_f2;
	output Trig_l,Trig_r,Trig_f1,Trig_f2;
	wire a_run, a_backward, a_turn_left, a_turn_right, m_run, m_backward, m_turn_left, m_turn_right;
	input serial;
	wire [7:0] control_out;
	wire [1:0] m_speed;
	wire [1:0] real_speed;
	wire [1:0] mode;
	

	assign mode = control_out[1:0];
	assign m_speed = control_out[3:2];
	assign m_run = control_out[5];
	assign m_backward = control_out[4];
	assign m_turn_left = control_out[6];
	assign m_turn_right = control_out[7];
	
	assign real_speed = (mode == 2'b10) ? 2'b11 : m_speed;
	
	assign A1 = (mode == 2'b10) ? (a_run && ~a_backward) : (m_run && ~m_backward);
	assign A2 = (mode == 2'b10) ? (~a_run && a_backward) : (~m_run && m_backward);
	assign A3 = (mode == 2'b10) ? (a_turn_left && ~a_turn_right) : (m_turn_left && ~m_turn_right);
	assign A4 = (mode == 2'b10) ? (~a_turn_left && a_turn_right) : (~m_turn_left && m_turn_right);
	
	Top_sensor sensors(clk, , Trig_l, Trig_r, Trig_f1, Trig_f2, Echo_l, Echo_r, Echo_f1, Echo_f2, , , , a_backward, a_turn_left, a_turn_right, , a_run); 
	
	car_control manual(clk, serial, control_out);
	
	PWM_generator pwm(real_speed, EN12, clk, );
	

endmodule
