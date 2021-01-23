module eight_bit_adder_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (A, B, Cin, Sum, Carry);

    always @ (A or B or Cin or Sum or Carry) begin
        $display("<%d>: Input_A = %b, Input_B = %b, Input_Cin = %b, Sum = %b, Carry = %b",$time,A,B,Cin,Sum,Carry);
    end

    initial begin
        A = 1; B = 1; Cin = 0;
        #1 
        $display("\n");
        A = 200; B = 200; Cin = 1;
        #1 
        $display("\n");
        A = 32; B = 6; Cin = 1;
        #1
        $display("\n");
        A = 26; B = 5; Cin = 1;
        #1
        $display("\n");
        A = 64; B = 64; Cin = 0;
        #1
        $display("\n");
        A = 43; B = 4; Cin = 0;
        #1
        $display("\n");
        A = 65; B = 43; Cin = 0;
        #1
        $display("\n");
        A = 128; B = 128; Cin = 1;
        #1
        $display("\n");
        A = 5; B = 220; Cin = 0;
        #1
        $display("\n");
        A = 128; B = 96; Cin = 0;
    end

endmodule