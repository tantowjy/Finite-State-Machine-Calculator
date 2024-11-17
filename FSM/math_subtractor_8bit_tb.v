module math_subtractor_8bit_tb;
    reg [7:0] a;
    reg [7:0] b;
    reg borrowIn;
    wire [7:0] diff;
    wire error;

    math_subtractor_8bit uut (.a(a), .b(b), .borrowIn(borrowIn), .diff(diff), .error(error));

    initial begin
        // test case 1
        a = 8'b00001111; b = 8'b00000101; borrowIn = 0; #10;

        // test case 2
        a = 8'b10101010; b = 8'b01010101; borrowIn = 1; #10;

        // test case 3
        a = 8'b11110000; b = 8'b00001111; borrowIn = 0; #10;

        // test case 4
        a = 8'b00000000; b = 8'b11111111; borrowIn = 1; #10;

        // test case 5
        a = 8'b10000001; b = 8'b10000001; borrowIn = 0; #10;
    end

endmodule 