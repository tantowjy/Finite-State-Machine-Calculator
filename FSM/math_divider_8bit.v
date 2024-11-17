// Restoring Divison Architecture

module math_divider_8bit(
    input [7:0] dividend,           // dividend 8-bit
    input [7:0] divisor,            // divisor 8-bit
    output reg [7:0] quotient,      // hasil pembagian 8-bit
    // output reg [7:0] remainder,  // sisa pembagian 8-bit
    output reg error
);

    integer i;
    reg [15:0] dividend_extended; // temp register for bitwise shifting

    always @(*) begin
        if (divisor != 0) begin
            dividend_extended = {8'b0, dividend};
            quotient = 8'b0;
            error = 0;                       

            for (i = 7; i >= 0; i = i - 1) begin
                dividend_extended = dividend_extended << 1;
                if (dividend_extended[15:8] >= divisor) begin
                    dividend_extended[15:8] = dividend_extended[15:8] - divisor;
                    quotient[i] = 1;
                end
            end

            // remainder = dividend_extended[15:8];
        end 
        else begin
            quotient = 8'b0;
            // remainder = 8'b0;
            error = 1;
        end
    end
endmodule
