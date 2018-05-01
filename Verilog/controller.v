`timescale 1ns / 1ps

module controller(
		mode,
		ready,
		key_val,
		press,
		controls_out,
		clk
    );
	
	input clk;
	input [1:0] mode; 
	input ready, press;
	input [2:0] key_val;
	output [7:0] controls_out;
	
	reg [7:0] control = 8'b0;
	
	
	always @(posedge clk)
	begin
		case (key_val) // BYTE
			3'b000: begin
			// Speed one button: if released set speed to 1
				if(!press) begin
					control[3:2] <= 2'b00;
				end
			end
			
			3'b001: begin
			// Speed two button: if released set speed to 2
				if(!press) begin
					control[3:2] <= 2'b01;
				end
			end
			
			3'b010: begin
			// Speed three button: if released set speed to 3
				if(!press) begin
					control[3:2] <= 2'b10;
				end
			end
			
			3'b011: begin
			// Speed four button: if released set speed to 4
				if(!press) begin
					control[3:2] <= 2'b11;
				end
			end
			
			3'b100: begin
			// Up button: if released set direction forward
				if(!press) begin
					// Forward bit high, backward low
					control[5:4] <= 2'b10;
				end
			end
			
			3'b101: begin
			// Down button: if released set direction backward
				if(!press) begin
					// Forward bit high, backward low
					control[5:4] <= 2'b01;
				end
			end
			
			3'b110: begin
			// Left button: while holding steer left
				if(press) begin
					if(control[6]) begin
						// If other direction held down, go straight
						control[7:6] <= 2'b00;
					end
					else begin
						// Pressed, turn left until release
						control[7] <= 1'b1;
					end
				end
				else begin
					// Released, go straight
					control[7] <= 1'b0;
				end
			end
			
			3'b111: begin
			// Right button: while holding steer right
				if(press) begin
					if(control[7]) begin
						// If other direction held down, go straight
						control[7:6] <= 2'b00;
					end
					else begin
						// Pressed, turn left until release
						control[6] <= 1'b1;
					end
				end
				else begin
					// Released, go straight
					control[6] <= 1'b0;
				end
			end
		endcase
	end

	assign controls_out[7:2] = control[7:2];
	assign controls_out[1:0] = mode;

endmodule
