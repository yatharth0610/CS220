`include "./A1Q2_eight_bit_comparator.v"

module eight_bit_comparator_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Lin;
   reg Ein;
   reg Gin;

   wire Less;
   wire Equal;
   wire Greater;

   eight_bit_comparator COMPARATOR (A, B, Lin, Ein, Gin, Less, Equal, Greater);

    initial begin
        A = 1; B = 1; Lin = 0; Ein = 1; Gin = 0;
        #1 
        A = 4; B = 2; Lin = 0; Ein = 1; Gin = 0;
        #1 
        A = 32; B = 6; Lin = 0; Ein = 1; Gin = 0;
        #1
        A = 26; B = 5; Lin = 1; Ein = 0; Gin = 0;
        #1
        A = 64; B = 64; Lin = 0; Ein = 1; Gin = 0;
        #1
        A = 43; B = 4; Lin = 1; Ein = 0; Gin = 0;
        #1
        A = 65; B = 43; Lin = 0; Ein = 1; Gin = 0;
        #1
        A = 128; B = 128; Lin = 0; Ein = 1; Gin = 0;
        #1
        A = 5; B = 95; Lin = 0; Ein = 0; Gin = 1;
        #1
        A = 128; B = 95; Lin = 0; Ein = 0; Gin = 1;
    end

    always @ (A or B or Lin or Ein or Gin) begin
        $monitor("<%d>: Input_A = %b, Input_B = %b, Input_Lin = %b, Input_Ein = %b, Input_Gin = %b, Less = %b, Equal = %b, Greater = %b",$time,A,B,Lin,Ein,Gin,Less,Equal,Greater);
    end

endmodule
