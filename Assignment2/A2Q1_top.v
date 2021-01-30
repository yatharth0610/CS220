module encoder_decoder_top;

    reg [2:0] A;
    wire [2:0] B;
    wire [7:0] intermediate_wire;

    decoder_3to8 DEC(A, intermediate_wire);
    encoder_8to3 ENC(intermediate_wire, B);

    initial begin
    $monitor("<%d>: Input = %b, Output = %b \n", $time, A, B);
    end

    initial begin
        A = 3'b000;
        #1 
        A = 3'b001;
        #1 
        A = 3'b010;
        #1 
        A = 3'b011;
        #1 
        A = 3'b100;
        #1 
        A = 3'b101;
        #1 
        A = 3'b110;
        #1 
        A = 3'b111;
    end

endmodule