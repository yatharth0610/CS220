module processor;
 
    reg clk;
    reg [31:0] mem[13:0];

    // Counters 
    reg signed [7:0] pc = 12;
    reg [3:0] MAX_PC = 14;
    reg [2:0] OUTPUT_REG = 3'b010;
    reg [2:0] state = 0;
    reg [31:0] cur_inst;
    reg [1:0] counter = 0;
    reg [7:0] label;
    reg [7:0] lw_address;

    // Variables for module
    reg [5:0] opcode;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [5:0] function_code;
    reg signed [7:0] immediate;

    reg [7:0] read_value_1;
    reg [7:0] read_value_2;
    reg signed [7:0] to_write;
    reg inst_valid = 0;

    reg [7:0] data;
    reg [2:0] valid_bits = 3'b000;
    wire [7:0] out1;
    wire [7:0] out2;

    reg [7:0] dram[10:0];
    reg_file REG_FILE(clk, read_reg1, read_reg2, write_reg, data, valid_bits, out1, out2);

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

    // Encoding the instructions 
    initial begin
        mem[0] = 32'b00100100000000100000000000000000;
        mem[1] = 32'b00100100000000110000000000000000;
        mem[2] = 32'b00000000011000010010000000101010;
        mem[3] = 32'b00010000100000000000000000001000;
        mem[4] = 32'b00100100000001010000000000001010;
        mem[5] = 32'b00010000011001010000000000000110;
        mem[6] = 32'b10001100011001100000000000000000;
        mem[7] = 32'b00000000010001100001000000100001;
        mem[8] = 32'b00100100011000110000000000000001;
        mem[9] = 32'b00000000011000010010000000101010;
        mem[10] = 32'b00010100100000001111111111111011;
        mem[11] = 32'b00000011111000000000000000001000;
        mem[12] = 32'b10001100000000010000000000001010;
        mem[13] = 32'b00001100000000000000000000000000;
    end

    // Setting up the value of elememts of array and value of n
    initial begin 
        dram[0] = 8'b00000001;
        dram[1] = 8'b00000010;
        dram[2] = 8'b00000010;
        dram[3] = 8'b00000001; 
        dram[4] = 8'b00000001;
        dram[5] = 8'b00000001;
        dram[6] = 8'b00000001;
        dram[7] = 8'b00000001;
        dram[8] = 8'b00000001;
        dram[9] = 8'b00000001;
        dram[10] = 8'b00001000; // n = 8
    end

    always @(posedge clk) begin
        case(state)
            0:  begin
                valid_bits = 3'b000;
                cur_inst = mem[pc];
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
                else if (opcode == 6'b000100 || opcode == 6'b000101) begin
                    valid_bits = 3'b110;
                    read_reg1 = cur_inst[25:21];
                    read_reg2 = cur_inst[20:16];
                    immediate = cur_inst[7:0];
                end
                else if (opcode != 6'b000010 && opcode != 6'b000011) begin
                    valid_bits = 3'b100;
                    read_reg1 = cur_inst[25:21];
                    write_reg = cur_inst[20:16];
                    immediate = cur_inst[7:0];
                end
                else begin
                    label = cur_inst[7:0];
                    write_reg = 6'b011111;
                end
                state = 2;
            end

            2:  begin
                if(opcode == 6'b000000 || opcode == 6'b000100 || opcode == 6'b000101) begin
                    read_value_1 = out1;
                    read_value_2 = out2;
                end
                else if (opcode != 6'b000010 && opcode != 6'b000011) begin
                    read_value_1 = out1;
                end
                else begin
                end
                state = 3;
            end

            3:  begin
                if(opcode == 6'b001001) begin
                    inst_valid = 1;
                    to_write = read_value_1 + immediate;
                    pc = pc + 1;
                end
                if(opcode == 6'b000000 && function_code == 6'b100001) begin
                    inst_valid = 1;
                    pc = pc + 1;
                    to_write = read_value_1 + read_value_2;
                end
                if(opcode == 6'b000000 && function_code == 6'b100011) begin
                    inst_valid = 1;
                    pc = pc + 1;
                    to_write = read_value_1 - read_value_2;
                end
                if (opcode == 6'b000000 && function_code == 6'b101010) begin
                    inst_valid = 1;
                    pc = pc + 1;
                    to_write = ($signed(read_value_1) < $signed(read_value_2)) ? 1 : 0;
                end
                if (opcode == 6'b000100) begin
                    valid_bits = 3'b000;
                    inst_valid = 1;
                    if (read_value_1 == read_value_2) begin
                        pc = pc + immediate;
                    end
                    else begin
                        pc = pc + 1;
                    end
                end
                if (opcode == 6'b000101) begin
                    valid_bits = 3'b000;
                    inst_valid = 1;
                    if (read_value_1 != read_value_2) begin
                        pc = pc + immediate;
                    end
                    else begin
                        pc = pc + 1;
                    end
                end
                if (opcode == 6'b000011) begin
                    inst_valid = 1;
                    to_write = pc + 1;
                    pc = label;
                end
                if (opcode == 6'b000000 && function_code == 6'b001000) begin
                    inst_valid = 1;
                    pc = read_value_1[7:0];
                end
                if (opcode == 6'b100011) begin
                    inst_valid = 1;
                    lw_address = immediate + read_value_1[7:0];
                    pc = pc + 1;
                end
                else begin
                    inst_valid = 0;
                end
                state = 4;
            end

            4: begin
                if (opcode == 6'b100011) begin
                    valid_bits = 3'b001;
                    to_write = dram[lw_address];
                end                
                state = 5;
            end

            5:  begin
                if (inst_valid != 0 && write_reg != 5'b00000) begin
                    data = to_write;
                end
                if (pc < MAX_PC) begin
                    state = 0;
                    if (write_reg != 5'b00000) begin
                        data = to_write;
                        valid_bits = 3'b001; 
                    end
                end
                else begin
                    if (counter == 0) begin
                        if (write_reg != 5'b00000) begin
                            data = to_write;
                            valid_bits = 3'b001; 
                        end
                        counter = counter + 1;
                    end
                    else if (counter == 1) begin
                        read_reg1 = OUTPUT_REG;
                        valid_bits = 3'b100;
                        state = 6;
                    end
                end
            end

            6:  begin
                $display("Value of OUTPUT_REG (reg %d): %d", read_reg1, $signed(out1));
                $finish;
            end
        endcase
    end

endmodule
