module full_subtractor (
    input A,
    input B,
    input BorrowIn,
    output Diff,
    output BorrowOut
);
    wire notA;
    wire xorAB;
    wire andNotAB;
    wire orNotAB;
    wire andOrNotAB_BorrowIn;

    // Logic gates
    not (notA, A);
    xor (xorAB, A, B);
    xor (Diff, xorAB, BorrowIn);
    and (andNotAB, notA, B);
    or (orNotAB, notA, B);
    and (andOrNotAB_BorrowIn, orNotAB, BorrowIn);
    or (BorrowOut, andNotAB, andOrNotAB_BorrowIn);
endmodule 