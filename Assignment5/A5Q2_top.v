module findmax_top;

    // Inputs
    reg [2:0] A;
    reg [2:0] B;
    reg [2:0] C;
    reg [2:0] D;
    
    // Outputs
    wire [1:0] index;

    // Instantion of the get index module
    get_index INDEX(A, B, C, D, index);

    // Initialising the inputs
    initial begin
        A = 1; B = 2; C = 3; D = 4; 
        #1 
        $display("\n");
        A = 2; B = 7; C = 5; D = 3;
        #1 
        $display("\n");
        A = 7; B = 0; C = 5; D = 3;
        #1 
        $display("\n");
        A = 2; B = 1; C = 6; D = 3;
        #1 
        $display("\n");
        A = 7; B = 7; C = 5; D = 3;
        #1 
        $display("\n");
        A = 2; B = 7; C = 7; D = 3;
        #1 
        $display("\n");
        A = 1; B = 6; C = 5; D = 6;
        #1 
        $display("\n");
        A = 6; B = 6; C = 5; D = 5;
        #1 
        $display("\n");
        A = 7; B = 7; C = 7; D = 3;
        #1 
        $display("\n");
        A = 7; B = 7; C = 7; D = 7;
        #1 
        $display("\n");
    end

    // Displaying the final output
    always @ (A or B or C or D or index) begin
        $display("<%d>: A = %b, B = %b, C = %b, D = %b, index = %b",$time,A,B,C,D,index);
    end

endmodule
