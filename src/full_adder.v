module full_adder (
    input A, B, Cin,
    output Sum, Cout
);

    wire S1, C1, C2;

    // Half Adder 1
    xor (S1, A, B);
    and (C1, A, B);

    // Half Adder 2
    xor (Sum, S1, Cin);
    and (C2, S1, Cin);

    // Carry Out
    or (Cout, C1, C2);

endmodule 