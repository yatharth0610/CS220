module read(clk, row, input_valid, content, output_valid);

    // Inputs
    input clk;
    input [3:0] row;
    input input_valid;

    // Outputs
    output reg [31:0] content;
    output reg output_valid;

    // Declaration of memory 
    reg [31:0] mem[15:0];

    // Temp variables
    reg [3:0] open_row = 4'bxxxx;
    reg next = 0;
    reg [1:0] count_next = 0;

    // Initialising of memory
    initial begin
        mem[0] = 0;
        mem[1] = 1;
        mem[2] = 2;
        mem[3] = 3;
        mem[4] = 4;
        mem[5] = 5;
        mem[6] = 6;
        mem[7] = 7;
        mem[8] = 8;
        mem[9] = 9;
        mem[10] = 10;
        mem[11] = 11;
        mem[12] = 12;
        mem[13] = 13;
        mem[14] = 14;
        mem[15] = 15;
    end

    // Logic for giving results in next and next-to-next cycles
    always @ (posedge clk) begin
        if (next == 1) begin
            content <= mem[open_row];
            output_valid <= 1;
            next <= 0;
        end  

        if (count_next == 2) begin
            content <= mem[open_row];
            output_valid <= 1;
            count_next <= 0;
        end      
    end

    // Logic for giving the output in current cycle and setting up the output for next and next to next cycles
    always @(posedge clk) begin        
        if (count_next == 1) begin 
            count_next <= count_next + 1;
        end

        if (input_valid == 1) begin
            output_valid <= 0;
            if (open_row === 4'bxxxx) begin
                next <= 1;
                open_row <= row;
            end
            else if (row == open_row) begin
                content <= mem[row];
                output_valid <= 1;
            end
            else begin
                count_next <= 1;
                open_row <= row;
            end
        end
    end

endmodule