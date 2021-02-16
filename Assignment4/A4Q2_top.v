module find_coordinates_top;
    
    reg [1:0] dir;
    reg [1:0] steps;
    reg clk;

    wire [4:0] x_coord;
    wire [4:0] y_coord;

    reg [3:0] count = 0;

    find_coordinates FIND(clk, dir, steps, x_coord, y_coord);

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
        dir = 0;
        steps = 2;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 1;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 2;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
        #10
        $display ("<%d>: Current Coordinates = (%d, %d ), Prev_Input = (%d, %d)", $time, x_coord, y_coord, dir, steps);
        dir = 0;
        steps = 3;
    end

endmodule