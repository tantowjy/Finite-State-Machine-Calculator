module ALU_tb;
	reg [7:0] A;
	reg [7:0] B;
	reg enable_add;
	reg enable_sub;
	reg enable_mul;
	reg enable_div;
	
	wire [8:0] result_add;
	wire [7:0] result_sub;
	wire [15:0] result_mul;
	wire [7:0] result_div;
	wire error;

	// unit under test (uut)
	ALU uut (
		.A(A), .B(B),
		.enable_add(enable_add), .enable_sub(enable_sub), .enable_mul(enable_mul), .enable_div(enable_div),
		.result_add(result_add), .result_sub(result_sub), .result_mul(result_mul), .result_div(result_div),
		.error(error)
	);

	initial begin
		// test case 1: adder
		enable_add = 1; enable_sub = 0;enable_mul=0; enable_div=0;
		A = 8'd15;  B = 8'd10;  #10;
		A = 8'd100; B = 8'd27;  #10;
		A = 8'd200; B = 8'd55;  #10;
		A = 8'd123; B = 8'd215; #10;
		
		// test case 2: subtractor
		enable_add = 0; enable_sub = 1; enable_mul=0; enable_div=0;
		A = 8'd15;  B = 8'd10;  #10;
		A = 8'd100; B = 8'd27;  #10;
		A = 8'd200; B = 8'd55;  #10;
		A = 8'd123; B = 8'd215; #10;
		
		// test case 3: multiplier
		enable_add = 0; enable_sub = 0; enable_mul=1; enable_div=0;
		A = 8'd15;  B = 8'd10;  #10;
		A = 8'd100; B = 8'd27;  #10;
		A = 8'd200; B = 8'd55;  #10;
		A = 8'd123; B = 8'd215; #10;
		
		// test case 4: divider
		enable_add = 0; enable_sub = 0; enable_mul=0; enable_div=1;
		A = 8'd15;  B = 8'd10;  #10;
		A = 8'd100; B = 8'd27;  #10;
		A = 8'd0;   B = 8'd55;  #10;
		A = 8'd123; B = 8'd0;   #10;
	end

endmodule
