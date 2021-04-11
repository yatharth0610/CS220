module processor;
 
    reg clk;
    reg [31:0] mem[7:0];

    // Counters 
    reg [3:0] pc = 0;
    reg [2:0] count_R = 0;
    reg [2:0] count_I = 0;
    reg [2:0] count_J = 0;
    reg [2:0] count_3 = 0;
    reg [2:0] count_4 = 0;
    reg [2:0] count_5 = 0;
    reg [2:0] count_6 = 0;
    reg [32:0] cur_inst;

    // Setting up clk signal
    initial begin
        forever begin
            clk = 0;
            #5
            clk = 1;
            #5
            clk = 0;
        end
    end

    initial begin
        mem[0] = 32'b00100000000001000011010001010110;
        mem[1] = 32'b00100000000001011111111111111111;
        mem[2] = 32'b00000000101001000011000000010100;
        mem[3] = 32'b00100000000000110000000000000111;
        mem[4] = 32'b00000000011001100011000000000100;
        mem[5] = 32'b00000000000000110001100001000010;
        mem[6] = 32'b00010100100001011001101010111100;
        mem[7] = 32'b00001000000100100011010001010110;
    end

    always @(posedge clk) begin
        cur_inst = mem[pc];
        if (cur_inst[31:26] == 6'b000000) begin
            count_R = count_R + 1;
            case(cur_inst[15:11])
                5'b00011: count_3 = count_3 + 1;
                5'b00100: count_4 = count_4 + 1;
                5'b00101: count_5 = count_5 + 1;
                5'b00110: count_6 = count_6 + 1;
            endcase
        end
        else if (cur_inst[31:26] == 6'b000010 || cur_inst[31:26] == 6'b000011) begin
            count_J = count_J + 1;
        end
        else begin
            count_I = count_I + 1;
            case(cur_inst[20:16])
                5'b00011: count_3 = count_3 + 1;
                5'b00100: count_4 = count_4 + 1;
                5'b00101: count_5 = count_5 + 1;
                5'b00110: count_6 = count_6 + 1;
            endcase
        end
        pc = pc + 1;
        if (pc == 8) begin
            $display(" R-format : %d\n I-format : %d\n J-format : %d\n Writes to $3: %d\n Writes to $4: %d\n Writes to $5: %d\n Writes to $6: %d", count_R, count_I, count_J, count_3, count_4, count_5, count_6);
            $finish;
        end
    end

endmodule