/// Author: Erin Wang
/// Email: eringwang@g.hmc.edu
/// Date: 08/31/2025

// tb_top module tests the top module 
// It applies inputs to top module and checks if outputs are as expected. 
// User provides patterns of inputs & desired outputs called testvectors. 

// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns

module tb_top(); 
    logic   clk, reset; 
    
    logic   [3:0] s;                 // input
    logic   [2:0] led, ledexpected;  // output
    logic   [6:0] seg, segexpected;  // output
    
    logic [31:0]  vectornum, errors; 
    logic [13:0]  testvectors[10000:0]; 

	//// Instantiate device under test (DUT). 
	// Inputs: s Outputs: led, seg
	top dut(reset, s, led, seg); 

	//// Generate clock. 
	always begin 
		clk=1; #5;  
		clk=0; #5; 
	end 

	//// Start of test.  
	initial begin 
		$readmemb("./top.tv", testvectors); 
		vectornum=0;  
		errors=0; 
		//// Pulse reset for 22 time units(2.2 cycles) so the reset signal falls after a clk edge. 
		reset=1; #22;  
		reset=0; 
	end 

	//// Apply test vectors on rising edge of clk. 
	always @(posedge clk) begin 
		#1; 
		{s, ledexpected, segexpected} = testvectors[vectornum]; 
	end


	//// Check results on falling edge of clk. 
	always @(negedge clk) 
		if (~reset) begin 
			if (led[1:0] !== ledexpected[1:0] || seg !== segexpected) begin 
				$display("Error: inputs = %b", {s}); 
				$display(" outputs = %b %b (%b %b expected)", led, seg, ledexpected, segexpected); 
				errors = errors + 1; 
			end 
			vectornum = vectornum + 1; 
			if (testvectors[vectornum] === 14'bx) begin 
				$display("%d tests completed with %d errors", vectornum, errors); 
				$stop; 
			end 
		end 
endmodule
