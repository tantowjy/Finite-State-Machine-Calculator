module multiplier_8bit (
    input [7:0] A, // 8-bit input A
    input [7:0] B, // 8-bit input B
    output [15:0] MulResult // 16-bit output P
);

    wire [15:0] partial_products [7:0]; // Array to hold partial products

    // Generate partial products manually
    assign partial_products[0] = {8'b0, A[0] & B[7], A[0] & B[6], A[0] & B[5], A[0] & B[4], A[0] & B[3], A[0] & B[2], A[0] & B[1], A[0] & B[0]};
    assign partial_products[1] = {7'b0, A[1] & B[7], A[1] & B[6], A[1] & B[5], A[1] & B[4], A[1] & B[3], A[1] & B[2], A[1] & B[1], A[1] & B[0], 1'b0};
    assign partial_products[2] = {6'b0, A[2] & B[7], A[2] & B[6], A[2] & B[5], A[2] & B[4], A[2] & B[3], A[2] & B[2], A[2] & B[1], A[2] & B[0], 2'b0};
    assign partial_products[3] = {5'b0, A[3] & B[7], A[3] & B[6], A[3] & B[5], A[3] & B[4], A[3] & B[3], A[3] & B[2], A[3] & B[1], A[3] & B[0], 3'b0};
    assign partial_products[4] = {4'b0, A[4] & B[7], A[4] & B[6], A[4] & B[5], A[4] & B[4], A[4] & B[3], A[4] & B[2], A[4] & B[1], A[4] & B[0], 4'b0};
    assign partial_products[5] = {3'b0, A[5] & B[7], A[5] & B[6], A[5] & B[5], A[5] & B[4], A[5] & B[3], A[5] & B[2], A[5] & B[1], A[5] & B[0], 5'b0};
    assign partial_products[6] = {2'b0, A[6] & B[7], A[6] & B[6], A[6] & B[5], A[6] & B[4], A[6] & B[3], A[6] & B[2], A[6] & B[1], A[6] & B[0], 6'b0};
    assign partial_products[7] = {1'b0, A[7] & B[7], A[7] & B[6], A[7] & B[5], A[7] & B[4], A[7] & B[3], A[7] & B[2], A[7] & B[1], A[7] & B[0], 7'b0};

    // Sum the partial products
    assign MulResult = partial_products[0] + partial_products[1] + partial_products[2] + partial_products[3] + 
                partial_products[4] + partial_products[5] + partial_products[6] + partial_products[7];

endmodule