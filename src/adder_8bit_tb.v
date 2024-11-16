module adder_8bit_tb;
    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    // Outputs
    wire [8:0] Sum;

    // Unit Under Test (UUT)
    adder_8bit uut (.A(A), .B(B), .Cin(Cin), .Sum(Sum));

    initial begin
        A = 0; B = 0; Cin = 0; #10;
        
        // Test case 1
        A = 8'b00000001; B = 8'b00000001; Cin = 0; #10;

        // Test case 2
        A = 8'b11111111; B = 8'b00000001; Cin = 0; #10;

        // Test case 3
        A = 8'b10101010; B = 8'b01010101; Cin = 1; #10;

        // Test case 4
        A = 8'b00001111; B = 8'b11110000; Cin = 0; #10;

        // Test case 5
        A = 8'b10000000; B = 8'b10000000; Cin = 1; #10;
    end

endmodule 