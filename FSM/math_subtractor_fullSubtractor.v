// Full Subtractor

module math_subtractor_fullSubtractor(
    input A,
    input B,
    input borrowIn,
    output diff,
    output borrowOut
);
    
    wire notA;
    wire xorAB;
    wire andNotAB;
    wire orNotAB;
    wire andOrNotAB_borrowIn;

    // logic gates
    not (notA, A);
    xor (xorAB, A, B);
    xor (diff, xorAB, borrowIn);
    and (andNotAB, notA, B);
    or (orNotAB, notA, B);
    and (andOrNotAB_borrowIn, orNotAB, borrowIn);
    or (borrowOut, andNotAB, andOrNotAB_borrowIn);

endmodule 