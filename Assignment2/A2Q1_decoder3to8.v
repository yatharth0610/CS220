module decoder_3to8 (x, y);
    
    // Inputs
    input [2:0] x;

    //Outputs
    output wire [7:0] y;

    // Combinational logic 
    assign y[0] = ~x[0]&&~x[1]&&~x[2]; 
    assign y[1] = x[0]&&~x[1]&&~x[2];
    assign y[2] = ~x[0]&&x[1]&&~x[2];
    assign y[3] = x[0]&&x[1]&&~x[2];
    assign y[4] = ~x[0]&&~x[1]&&x[2];
    assign y[5] = x[0]&&~x[1]&&x[2];
    assign y[6] = ~x[0]&&x[1]&&x[2];
    assign y[7] = x[0]&&x[1]&&x[2];

endmodule