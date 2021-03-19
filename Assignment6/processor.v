module processor(clk, input_valid, op, read1, read2, write, write_data, read_data_1, read_data_2, done);

    // Inputs
    input clk;
    input input_valid;
    input [2:0] op;
    input [4:0] read1;
    input [4:0] read2;
    input [4:0] write;
    input [15:0] write_data;

    // Outputs
    output reg [15:0] read_data_1;
    output reg [15:0] read_data_2;
    output reg done = 0;

    // Variables for module
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [15:0] data;
    reg [2:0] valid_bits;
    wire [15:0] out1;
    wire [15:0] out2;
    wire output_valid;

    // Instantiation of reg_file module
    reg_file mem(clk, read_reg1, read_reg2, write_reg, data, valid_bits, out1, out2, output_valid);

    always @(negedge clk) begin
        if (output_valid == 1) begin
            done = 1;
            valid_bits = 3'b000;
            if (op == 3'b000) begin
            end
            else if (op == 3'b001) begin
                read_data_1 = out1;
            end 
            else if (op == 3'b010) begin
                read_data_1 = out1;
                read_data_2 = out2;
            end 
            else if (op == 3'b011) begin
                read_data_1 = out1;
            end 
            else if (op == 3'b100) begin
                read_data_1 = out1;
                read_data_2 = out2;
            end  
        end
    end

    always @(posedge clk) begin 
        if (input_valid == 1) begin
            done = 0;
            if (op == 3'b000) begin
                valid_bits = 3'b001;
                write_reg = write;
                data = write_data;
            end
            else if (op == 3'b001) begin
                valid_bits = 3'b100;
                read_reg1 = read1;
            end 
            else if (op == 3'b010) begin
                valid_bits = 3'b110;
                read_reg1 = read1;
                read_reg2 = read2;
            end 
            else if (op == 3'b011) begin
                valid_bits = 3'b101;
                read_reg1 = read1;
                write_reg = write;
                data = write_data;
            end 
            else if (op == 3'b100) begin
                valid_bits = 3'b111;
                read_reg1 = read1;
                read_reg2 = read2;
                write_reg = write;
                data = write_data;
            end  
        end
    end

endmodule