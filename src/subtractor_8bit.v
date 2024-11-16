module subtractor_8bit (
    input [7:0] A,
    input [7:0] B,
    input BorrowIn,
    output [7:0] Diff,
    output error
);
    wire [7:0] borrow;

    // 8-bit full subtractors
    full_subtractor fs0 (.A(A[0]), .B(B[0]), .BorrowIn(BorrowIn), .Diff(Diff[0]), .BorrowOut(borrow[0]));
    full_subtractor fs1 (.A(A[1]), .B(B[1]), .BorrowIn(borrow[0]), .Diff(Diff[1]), .BorrowOut(borrow[1]));
    full_subtractor fs2 (.A(A[2]), .B(B[2]), .BorrowIn(borrow[1]), .Diff(Diff[2]), .BorrowOut(borrow[2]));
    full_subtractor fs3 (.A(A[3]), .B(B[3]), .BorrowIn(borrow[2]), .Diff(Diff[3]), .BorrowOut(borrow[3]));
    full_subtractor fs4 (.A(A[4]), .B(B[4]), .BorrowIn(borrow[3]), .Diff(Diff[4]), .BorrowOut(borrow[4]));
    full_subtractor fs5 (.A(A[5]), .B(B[5]), .BorrowIn(borrow[4]), .Diff(Diff[5]), .BorrowOut(borrow[5]));
    full_subtractor fs6 (.A(A[6]), .B(B[6]), .BorrowIn(borrow[5]), .Diff(Diff[6]), .BorrowOut(borrow[6]));
    full_subtractor fs7 (.A(A[7]), .B(B[7]), .BorrowIn(borrow[6]), .Diff(Diff[7]), .BorrowOut(borrow[7]));

    assign error = borrow[7]; // Error terjadi jika A < B
endmodule 