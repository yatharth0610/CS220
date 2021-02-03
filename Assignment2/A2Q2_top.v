module priority_encoder_top;

    reg [7:0] in;
    wire [2:0] out;
    reg clk;

    priority_encoder8to3 PENC(in, out);

    initial begin
    //clk = 0;
    //in = 1;
    $monitor("<%d>: Input = %b, Output = %b \n", $time, in, out);
    //#2150 $finish;
    end

    /*always begin
        #4
        clk = ~clk;
    end
    
    always @(posedge clk ) begin
        in <= #2 in + 1;
    end */

    initial begin
        in = 8'b00000101;
        #1 
        in = 8'b00001110;
        #1 
        in = 8'b00111000;
        #1 
        in = 8'b00110100;
        #1 
        in = 8'b01100000;
        #1 
        in = 8'b01110000;
        #1 
        in = 8'b10000000;
        #1 
        in = 8'b10100000;
        #1
        in = 8'b10100001;
        #1
        in = 8'b11011000;
    end

endmodule