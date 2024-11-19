module FSM_Calculator_ALU_tb;
    reg clk;
    reg clear;                            // Tombol "Clear"
    reg [3:0] button_num;                 // Input angka 0-9
    reg [2:0] button_op;                  // Input operasi (ADD, SUB, MUL, DIV)
    reg equal;                            // Tombol "="
    wire [15:0] result_temp, result;

    // Instantiate the FSM_Calculator module
    FSM_Calculator_ALU uut (
        .clk(clk),
        .clear(clear),
        .button_num(button_num),
        .button_op(button_op),
        .equal(equal),
        .result_temp(result_temp),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        clear = 0;
        button_num = 4'd0;
        button_op = 3'b0;
        equal = 0;
        

        // Apply reset using clear
        clear = 1; #10;
        clear = 0;

        // Test sequence: 5 + 3 = 8 C
        // Input first number (5)
        button_num = 4'd5; #10;
        // Input operation (ADD)
        button_op = 3'b001; #10;
        button_op = 3'b0;
        // Input second number (3)
        button_num = 4'd3; #10;
        // Wait for result (EQUAL)
        equal = 1; #10;
        equal = 0;
        // Clear the calculator (CLEAR)
        clear = 1; #10;
        clear = 0;

        // Test sequence: 5 - 3 + 2 = 4
        // Input first number (5)
        button_num = 4'd5; #10;
        // Input operation (SUB)
        button_op = 3'b010; #10;
        button_op = 3'b0;
        // Input second number (3)
        button_num = 4'd3; #10;
        // Input operation (ADD)
        button_op = 3'b001; #10;
        button_op = 3'b0;
        // Input third number (2)
        button_num = 4'd2; #10;
        // Wait for result (EQUAL)
        equal = 1; #10;
        equal = 0;
        
        // Test sequence: 6 / 3 = 2 * 8 = 16
        // Input first number (6)
        button_num = 4'd6; #10;
        // Input operation (DIV)
        button_op = 3'b100; #10;
        button_op = 3'b0;
        // Input second number (3)
        button_num = 4'd3; #10;
        // Wait for result (EQUAL)
        equal = 1; #10;
        equal = 0;
        // Input operation (MUL)
        button_op = 3'b011; #10;
        button_op = 3'b0;
        // Input third number (8)
        button_num = 4'd8; #10;
        // Wait for result (EQUAL)
        equal = 1; #10;
        equal = 0;
        // Clear the calculator (CLEAR)
        clear = 1; #10;
        clear = 0;

        // Finish simulation
        $stop;
    end

endmodule