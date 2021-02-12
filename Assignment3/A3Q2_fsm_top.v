module blink_top;
    
    // Inputs 
    reg clk;
    reg xin;

    // Outputs 
    wire xout;

    // Temporary counter to store the number of clock cycles
    reg [3:0] count = 0;
    reg start = 1;

    // Instantiation of module
    fsm FSM(clk, xin, xout);

    // Initialisation and testing of module
    always @(negedge clk) begin
        if (start != 1) 
            $display ("<%d>: Output = %b \n", $time, xout);
        else 
            start = 0;
    end

    // Setup clock with period equal to ten time units and 50% duty cycle, for 10 cycles
    initial begin
        forever begin
            if (count == 10) begin 
                $finish;
            end 
            else begin
                clk = 0;
                #5
                clk = 1;
                #5
                clk = 0;
                count = count + 1;
            end 
        end
    end

    // Inputs for testing, changed 2 time units before every posedge.
    initial begin
        #3
        xin = 1;
        #10
        xin = 0;
        #10
        xin = 1;
        #10
        xin = 0;
        #10
        xin = 1;
        #10
        xin = 1;
        #10
        xin = 0;
        #10
        xin = 0;
        #10
        xin = 1;
        #10
        xin = 0;
    end

endmodule