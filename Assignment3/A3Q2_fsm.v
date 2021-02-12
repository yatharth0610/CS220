module fsm(clk, xin, xout);

    // Inputs
    input clk;
    input xin;

    // Output
    output wire xout;

    // Intermediate storage (pre initialized)
    reg a = 0;
    reg b = 0;
    reg c = 0;

    // Connect output wire to intermediate registers (combinational logic)
    assign xout = ~a | b | ~c;
    
    // Dequential logic to update intermediate states at the posedge
    always @(posedge clk) begin
        a <= (~xin & (c | a)) | (a & (b | c)) | (b & xin);
        b <= (a & b) | (~a & ~b & xin) | (a & ~c & xin);
        c <= ~c | a | (b & xin) | (~b & c & ~xin);
    end

endmodule