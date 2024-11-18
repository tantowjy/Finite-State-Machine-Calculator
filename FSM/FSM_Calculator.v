module FSM_Calculator (
    input clk,
    input clear,                            // Tombol "Clear" dan "Reset"
    input [3:0] button_num,                 // Input angka 0-9
    input [2:0] button_op,                  // Input operasi (ADD, SUB, MUL, DIV)
    input equal,                            // Tombol "="
    output reg [15:0] result_temp, result
);
    reg [2:0] state;
    reg [7:0] num1, num2;
    reg [2:0] operation;

    // State encoding
    parameter [3:0] NUM_0 = 4'd0, NUM_1 = 4'd1, NUM_2 = 4'd2, NUM_3 = 4'd3, NUM_4 = 4'd4,
                NUM_5 = 4'd5, NUM_6 = 4'd6, NUM_7 = 4'd7, NUM_8 = 4'd8, NUM_9 = 4'd9;
    
    parameter [2:0] ADD = 3'b001, SUB = 3'b010, MUL = 3'b011, DIV = 3'b100;

    parameter IDLE = 3'b000, INPUT1 = 3'b001, INPUT2 = 3'b010, RESULT = 3'b011;

    always @(posedge clk or posedge clear) begin
        if (clear) begin
            num1 <= 8'b0;
            num2 <= 8'b0;
            operation <= 3'b0;
            result_temp <= 16'b0;
            result <= 16'b0;
            state <= IDLE;
        end else begin
            case (state)
                // IDLE state: Menunggu input digit pertama dan inisialisasi ulang variabel
                IDLE: begin
                    // Menerima satu digit angka pertama (0-9)
                    if (button_num >= NUM_0 && button_num <= NUM_9) begin
                        num1 <= button_num;
                        // Reset nilai result_temp dan result dari state RESULT
                        result_temp <= 16'b0;   // Set hasil sementara ke 0
                        result <= 16'b0;        // Set hasil ke 0
                        state <= INPUT1;
                    end
                end

                // INPUT1 state: Menunggu input operasi setelah angka pertama diinput
                INPUT1: begin
                    if (clear) begin
                        state <= IDLE;
                    end else if (button_op >= ADD && button_op <= DIV) begin
                        operation <= button_op;
                        state <= INPUT2;
                    end
                end

                // INPUT2 state: Menerima angka kedua untuk operasi dan hasil operasi sementara
                INPUT2: begin
                    if (clear) begin
                        state <= IDLE;
                    end else if (button_num >= NUM_0 && button_num <= NUM_9) begin
                        // Melakukan operasi sesuai dengan jenis operasi yang dipilih 
                        case (operation)
                            ADD: result_temp <= num1 + button_num;
                            SUB: result_temp <= num1 - button_num;
                            MUL: result_temp <= num1 * button_num;
                            DIV: result_temp <= button_num != 0 ? num1 / button_num : 16'd0; // Cek pembagian dengan 0
                        endcase
                        // state <= RESULT;
                        state <= RESULT;
                    end
                end

                // RESULT state
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
                        num1 <= button_num;
                        result_temp <= 16'b0;   // Set hasil sementara ke 0
                        result <= 16'b0;        // Set hasil ke 0
                        state <= INPUT1;
                    end
                end

            endcase
        end
    end
endmodule
