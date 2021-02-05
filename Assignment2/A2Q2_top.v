module priority_encoder_top;

    // Inputs
    reg [7:0] in;

    // Outputs
    wire [2:0] out;

    // Instantiation of module
    priority_encoder8to3 PENC(in, out);

    // Initialisation and testing of the circuit
    initial begin
    $monitor("<%d>: Input = %b, Output = %b \n", $time, in, out);
    end

    initial begin
        in = 8'b11100101;
        #1 
        in = 8'b11001110;
        #1 
        in = 8'b01110100;
        #1 
        in = 8'b10111000;
        #1 
        in = 8'b11010000;
        #1 
        in = 8'b01100000;
        #1 
        in = 8'b11000000;
        #1 
        in = 8'b10000000;
        #1
        in = 8'b10100001;
        #1
        in = 8'b11011000;
    end

endmodule