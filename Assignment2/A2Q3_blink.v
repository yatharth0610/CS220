module blink(clk, q);

    input clk;
    output reg q = 1'b0;
    reg [14:0] temp = 0;

    always @(posedge clk) begin
        if (temp == 25000) begin
            temp <= 1;
            q <= ~q;
        end
        else begin
            temp <= temp + 1;
        end
    end

endmodule