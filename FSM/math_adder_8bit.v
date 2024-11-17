// Ripple Carry Adder

module math_adder_8bit(
    input [7:0] a,      // 8-bit input a
    input [7:0] b,      // 8-bit input b
    input cin,          // carry input
    output [8:0] sum    // 9-bit output sum
);

    wire [7:0] carry;

    math_adder_fullAdder FA0 (.a(a[0]), .b(b[0]), .cin(cin),      .sum(sum[0]), .cout(carry[0]));
    math_adder_fullAdder FA1 (.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
    math_adder_fullAdder FA2 (.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
    math_adder_fullAdder FA3 (.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
    math_adder_fullAdder FA4 (.a(a[4]), .b(b[4]), .cin(carry[3]), .sum(sum[4]), .cout(carry[4]));
    math_adder_fullAdder FA5 (.a(a[5]), .b(b[5]), .cin(carry[4]), .sum(sum[5]), .cout(carry[5]));
    math_adder_fullAdder FA6 (.a(a[6]), .b(b[6]), .cin(carry[5]), .sum(sum[6]), .cout(carry[6]));
    math_adder_fullAdder FA7 (.a(a[7]), .b(b[7]), .cin(carry[6]), .sum(sum[7]), .cout(sum[8]));

endmodule 