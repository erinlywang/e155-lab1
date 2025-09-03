/// Author: Erin Wang
/// Email: eringwang@g.hmc.edu
/// Date: 08/31/2025

// top module takes input from the 4 DIP switches
// and outputs the 3LEDs and segments of a common-anode 7-segment display

module top( input	logic reset,
			input	logic [3:0] s,
			output	logic [2:0] led,
			output	logic [6:0] seg);

	logic s0, s1, s2, s3;
		  
	assign s3 = s[3];
	assign s2 = s[2];
	assign s1 = s[1];
	assign s0 = s[0];
	
	logic [23:0] counter;
	logic counter_output;
	
	logic int_osc;
		
	// Internal high-speed oscillator
	HSOSC #(.CLKHF_DIV(2'b01))
		  hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Counter
	always_ff @(posedge int_osc) begin
		if (reset==0)		counter <= 24'b0;
		else if (counter == 24'd5000000)	begin
			counter <= 24'b0;
			counter_output <= ~counter_output;
		end
		else				counter <= counter + 24'b1;
	end

	// combination output logic for led
	xor x1(led[0], s0, s1);				// led[0] = s0 ^ s1
	and a1(led[1], s2, s3);				// led[1] = s2 & s3
	assign led[2] = counter_output;		// led[2] is 1 every 10M counts at a 24 MHz frequency --> 2.4 Hz
			
	sevensegment sevseg(.in(s), .seg(seg));		
endmodule
	
