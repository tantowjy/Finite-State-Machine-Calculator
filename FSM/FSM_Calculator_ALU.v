module FSM_Calculator_ALU (
    input clk,
    input clear,
    input [3:0] button_num,
    input [2:0] button_op,
    input equal,
    output reg [15:0] result_temp, result
);
    reg [2:0] state;
    reg [7:0] num1;
    reg [2:0] operation;
    
    // Output hasil operasi khusus
    wire [7:0] add_out, sub_out, mul_out, div_out;
    wire sub_error, div_error;

    // State encoding
    parameter [3:0] NUM_0 = 4'd0, NUM_1 = 4'd1, NUM_2 = 4'd2, NUM_3 = 4'd3, NUM_4 = 4'd4,
                NUM_5 = 4'd5, NUM_6 = 4'd6, NUM_7 = 4'd7, NUM_8 = 4'd8, NUM_9 = 4'd9;
    
    parameter [2:0] ADD = 3'b001, SUB = 3'b010, MUL = 3'b011, DIV = 3'b100;

    parameter IDLE = 3'b000, INPUT1 = 3'b001, INPUT2 = 3'b010, OPERATE = 3'b011, RESULT = 3'b100;


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