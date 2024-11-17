module math_adder_8bit_tb;
    // inputs
    reg [7:0] a;
    reg [7:0] b;
    reg cin;
    // outputs
    wire [8:0] sum;

    // unit under test (uut)
    math_adder_8bit uut (.a(a), .b(b), .cin(cin), .sum(sum));

    initial begin
        a = 0; b = 0; cin = 0; #10;
        
        // test case 1
        a = 8'b00000001; b = 8'b00000001; cin = 0; #10;

        // test case 2
        a = 8'b11111111; b = 8'b00000001; cin = 0; #10;

        // test case 3
        a = 8'b10101010; b = 8'b01010101; cin = 1; #10;

        // test case 4
        a = 8'b00001111; b = 8'b11110000; cin = 0; #10;

        // test case 5
        a = 8'b10000000; b = 8'b10000000; cin = 1; #10;
    end

endmodule 