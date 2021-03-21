module reg_file(clk, read1, read2, write, write_data, input_valid, out1, out2, output_valid);

    // Inputs
    input clk;
    input [4:0] read1;
    input [4:0] read2;
    input [4:0] write;
    input [15:0] write_data;
    input [2:0] input_valid;

    // Outputs
    output reg signed [15:0] out1;
    output reg signed [15:0] out2;
    output wire output_valid;

    // Declaration of memory 
    reg [15:0] mem[31:0];
    reg [1:0] count1 = 0;
    reg [1:0] count2 = 0;
    reg [1:0] count3 = 0;
    reg done1 = 0;
    reg done2 = 0;
    reg done3 = 0;

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

    always @(read1 or read2 or write or write_data or input_valid) begin
        done1 = 0;
        done2 = 0;
        done3 = 0;
    end

    always @(posedge clk) begin
        if (input_valid[2] == 1) begin
            if (count1 == 1) begin
                out1 = mem[read1];
                done1 = 1;
                count1 = 0; 
            end
            else begin
                count1 = count1 + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (input_valid[1] == 1) begin
            if (count2 == 1) begin
                out2 = mem[read2];
                done2 = 1;
                count2 = 0; 
            end
            else begin
                count2 = count2 + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (input_valid[0] == 1) begin
            if (count3 == 1) begin
                mem[write] = write_data;
                done3 = 1;
                count3 = 0; 
            end
            else begin
                count3 = count3 + 1;
            end
        end
    end

    assign output_valid = done1 || done2 || done3;

endmodule