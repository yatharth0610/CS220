module reg_file(clk, read1, read2, write, write_data, input_valid, out1, out2);

    // Inputs
    input clk;
    input [4:0] read1;
    input [4:0] read2;
    input [4:0] write;
    input [7:0] write_data;
    input [2:0] input_valid;

    // Outputs
    output reg [7:0] out1;
    output reg [7:0] out2;

    // Declaration of memory 
    reg [7:0] mem[31:0];

    // Initialising of memory
    initial begin
        mem[0] = 0;
        mem[1] = 0;
        mem[2] = 0;
        mem[3] = 0;
        mem[4] = 0;
        mem[5] = 0;
        mem[6] = 0;
        mem[7] = 0;
        mem[8] = 0;
        mem[9] = 0;
        mem[10] = 0;
        mem[11] = 0;
        mem[12] = 0;
        mem[13] = 0;
        mem[14] = 0;
        mem[15] = 0;
        mem[16] = 0;
        mem[17] = 0;
        mem[18] = 0;
        mem[19] = 0;
        mem[20] = 0;
        mem[21] = 0;
        mem[22] = 0;
        mem[23] = 0;
        mem[24] = 0;
        mem[25] = 0;
        mem[26] = 0;
        mem[27] = 0;
        mem[28] = 0;
        mem[29] = 0;
        mem[30] = 0;
        mem[31] = 0;
    end

    always @(negedge clk) begin
        if (input_valid[2] == 1) begin
            out1 = mem[read1];
        end
    end

    always @(negedge clk) begin
        if (input_valid[1] == 1) begin
            out2 = mem[read2];
        end
    end

    always @(negedge clk) begin
        if (input_valid[0] == 1) begin
            mem[write] = write_data;
        end
    end

endmodule