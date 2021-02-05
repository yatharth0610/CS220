module left_rotate_top;

    // Inputs 
    reg clk;

    // Outputs
    wire [3:0] out;

    // Temporary counter to store the number of clock cycles
    reg [20:0] count = 0;

    // Instantiation of module
    M rotator(clk, out);

    // Initialisation and testing of module
    always @(out) begin
        $display ("<%d>: Output = %b \n", $time, out);
    end

    initial begin
        forever begin
            if (count == 310000) begin 
                $finish;
            end
            else begin 
                clk = 1;
                #5
                clk = 0;
                #5
                clk = 1;
                count = count + 1;
            end 
        end
    end

endmodule