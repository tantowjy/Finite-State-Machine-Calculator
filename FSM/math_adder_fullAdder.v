// Full Adder

module math_adder_fullAdder(
    input a, b, cin,
    output sum, cout
);

    wire S1, C1, C2;

    // half adder 1
    xor (S1, a, b);
    and (C1, a, b);

    // half adder 2
    xor (sum, S1, cin);
    and (C2, S1, cin);

    // carry out
    or (cout, C1, C2);

endmodule 