module FSM_Calculator (
    input clk,
    input [7:0] button,
    output reg clear,
    output reg [3:0] button_num,
    output reg [2:0] button_op,
    output reg equal,
    output reg [15:0] result_temp, result
);
    reg [2:0] state;
    reg [7:0] num1;
    reg [2:0] operation;
    
    // Output hasil operasi khusus
    wire [7:0] add_out, sub_out, mul_out, div_out;
    wire sub_error, div_error;

    // Definisi tombol keypad
    parameter [7:0] btnClear  = 8'b0000_0100,
                    btnZero   = 8'b0001_0100,
                    btnOne    = 8'b0000_0101,
                    btnTwo    = 8'b0001_0101,
                    btnThree  = 8'b0010_0101,
                    btnFour   = 8'b0000_0110,
                    btnFive   = 8'b0001_0110,
                    btnSix    = 8'b0010_0110,
                    btnSeven  = 8'b0000_0111,
                    btnEight  = 8'b0001_0111,
                    btnNine   = 8'b0010_0111,
                    btnAdd    = 8'b0011_0111, // '+'
                    btnSub    = 8'b0011_0110, // '-'
                    btnMul    = 8'b0011_0101, // '*'
                    btnDiv    = 8'b0011_0100, // '/'
                    btnEqual  = 8'b0010_0100; // '='

    // State encoding
    parameter [3:0] NUM_0 = 4'd0, NUM_1 = 4'd1, NUM_2 = 4'd2, NUM_3 = 4'd3, NUM_4 = 4'd4,
                NUM_5 = 4'd5, NUM_6 = 4'd6, NUM_7 = 4'd7, NUM_8 = 4'd8, NUM_9 = 4'd9;
    
    parameter [2:0] ADD = 3'b001, SUB = 3'b010, MUL = 3'b011, DIV = 3'b100;

    parameter IDLE = 3'b000, INPUT1 = 3'b001, INPUT2 = 3'b010, OPERATE = 3'b011, RESULT = 3'b100;

    // Logika pemetaan tombol ke nilai numerik dan operator
    always @(*) begin
        // Default values
        button_num = 4'b0;  // Nilai default untuk numerik (tidak dikenal)
        button_op = 3'b0;   // Nilai default untuk operator (tidak ada)
        equal = 1'b0;       // Default bukan tombol '='
        clear = 1'b0;       // Default bukan tombol 'Clear'

        case (button)
            // Numerik
            btnZero:  button_num = NUM_0;
            btnOne:   button_num = NUM_1;
            btnTwo:   button_num = NUM_2;
            btnThree: button_num = NUM_3;
            btnFour:  button_num = NUM_4;
            btnFive:  button_num = NUM_5;
            btnSix:   button_num = NUM_6;
            btnSeven: button_num = NUM_7;
            btnEight: button_num = NUM_8;
            btnNine:  button_num = NUM_9;

            // Operator
            btnAdd:   button_op = ADD;
            btnSub:   button_op = SUB;
            btnMul:   button_op = MUL;
            btnDiv:   button_op = DIV;

            // Tombol '='
            btnEqual: equal = 1'b1;

            // Tombol 'Clear'
            btnClear: clear = 1'b1;

            default: begin
                // Semua output tetap default jika tidak ada tombol dikenal
                button_num = 4'b0;
                button_op = 3'b0;
                equal = 1'b0;
                clear = 1'b0;
            end
        endcase
    end


    // Instansiasi modul matematika
    math_adder_8bit uut_add (
        .a(num1), 
        .b({4'b0, button_num}), 
        .cin(1'b0), 
        .sum(add_out)
    );
    
    math_subtractor_8bit uut_sub (
        .a(num1), 
        .b({4'b0, button_num}), 
        .borrowIn(1'b0), 
        .diff(sub_out), 
        .error(sub_error)
    );
    
    math_multiplier_8bit uut_mul (
        .a(num1), 
        .b({4'b0, button_num}), 
        .mulResult(mul_out)
    );
    
    math_divider_8bit uut_div (
        .dividend(num1), 
        .divisor({4'b0, button_num}), 
        .quotient(div_out), 
        .error(div_error)
    );

    // Logika state dan operasi tetap sama
    always @(posedge clk or posedge clear) begin
        if (clear) begin
            // Inisialisasi variabel
            num1 <= 8'b0;
            operation <= 3'b0;
            result_temp <= 16'b0;
            result <= 16'b0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (button_num >= NUM_0 && button_num <= NUM_9) begin
                        num1 <= {4'b0, button_num};
                        result_temp <= 16'b0;
                        result <= 16'b0;
                        state <= INPUT1;
                    end
                end

                INPUT1: begin
                    if (clear) begin
                        state <= IDLE;
                    end else if (button_op >= ADD && button_op <= DIV) begin
                        operation <= button_op;
                        state <= INPUT2;
                    end
                end

                INPUT2: begin
                    if (clear) begin
                        state <= IDLE;
                    end else if (button_num >= NUM_0 && button_num <= NUM_9) begin
                        
                        // Pilih hasil operasi berdasarkan jenis operasi
                        case (operation)
                            ADD: result_temp <= {8'b0, add_out};
                            SUB: result_temp <= {8'b0, sub_out};
                            MUL: result_temp <= {8'b0, mul_out};
                            DIV: result_temp <= (button_num != 0) ? {8'b0, div_out} : 16'd0;
                        endcase
                        
                        state <= RESULT;
                    end
                end

                RESULT: begin
                    if (clear) begin
                        state <= IDLE;
                    end else if (equal) begin
                        result <= result_temp;
                        state <= RESULT; 
                    end else if (button_op >= ADD && button_op <= DIV) begin
                        num1 <= result_temp[7:0];          
                        operation <= button_op;
                        state <= INPUT2;  
                    end else if (button_num >= NUM_0 && button_num <= NUM_9) begin
                        num1 <= {4'b0, button_num};
                        result_temp <= 16'b0;   // Set hasil sementara ke 0
                        result <= 16'b0;        // Set hasil ke 0
                        state <= INPUT1;
                    end
                end
            endcase
        end
    end

endmodule 