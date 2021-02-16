module find_coordinates (clk, dir, steps, x, y);

    input clk;
    input [1:0] dir;
    input [1:0] steps;

    output reg [4:0] x;
    output reg [4:0] y;

    reg [4:0] cur_state_x = 0;
    reg [4:0] cur_state_y = 0;
    reg [4:0] provided_cord;
    reg provided_op;
    wire [4:0] new_cord;
    wire carry_out;

    five_bit_fulladder ADD(provided_cord, {{3{1'b0}}, steps[1:0]}, provided_op, new_cord, carry_out);

    always @(posedge clk) begin
        if (dir == 2'b00) begin
            provided_cord = cur_state_x;
            provided_op = 0;
        end
        else if (dir == 2'b01) begin
            provided_cord = cur_state_x;
            provided_op = 1;
        end
        else if (dir == 2'b10) begin
            provided_cord = cur_state_y;
            provided_op = 0;
        end
        else if (dir == 2'b11) begin
            provided_cord = cur_state_y;
            provided_op = 1;
        end
        else begin
            $display ("Error: Invalid Input!");
        end
    end

    always @(negedge clk) begin
        if (dir == 2'b00) begin
            x = new_cord;
            y = cur_state_y;
            cur_state_x = new_cord;
            if (new_cord[4] == 1) begin
                x = 15;
                cur_state_x = 15;
            end
        end
        else if (dir == 2'b01) begin
            x = new_cord;
            y = cur_state_y;
            cur_state_x = new_cord;
            if (new_cord[4] == 1) begin
                x = 0;
                cur_state_x = 0;
            end
        end
        else if (dir == 2'b10) begin
            x = cur_state_x;
            y = new_cord;
            cur_state_y = new_cord;
            if (new_cord[4] == 1) begin
                y = 15;
                cur_state_y = 15;
            end
        end
        else if (dir == 2'b11) begin
            x = cur_state_x;
            y = new_cord;
            cur_state_y = new_cord;
            if (new_cord[4] == 1) begin
                y = 0;
                cur_state_y = 0;
            end
        end
        else begin
            $display ("Error: Invalid Input!");
        end
    end

endmodule