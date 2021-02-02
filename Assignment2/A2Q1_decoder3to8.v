module decoder_3to8 (x, y);

    input [2:0] x;
    output wire [7:0] y;

    assign y[0] = ~x[0]&&~x[1]&&~x[2]; 
    assign y[1] = x[0]&&~x[1]&&~x[2];
    assign y[2] = ~x[0]&&x[1]&&~x[2];
    assign y[3] = x[0]&&x[1]&&~x[2];
    assign y[4] = ~x[0]&&~x[1]&&x[2];
    assign y[5] = x[0]&&~x[1]&&x[2];
    assign y[6] = ~x[0]&&x[1]&&x[2];
    assign y[7] = x[0]&&x[1]&&x[2];

    /*always @(x) begin

        case(x)

            3'b000: y = 8'b00000001;
            3'b001: y = 8'b00000010;
            3'b010: y = 8'b00000100;
            3'b011: y = 8'b00001000;
            3'b100: y = 8'b00010000;
            3'b101: y = 8'b00100000;
            3'b110: y = 8'b01000000;
            3'b111: y = 8'b10000000;
            default: $display("Invalid Signal");

        endcase
    end*/
endmodule