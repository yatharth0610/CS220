module blink(clk, q);

    // Inputs
    input clk;

    // Outputs
    output reg q = 1'b0;
    
    // Temporary counter
    reg [14:0] temp = 0;

    // Logic for toggling the output
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