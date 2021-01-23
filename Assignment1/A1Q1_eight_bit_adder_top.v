module eight_bit_adder_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (A, B, Cin, Sum, Carry);

    initial begin
        A = 1; B = 1; Cin = 0;
        #1 
        A = 4; B = 2; Cin = 1;
        #1 
        A = 32; B = 6; Cin = 1;
        #1
        A = 26; B = 5; Cin = 1;
        #1
        A = 64; B = 64; Cin = 0;
        #1
        A = 43; B = 4; Cin = 0;
        #1
        A = 65; B = 43; Cin = 0;
        #1
        A = 128; B = 128; Cin = 1;
        #1
        A = 5; B = 95; Cin = 0;
        #1
        A = 128; B = 95; Cin = 0;
    end

    always @ (A or B or Cin) begin
        $monitor("<%d>: Input_A = %b, Input_B = %b, Input_Cin = %b, Sum = %b, Carry = %b",$time,A,B,Cin,Sum,Carry);
    end

endmodule