// Ripple Borrow Subtractor

module math_subtractor_8bit(
    input [7:0] a,
    input [7:0] b,
    input borrowIn,
    output [7:0] diff,
    output error
);
    wire [7:0] borrow;

    // 8-bit full subtractors
    math_subtractor_fullSubtractor fs0 (.A(a[0]), .B(b[0]), .borrowIn(borrowIn), .diff(diff[0]), .borrowOut(borrow[0]));
    math_subtractor_fullSubtractor fs1 (.A(a[1]), .B(b[1]), .borrowIn(borrow[0]), .diff(diff[1]), .borrowOut(borrow[1]));
    math_subtractor_fullSubtractor fs2 (.A(a[2]), .B(b[2]), .borrowIn(borrow[1]), .diff(diff[2]), .borrowOut(borrow[2]));
    math_subtractor_fullSubtractor fs3 (.A(a[3]), .B(b[3]), .borrowIn(borrow[2]), .diff(diff[3]), .borrowOut(borrow[3]));
    math_subtractor_fullSubtractor fs4 (.A(a[4]), .B(b[4]), .borrowIn(borrow[3]), .diff(diff[4]), .borrowOut(borrow[4]));
    math_subtractor_fullSubtractor fs5 (.A(a[5]), .B(b[5]), .borrowIn(borrow[4]), .diff(diff[5]), .borrowOut(borrow[5]));
    math_subtractor_fullSubtractor fs6 (.A(a[6]), .B(b[6]), .borrowIn(borrow[5]), .diff(diff[6]), .borrowOut(borrow[6]));
    math_subtractor_fullSubtractor fs7 (.A(a[7]), .B(b[7]), .borrowIn(borrow[6]), .diff(diff[7]), .borrowOut(borrow[7]));

    assign error = borrow[7]; // error terjadi jika a < b

endmodule 