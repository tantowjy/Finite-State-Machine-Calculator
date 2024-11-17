module math_divider_8bit_tb;
    reg [7:0] dividend;
    reg [7:0] divisor;
    wire [7:0] quotient;
    // wire [7:0] remainder;
    wire error;

    math_divider_8bit uut (
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        // .remainder(remainder),
        .error(error)
    );

    initial begin
        // test case
        dividend = 8'b11111110; divisor = 8'b10100101; #10;

        // test case
        dividend = 8'b10011011; divisor = 8'b11001001; #10;

        // test case
        dividend = 8'b00000000; divisor = 8'b10011010; #10;

        // test case
        dividend = 8'b01100110; divisor = 8'b00000000; #10;
    end
endmodule 