module fsm_top;

    reg clk = 0;
    reg [3:0] curr_state = 0;
    wire [3:0] next_state;
    reg [3:0] count = 0;
    reg [1:0] y;

    fsm FSM(clk, curr_state, y, next_state);
    
    always @(posedge clk ) begin
        $display("<%d>: Current State = %d",$time,curr_state);
    end

    always @(negedge clk ) begin
        curr_state <= next_state;
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

    initial begin
        #3
        y = 1;
        #10
        y = 2;
        #10
        y = 3;
        #10
        y = 2;
        #10
        y = 3;
        #10
        y = 2;
        #10
        y = 1;
        #10
        y = 0;
        #10
        y = 1;
        #10
        y = 3;
    end
endmodule