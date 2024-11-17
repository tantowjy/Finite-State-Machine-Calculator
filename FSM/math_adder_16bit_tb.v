module math_adder_16bit_tb;
    // inputs
    reg [15:0] a;
    reg [15:0] b;
    reg cin;
    // outputs
    wire [16:0] sum;

    // unit under test (uut)
    math_adder_16bit uut (.a(a), .b(b), .cin(cin), .sum(sum));

    initial begin
        // test case 1
        a = 16'h0001; b = 16'h0001; cin = 0; #10; 

        // test case 2
        a = 16'h0001; b = 16'h0001; cin = 1; #10;

        // test case 3
        a = 16'h0FFF; b = 16'h0001; cin = 0; #10;

        // test case 4
        a = 16'h0FFF; b = 16'h0001; cin = 1; #10;

        // test case 5: max value
        a = 16'hFFFF; b = 16'hFFFF; cin = 0; #10;
    end

endmodule
