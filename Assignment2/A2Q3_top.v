module blink_top;

    reg clk;
    wire out;

    blink BLNK(clk, out);

    always @(out) begin
        $display ("<%d>: Output = %b \n", $time, out);
    end

    initial begin
        forever begin
            clk = 1;
            #5
            clk = 0;
            #5
            clk = 1;
        end
    end

    initial begin
        #3100000
        $finish;
    end 

endmodule