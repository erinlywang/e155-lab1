module clk_div(input	logic 	reset,
			   output	logic 	clk_divider);
				
	logic [23:0] counter;
	logic counter_output;
	
	logic int_osc;
		
	// Internal high-speed oscillator
	HSOSC #(.CLKHF_DIV(2'b01))
		  hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Counter
	always_ff @(posedge int_osc) begin
		if (reset)		counter <= 0;
		else if (counter == 24'd10000000)	begin
			counter <= 0;
			counter_output <= ~counter_output;
		end
		else										counter <= counter + 1;
	end
	
	assign clk_divider = counter_output;

endmodule