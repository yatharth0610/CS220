module read_top;
 
    // Inputs
    reg clk;
    reg [3:0] row;
    reg input_valid;
    
    // Outputs
    wire [31:0] content;
    wire output_valid;

    // Temporary counter to store the number of clock cycles
    reg [4:0] count1 = 0;
    reg [2:0] count2 = 0;
    reg start = 1;
    reg [2:0] done_times = 0; 

    // Instantiation of module
    read DRAM(clk, row, input_valid, content, output_valid);

    // Setting up clk signal
    initial begin
        forever begin
            if (count1 == 30) begin 
                $finish;
            end
            else begin 
                clk = 0;
                #5
                clk = 1;
                #5
                clk = 0;
                count1 = count1 + 1;
            end 
        end
    end

    // Initialising the inputs and testing
    initial begin
        forever begin
                #3
                input_valid = 0;
                if (start == 1) begin
                    input_valid = 1;
                    row = 2;
                    start = 0;
                end
                else if (count2 == 3 && done_times != 5) begin
                    input_valid = 1;
                    row = 9;
                    count2 = 0;
                    done_times = done_times + 1;
                end
                else if (count2 == 3) begin 
                    input_valid = 1;
                    row = 15;
                    count2 = 0;
                end
                count2 = count2 + 1;
                #7
                input_valid = 0;
        end
    end 

    always @ (posedge output_valid) begin
        $display ("<%d>: row = %b, content = %b \n", $time, row, content);
    end

endmodule