module command_parser(drive_line, data_in, key_val, press, ready,mode);
	//input				clk;
	input 					drive_line;
	input 		 [7:0]	data_in;
	output 	reg			ready;
	output	reg [2:0] 	key_val; 		// Current pressed key
	output 	reg 			press;  			// 1 if pressed 0 if released
	output  	reg [1:0]   mode;
	// Internal state variables
	reg [7:0] 	current_byte;
	// Control is {1'bLeft, 1'bRight, 1'bForward, 1'bBack, 2'bSpeed, 2'bMode}
	//reg [7:0]	control = 8'b00000000;
	reg [7:0]	check_sum;
	reg [2:0]	state = 0;

	
	always @(posedge drive_line) begin
		// Latch current byte from changes in read module
		current_byte <= data_in;
		
		case (state)
			3'b000: 
			begin 
			// Beginning: looking for !
				check_sum <= 0; // Reset check sum if at beginning
				ready <= 1'b0;
				//if(drive_line) 
				//begin
				 case (current_byte)
					8'h61: mode <= 2'b10; // recieve a
					8'h63: mode <= 2'b01; // recieve c
					8'h73: mode <= 2'b00; // recieve s
					8'h21:
						begin
						state <= 3'b001;
						check_sum <= check_sum + 8'h21;
						end
					default:
					begin
						state <= 3'b000;
					end
				 endcase
			end
			
			
			3'b001: 
			begin //STATE
			// ! Received: looking for B
				//if(drive_line) 
				//begin
					if(current_byte == 8'h42) 
					begin
						state <= 3'b010; // Found B move on to next state:
						check_sum <= check_sum + 8'h42;	
					end
					else 
					begin
						state <= 3'b000; // Saw wrong value, reset to start
					end
				//end
				//else 
				//begin
					// Waiting for byte to be ready.. stay in state
					//state <= 3'b001; // Not ready for new byte yet, stay
				//end
			end
			
			
			3'b010: 
			begin //STATE 
			// B Received: looking for Button Number
				//if(drive_line) 
				//begin
					case (current_byte) // BYTE
						8'h31: 
						begin // Speed one button
							check_sum <= check_sum + 8'h31;	
							key_val <= 3'b000;
							state <= 3'b011;
						end
						
						8'h32: 
						begin // Speed two button
							check_sum <= check_sum + 8'h32;	
							key_val <= 3'b001;
							state <= 3'b011;
						end
						
						8'h33: 
						begin // Speed three button
							check_sum <= check_sum + 8'h33;	
							key_val <= 3'b010;
							state <= 3'b011;
						end
						
						8'h34: 
						begin // Speed four button
							check_sum <= check_sum + 8'h34;	
							key_val <= 3'b011;
							state <= 3'b011;
						end
						
						8'h35: 
						begin // Up button 
							check_sum <= check_sum + 8'h35;	
							key_val <= 3'b100;
							state <= 3'b011;
						end
						
						8'h36: 
						begin // Down button
							check_sum <= check_sum + 8'h36;	
							key_val <= 3'b101;
							state <= 3'b011;
						end
						
						8'h37: 
						begin // Left button
							check_sum <= check_sum + 8'h37;	
							key_val <= 3'b110;
							state <= 3'b011;
						end
						
						8'h38: 
						begin // Right button
							check_sum <= check_sum + 8'h38;	
							key_val <= 3'b111;
							state <= 3'b011;
						end
						
						default: state <= 3'b000; 
					endcase // BYTE
				//end
				//else begin
					// Waiting for byte to be ready.. stay in state
					//state <= 3'b010; 
				//end
			end


			3'b011: begin // STATE
			// Button number received, looking for up/down:
				//if(drive_line) begin
					case (current_byte) // BYTE
						8'h30: begin
							// Button Released
							check_sum <= check_sum + 8'h30;	
							press <= 1'b0;
							state <= 3'b100;
						end
						
						8'h31: begin
							// Button Pressed down
							check_sum <= check_sum + 8'h31;	
							press <= 1'b1;
							state <= 3'b100;
						end
						
						default: begin
							// Got unexpected value, reset
							state <= 3'b000;
						end
						
					endcase // BYTE
				//end
				//else begin
					// Waiting for byte to be ready.. stay in state
					//state <= 3'b011;
				//end
			end
	
		
			3'b100: begin // STATE
			// Up down received looking for CRC:
				//if(drive_line) begin
					// Check CRC calculation vs one that was received
					check_sum <= ~(check_sum);	
					if(current_byte == check_sum) begin
						// Checksum correct move on & set control values
						state <= 3'b000;
						ready <= 1'b1;
					end
					else begin
						// Checksum wrong.. reset
						state <= 3'b000;
						ready <= 1'b1;
					end
				//end
				//else begin
					// Waiting for byte to be ready.. stay in state
					//state <= 3'b100;
				//end
			end
			
			// If somehow in unknown state reset to begin
			default: state <= 3'b000;
		endcase
		
		
	end
	
	//assign control_out = control;
	
endmodule