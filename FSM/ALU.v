module ALU(
    input [7:0] A, B,
    input enable_add,
    input enable_sub,
    input enable_mul,
    input enable_div,
    output [8:0] result_add,
    output [7:0] result_sub,
    output [15:0] result_mul,
    output [7:0] result_div,
    output error
);
    
    // output module
    wire [8:0] add_out;
    wire [7:0] sub_out;
    wire [15:0] mul_out;
    wire [7:0] div_out;
    wire sub_error;
    wire div_error;
    
    math_adder_8bit uut_add (.a(A), .b(B), .cin(1'b0), .sum(add_out));
    math_subtractor_8bit uut_sub (.a(A), .b(B), .borrowIn(1'b0), .diff(sub_out), .error(sub_error));
    math_multiplier_8bit uut_mul (.a(A), .b(B), .mulResult(mul_out));
    math_divider_8bit uut_div (.dividend(A), .divisor(B), .quotient(div_out), .error(div_error));
    
    // result
    assign result_add = enable_add ? add_out : 9'd0;
    assign result_sub = (enable_sub & ~sub_error) ? sub_out : 8'd0;
    assign result_mul = enable_mul ? mul_out : 16'd0;
    assign result_div = (enable_div & ~div_error) ? div_out : 8'd0;
    
    // assign error
    assign error = (enable_sub & sub_error) | (enable_div & div_error);

endmodule 
