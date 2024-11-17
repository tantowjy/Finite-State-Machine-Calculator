// Array Multiplier

module math_multiplier_8bit(
    input [7:0] a,          // 8-bit input a
    input [7:0] b,          // 8-bit input b
    output [15:0] mulResult // 16-bit output multiplier
);

    wire [15:0] partial_products [7:0]; 

    // hitung partial products dengan array multiplier
    assign partial_products[0] = {8'b0, a[0] & b[7], a[0] & b[6], a[0] & b[5], a[0] & b[4], a[0] & b[3], a[0] & b[2], a[0] & b[1], a[0] & b[0]};
    assign partial_products[1] = {7'b0, a[1] & b[7], a[1] & b[6], a[1] & b[5], a[1] & b[4], a[1] & b[3], a[1] & b[2], a[1] & b[1], a[1] & b[0], 1'b0};
    assign partial_products[2] = {6'b0, a[2] & b[7], a[2] & b[6], a[2] & b[5], a[2] & b[4], a[2] & b[3], a[2] & b[2], a[2] & b[1], a[2] & b[0], 2'b0};
    assign partial_products[3] = {5'b0, a[3] & b[7], a[3] & b[6], a[3] & b[5], a[3] & b[4], a[3] & b[3], a[3] & b[2], a[3] & b[1], a[3] & b[0], 3'b0};
    assign partial_products[4] = {4'b0, a[4] & b[7], a[4] & b[6], a[4] & b[5], a[4] & b[4], a[4] & b[3], a[4] & b[2], a[4] & b[1], a[4] & b[0], 4'b0};
    assign partial_products[5] = {3'b0, a[5] & b[7], a[5] & b[6], a[5] & b[5], a[5] & b[4], a[5] & b[3], a[5] & b[2], a[5] & b[1], a[5] & b[0], 5'b0};
    assign partial_products[6] = {2'b0, a[6] & b[7], a[6] & b[6], a[6] & b[5], a[6] & b[4], a[6] & b[3], a[6] & b[2], a[6] & b[1], a[6] & b[0], 6'b0};
    assign partial_products[7] = {1'b0, a[7] & b[7], a[7] & b[6], a[7] & b[5], a[7] & b[4], a[7] & b[3], a[7] & b[2], a[7] & b[1], a[7] & b[0], 7'b0};
    
    // jumlahkan partial product dengan adder 16-bit
    wire [16:0] sum_pp1, sum_pp2, sum_pp3, sum_pp4, sum_pp5, sum_pp6, sum_pp7;

    math_adder_16bit adder_pp1 (.a(partial_products[0]), .b(partial_products[1]), .cin(1'b0), .sum(sum_pp1));
    math_adder_16bit adder_pp2 (.a(sum_pp1[15:0]), .b(partial_products[2]), .cin(sum_pp1[16]), .sum(sum_pp2));
    math_adder_16bit adder_pp3 (.a(sum_pp2[15:0]), .b(partial_products[3]), .cin(sum_pp2[16]), .sum(sum_pp3));
    math_adder_16bit adder_pp4 (.a(sum_pp3[15:0]), .b(partial_products[4]), .cin(sum_pp3[16]), .sum(sum_pp4));
    math_adder_16bit adder_pp5 (.a(sum_pp4[15:0]), .b(partial_products[5]), .cin(sum_pp4[16]), .sum(sum_pp5));
    math_adder_16bit adder_pp6 (.a(sum_pp5[15:0]), .b(partial_products[6]), .cin(sum_pp5[16]), .sum(sum_pp6));
    math_adder_16bit adder_pp7 (.a(sum_pp6[15:0]), .b(partial_products[7]), .cin(sum_pp6[16]), .sum(sum_pp7));

    assign mulResult = sum_pp7[15:0];

endmodule 