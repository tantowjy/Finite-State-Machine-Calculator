// Ripple Carry Adder

module math_adder_16bit(
    input [15:0] a,   // 16-bit input a
    input [15:0] b,   // 16-bit input b
    input cin,        // carry input
    output [16:0] sum // 17-bit output sum
);

    wire [15:0] carry;

    math_adder_fullAdder FA0  (.a(a[0]), .b(b[0]), .cin(cin),       .sum(sum[0]),  .cout(carry[0]));
    math_adder_fullAdder FA1  (.a(a[1]), .b(b[1]), .cin(carry[0]),  .sum(sum[1]),  .cout(carry[1]));
    math_adder_fullAdder FA2  (.a(a[2]), .b(b[2]), .cin(carry[1]),  .sum(sum[2]),  .cout(carry[2]));
    math_adder_fullAdder FA3  (.a(a[3]), .b(b[3]), .cin(carry[2]),  .sum(sum[3]),  .cout(carry[3]));
    math_adder_fullAdder FA4  (.a(a[4]), .b(b[4]), .cin(carry[3]),  .sum(sum[4]),  .cout(carry[4]));
    math_adder_fullAdder FA5  (.a(a[5]), .b(b[5]), .cin(carry[4]),  .sum(sum[5]),  .cout(carry[5]));
    math_adder_fullAdder FA6  (.a(a[6]), .b(b[6]), .cin(carry[5]),  .sum(sum[6]),  .cout(carry[6]));
    math_adder_fullAdder FA7  (.a(a[7]), .b(b[7]), .cin(carry[6]),  .sum(sum[7]),  .cout(carry[7]));
    math_adder_fullAdder FA8  (.a(a[8]), .b(b[8]), .cin(carry[7]),  .sum(sum[8]),  .cout(carry[8]));
    math_adder_fullAdder FA9  (.a(a[9]), .b(b[9]), .cin(carry[8]),  .sum(sum[9]),  .cout(carry[9]));
    math_adder_fullAdder FA10 (.a(a[10]), .b(b[10]), .cin(carry[9]), .sum(sum[10]), .cout(carry[10]));
    math_adder_fullAdder FA11 (.a(a[11]), .b(b[11]), .cin(carry[10]), .sum(sum[11]), .cout(carry[11]));
    math_adder_fullAdder FA12 (.a(a[12]), .b(b[12]), .cin(carry[11]), .sum(sum[12]), .cout(carry[12]));
    math_adder_fullAdder FA13 (.a(a[13]), .b(b[13]), .cin(carry[12]), .sum(sum[13]), .cout(carry[13]));
    math_adder_fullAdder FA14 (.a(a[14]), .b(b[14]), .cin(carry[13]), .sum(sum[14]), .cout(carry[14]));
    math_adder_fullAdder FA15 (.a(a[15]), .b(b[15]), .cin(carry[14]), .sum(sum[15]), .cout(sum[16]));

endmodule
