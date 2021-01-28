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

        //We vary Lin, Ein, Gin as well, which represent whether the comparison done till now yields whether a is less,equal or greater than b.
        // This provides for extending the 8 bit comparators into more bits. This is like varying Cin in Q1
        A = 1; B = 1; Lin = 0; Ein = 1; Gin = 0; 
        #1 
        $display("\n");
        A = 12; B = 18; Lin = 0; Ein = 1; Gin = 0;
        #1 
        $display("\n");
        A = 18; B = 15; Lin = 0; Ein = 1; Gin = 0;
        #1
        $display("\n");
        A = 0; B = 0; Lin = 0; Ein = 1; Gin = 0;
        #1
        $display("\n");
        A = 64; B = 0; Lin = 0; Ein = 0; Gin = 1;
        #1
        $display("\n");
        A = 43; B = 94; Lin = 1; Ein = 0; Gin = 0;
        #1
        $display("\n");
        A = 255; B = 65; Lin = 0; Ein = 1; Gin = 0;
        #1
        $display("\n");
        A = 255; B = 255; Lin = 0; Ein = 1; Gin = 0;
        #1
        $display("\n");
        A = 5; B = 95; Lin = 0; Ein = 0; Gin = 1;
        #1
        $display("\n");
        A = 128; B = 95; Lin = 1; Ein = 0; Gin = 0;
    end

    // Displaying the final output
    always @ (A or B or Less or Equal or Greater) begin
        $display("<%d>: Input_A = %b, Input_B = %b, Lin = %b, Ein = %b, Gin = %b, Less = %b, Equal = %b, Greater = %b",$time,A,B,Lin,Ein,Gin,Less,Equal,Greater);
    end

endmodule
