module eight_bit_comparator_top;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg Lin;
    reg Ein;
    reg Gin;

    // Outputs
    wire Less;
    wire Equal;
    wire Greater;

    // Instantion of the 8-bit comparator
    eight_bit_comparator COMPARATOR (A, B, Lin, Ein, Gin, Less, Equal, Greater);

    // Initialising the inputs
    initial begin
        Lin = 0; Ein = 1; Gin = 0; // Set Ein as 1 in inputs
        A = 1; B = 1; 
        #1 
        $display("\n");
        A = 12; B = 18; 
        #1 
        $display("\n");
        A = 18; B = 15; 
        #1
        $display("\n");
        A = 0; B = 0; 
        #1
        $display("\n");
        A = 64; B = 0;
        #1
        $display("\n");
        A = 43; B = 94;
        #1
        $display("\n");
        A = 255; B = 65;
        #1
        $display("\n");
        A = 255; B = 255;
        #1
        $display("\n");
        A = 5; B = 95;
        #1
        $display("\n");
        A = 128; B = 95;
    end

    // Displaying the final output
    always @ (A or B or Less or Equal or Greater) begin
        $display("<%d>: Input_A = %b, Input_B = %b, Less = %b, Equal = %b, Greater = %b",$time,A,B,Less,Equal,Greater);
    end

endmodule
