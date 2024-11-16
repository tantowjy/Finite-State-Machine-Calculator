module subtractor_8bit_tb;
    reg [7:0] A;
    reg [7:0] B;
    reg BorrowIn;
    wire [7:0] Diff;
    wire error;

    subtractor_8bit uut (.A(A), .B(B), .BorrowIn(BorrowIn), .Diff(Diff), .error(error));

    initial begin
        // Test case 1
        A = 8'b00001111; B = 8'b00000101; BorrowIn = 0; #10;

        // Test case 2
        A = 8'b10101010; B = 8'b01010101; BorrowIn = 1; #10;

        // Test case 3
        A = 8'b11110000; B = 8'b00001111; BorrowIn = 0; #10;

        // Test case 4
        A = 8'b00000000; B = 8'b11111111; BorrowIn = 1; #10;

        // Test case 5
        A = 8'b10000001; B = 8'b10000001; BorrowIn = 0; #10;
    end

endmodule 