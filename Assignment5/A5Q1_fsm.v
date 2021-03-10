module fsm(clk, state_in, y, next);

    // Define inputs
    input clk;
    input [3:0] state_in; //Represents the state which is the input, 4 bit as 12 possible states
    input [1:0] y;

    // Define Outputs
    output [3:0] next; // For the new state;
    reg [3:0] next;

    // Define intermediate storage ROMS
    reg [2:0] mrom[12:0]; // microcode ROM
    reg [3:0] drom_S3[3:0]; // dispatch ROM for S3
    reg [3:0] drom_S10[3:0]; // dispatch ROM for S10

    // setup ROM values
    initial begin

        // Set mrom values from the next state table, there are a total of 5 different cases
        // The meanings of the RValues can be inferred from the state selection multiplexer.
        mrom[0] <= 0;
        mrom[1] <= 0;
        mrom[2] <= 0;
        mrom[3] <= 1;
        mrom[4] <= 2;
        mrom[5] <= 2;
        mrom[6] <= 0;
        mrom[7] <= 0;
        mrom[8] <= 0;
        mrom[9] <= 0;
        mrom[10] <= 3;
        mrom[11] <= 4;
        mrom[12] <= 4;

        // set DROM values from the next state function for S3 and S10
        drom_S3[0] <= 4;
        drom_S3[1] <= 5;
        drom_S3[2] <= 6;
        drom_S3[3] <= 6;

        drom_S10[0] <= 11;
        drom_S10[1] <= 12;
        drom_S10[2] <= 12;
        drom_S10[3] <= 12;

    end

    // state selection mux
    always @(posedge clk ) begin // to make the state change occur at the rising edge
        // #2 to introduce 2 units prop delay in state registers.
        case(mrom[state_in])
            0: next <= #2 state_in + 1;
            1: next <= #2 drom_S3[y];
            2: next <= #2 7;
            3: next <= #2 drom_S10[y];
            4: next <= #2 0;
        endcase
    end

endmodule