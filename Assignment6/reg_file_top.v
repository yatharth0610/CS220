module top;
 
    // Inputs
    reg clk;
    reg input_valid;
    reg [2:0] op;
    reg [4:0] read1;
    reg [4:0] read2;
    reg [4:0] write;
    reg signed [15:0] write_data;
    
    // Outputs
    wire signed [15:0] read_data_1;
    wire signed [15:0] read_data_2;
    wire signed [15:0] arith_out;
    wire done;

    // Array to store instructions
    reg [33:0] inst[8:0];
    reg [4:0] counter = 0;

    // Instantiation of module
    processor P(clk, input_valid, op, read1, read2, write, write_data, read_data_1, read_data_2, arith_out, done);

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
        inst[0] = 34'b0000000000000000010000000000010001;
        inst[1] = 34'b0110000100000000101111111111110111;
        inst[2] = 34'b1000000100010000110000000001000001;
        inst[3] = 34'b0100001000011000000000000000000000;
        inst[4] = 34'b1110001100011001010000000000000000;
        inst[5] = 34'b1010000100010001000000000000000000;
        inst[6] = 34'b1110010001001001000000000000000000;
        inst[7] = 34'b1100010100100001100000000000000000;
        inst[8] = 34'b0010011000000000000000000000000000;
        #5
        op = 3'b000;
        input_valid = 1;
        write = 5'b00001;
        write_data = 16'b0000000000010001;
    end

    always @(posedge done) begin
        if (inst[counter][33:31] == 3'b000) begin
        end
        else if (inst[counter][33:31] == 3'b001) begin
            read1 = inst[counter][30:26];
            $display ("<%d>: Instruction: %b, Read register : %d, Read Data: %d", $time, inst[counter][33:31], read1, read_data_1);
        end 
        else if (inst[counter][33:31] == 3'b010) begin
            read1 = inst[counter][30:26];
            read2 = inst[counter][25:21];
            $display ("<%d>: Instruction: %b, Read register 1: %d, Read Register 2: %d, Read Data 1: %d, Read Data 2: %d", $time, inst[counter][33:31], read1, read2, read_data_1, read_data_2);
        end 
        else if (inst[counter][33:31] == 3'b011) begin
            read1 = inst[counter][30:26];
            $display ("<%d>: Instruction: %b, Read register : %d, Read Data: %d", $time, inst[counter][33:31], read1, read_data_1);
        end 
        else if (inst[counter][33:31] == 3'b100) begin
            read1 = inst[counter][30:26];
            read2 = inst[counter][25:21];
            $display ("<%d>: Instruction: %b, Read register 1: %d, Read Register 2: %d, Read Data 1: %d, Read Data 2: %d", $time, inst[counter][33:31], read1, read2, read_data_1, read_data_2);
        end
        else if (inst[counter][33:31] == 3'b101) begin
            read1 = inst[counter][30:26];
            read2 = inst[counter][25:21];
            $display ("<%d>: Instruction: %b, Write Register: %d, Value written: %d", $time, inst[counter][33:31], write, arith_out);
        end
        else if (inst[counter][33:31] == 3'b110) begin
            read1 = inst[counter][30:26];
            read2 = inst[counter][25:21];
            $display ("<%d>: Instruction: %b, Write Register: %d, Value written: %d", $time, inst[counter][33:31], write, arith_out);
        end
        else if (inst[counter][33:31] == 3'b111) begin
            read1 = inst[counter][30:26];
            $display ("<%d>: Instruction: %b, Write Register: %d, Value written: %d", $time, inst[counter][33:31], write, arith_out);
        end
        counter = counter + 1;
        if (counter == 9) begin 
            $finish;
        end
        else begin
            input_valid = 1;
            if (inst[counter][33:31] == 3'b000) begin
                op = 3'b000;
                write = inst[counter][20:16];
                write_data =  inst[counter][15:0];
            end
            else if (inst[counter][33:31] == 3'b001) begin
                op = 3'b001;
                read1 = inst[counter][30:26];
            end 
            else if (inst[counter][33:31] == 3'b010) begin
                op = 3'b010;
                read1 = inst[counter][30:26];
                read2 = inst[counter][25:21];
            end 
            else if (inst[counter][33:31] == 3'b011) begin
                op = 3'b011;
                read1 = inst[counter][30:26];
                write = inst[counter][20:16];
                write_data =  inst[counter][15:0];
            end 
            else if (inst[counter][33:31] == 3'b100) begin
                op = 3'b100;
                read1 = inst[counter][30:26];
                read2 = inst[counter][25:21];
                write = inst[counter][20:16];
                write_data =  inst[counter][15:0];
            end  
            else if (inst[counter][33:31] == 3'b101) begin
                op = 3'b101;
                read1 = inst[counter][30:26];
                read2 = inst[counter][25:21];
                write = inst[counter][20:16];
            end
            else if (inst[counter][33:31] == 3'b110) begin
                op = 3'b110;
                read1 = inst[counter][30:26];
                read2 = inst[counter][25:21];
                write = inst[counter][20:16];
            end
            else if (inst[counter][33:31] == 3'b111) begin
                op = 3'b111;
                read1 = inst[counter][30:26];
                read2 = inst[counter][25:21];
                write = inst[counter][20:16];
            end
        end
    end

    always @(negedge done) begin
         input_valid = 0;
    end

endmodule