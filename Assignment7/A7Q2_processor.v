module processor;
 
    reg clk;
    reg [31:0] mem[6:0];

    // Counters 
    reg [2:0] pc = 0;
    reg [2:0] MAX_PC = 7;
    reg [2:0] OUTPUT_REG = 3'b101;
    reg [2:0] state = 0;
    reg [31:0] cur_inst;
    reg [1:0] counter = 0;

    // Variables for module
    reg [5:0] opcode;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [5:0] function_code;
    reg [7:0] immediate;

    reg [7:0] read_value_1;
    reg [7:0] read_value_2;
    reg signed [7:0] to_write;
    reg inst_valid = 0;

    reg [7:0] data;
    reg [2:0] valid_bits = 3'b000;
    wire [7:0] out1;
    wire [7:0] out2;
    wire output_valid;

    reg_file REG_FILE(clk, read_reg1, read_reg2, write_reg, data, valid_bits, out1, out2, output_valid);

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
        mem[0] = 32'b00100100000000010000000000101101;
        mem[1] = 32'b00100100000000101111111111101100;
        mem[2] = 32'b00100100000000111111111111000100;
        mem[3] = 32'b00100100000001000000000000011110;
        mem[4] = 32'b00000000001000100010100000100001;
        mem[5] = 32'b00000000011001000011000000100001;
        mem[6] = 32'b00000000101001100010100000100011;
    end

    always @(posedge clk) begin
        case(state)
            0:  begin
                valid_bits = 3'b000;
                cur_inst = mem[pc];
                pc = pc + 1;
                state = 1;
            end  

            1:  begin
                opcode = cur_inst[31:26];
                if(opcode == 6'b000000) begin
                    valid_bits = 3'b110;
                    read_reg1 = cur_inst[25:21];
                    read_reg2 = cur_inst[20:16];
                    write_reg = cur_inst[15:11];
                    function_code = cur_inst[5:0];
                end
                else if (opcode != 6'b000010 && opcode != 6'b000011) begin
                    valid_bits = 3'b100;
                    read_reg1 = cur_inst[25:21];
                    write_reg = cur_inst[20:16];
                    immediate = cur_inst[7:0];
                end
                state = 2;
            end

            2:  begin
                if(opcode == 6'b000000) begin
                    read_value_1 = out1;
                    read_value_2 = out2;
                end
                else if (opcode != 6'b000010 && opcode != 6'b000011) begin
                    read_value_1 = out1;
                end
                state = 3;
            end

            3:  begin
                if(opcode == 6'b001001) begin
                    inst_valid = 1;
                    to_write = read_value_1 + immediate;
                end
                if(opcode == 6'b000000 && function_code == 6'b100001) begin
                    inst_valid = 1;
                    to_write = read_value_1 + read_value_2;
                end
                if(opcode == 6'b000000 && function_code == 6'b100011) begin
                    inst_valid = 1;
                    to_write = read_value_1 - read_value_2;
                end
                else begin
                    inst_valid = 0;
                end
                state = 4;
            end

            4:  begin
                if (inst_valid != 0 && write_reg != 5'b00000) begin
                    data = to_write;
                end
                if (pc < MAX_PC) begin
                    state = 0;
                    data = to_write;
                    valid_bits = 3'b001;
                end
                else begin
                    if (counter == 0) begin
                        data = to_write;
                        valid_bits = 3'b001;
                        counter = counter + 1;
                    end
                    else if (counter == 1) begin
                        read_reg1 = OUTPUT_REG;
                        valid_bits = 3'b100;
                        state = 5;
                    end
                end
            end

            5:  begin
                $display("OUTPUT_REG: %d, output_reg: %d", out1, read_reg1);
                $finish;
            end
        endcase
    end

endmodule