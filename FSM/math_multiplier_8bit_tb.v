module math_multiplier_8bit_tb;
    // inputs
    reg [7:0] a;
    reg [7:0] b;
    // outputs
    wire [15:0] mulResult;

    // unit under test (uut)
    math_multiplier_8bit uut (.a(a), .b(b), .mulResult(mulResult));

    initial begin
        // test case 1
        a = 8'b00000001; b = 8'b00000001; // 1 * 1 = 1
        #10;

        // test case 2
        a = 8'b00001111; b = 8'b00000010; // 15 * 2 = 30
        #10;

        // test case 3
        a = 8'b11111111; b = 8'b00000001; // 255 * 1 = 255
        #10;

        // test case 4
        a = 8'b10101010; b = 8'b01010101; // 170 * 85 = 14450
        #10;

        // test case 5
        a = 8'b10000000; b = 8'b10000000; // 128 * 128 = 16384
        #10;

        // test case 6
        a = 8'b11111111; b = 8'b11111111; // 255 * 255 = 65025
        #10;
    end

endmodule 