/// Author: Erin Wang
/// Email: eringwang@g.hmc.edu
/// Date: 08/31/2025

// tb_clkdiv module tests the clk_div module 
// It applies inputs to clk_div module and checks if outputs are as expected. 
// User provides patterns of inputs & desired outputs called testvectors. 

// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns

module tb_clkdiv(); 
    logic   clk, reset; 
    
    logic   clk_divider;   // output
    
    logic [3:0] errors;  

	//// Instantiate device under test (DUT). 
	// Inputs: clk, reset Outputs: clk_divider
	clk_div dut(reset, clk_divider); 

	//// Generate clock. 
	always begin 
		clk=0; #5;  
		clk=1; #5; 
	end 

	//// Start of test.  
	initial begin   
		errors=0; 
		//// Pulse reset for 22 time units(2.2 cycles) so the reset signal falls after a clk edge. 
		reset=1; #22;  
		reset=0; 
		#100
		if (clk_divider !== 0) begin 
			$display("Error: inputs = %b", {clk_divider}); 
			$display(" outputs = %b (%b expected)", clk_divider, 1'b0); 
			errors = errors + 1; 
		end 
		#62500000
		if (clk_divider !== 1) begin 
			$display("Error: inputs = %b", {clk_divider}); 
			$display(" outputs = %b (%b expected)", clk_divider, 1'b1); 
			errors = errors + 1; 
		end 
		$display("2 tests completed with %d errors", errors); 
		$stop; 
	end 
endmodule
