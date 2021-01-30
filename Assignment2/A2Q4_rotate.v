module left_rotate(clk, q);

    input clk;
    output reg [3:0] q = 4'b1000;
    reg [14:0] temp = 0;

    always @(posedge clk) begin
        if (temp == 25000) begin
            temp <= 1;
            case (q)
                4'b1000: q <= 4'b0001;
                4'b0001: q <= 4'b0010;
                4'b0010: q <= 4'b0100;
                4'b0100: q <= 4'b1000;
                default: $display("Error!");
            endcase
        end
        else begin
            temp <= temp + 1;
        end
    end

endmodule