module multiplier_8bit_tb;
    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    // Outputs
    wire [15:0] MulResult;

    // Unit Under Test (UUT)
    multiplier_8bit uut (.A(A), .B(B), .MulResult(MulResult));

    initial begin
        // Test case 1
        A = 8'b00000001; B = 8'b00000001; // 1 * 1 = 1
        #10;

        // Test case 2
        A = 8'b00001111; B = 8'b00000010; // 15 * 2 = 30
        #10;

        // Test case 3
        A = 8'b11111111; B = 8'b00000001; // 255 * 1 = 255
        #10;

        // Test case 4
        A = 8'b10101010; B = 8'b01010101; // 170 * 85 = 14450
        #10;

        // Test case 5
        A = 8'b10000000; B = 8'b10000000; // 128 * 128 = 16384
        #10;

        // Test case 6
        A = 8'b11111111; B = 8'b11111111; // 255 * 255 = 65025
        #10;
    end

endmodule 