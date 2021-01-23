`include "./A1Q2_one_bit_comparator.v"

module eight_bit_comparator (x, y, lin, ein, gin, less, equal, greater);

   input [7:0] x;
   input [7:0] y;
   input lin;
   input ein;
   input gin;

   output less;
   wire less;
   output equal;
   wire equal;
   output greater;
   wire greater;

   wire [6:0] intermediate_less;
   wire [6:0] intermediate_equal;
   wire [6:0] intermediate_greater;

   one_bit_comparator C7 (x[7], y[7], lin, ein, gin, intermediate_less[6], intermediate_equal[6], intermediate_greater[6]);
   one_bit_comparator C6 (x[6], y[6], intermediate_less[6], intermediate_equal[6], intermediate_greater[6], intermediate_less[5], intermediate_equal[5], intermediate_greater[5]);
   one_bit_comparator C5 (x[5], y[5], intermediate_less[5], intermediate_equal[5], intermediate_greater[5], intermediate_less[4], intermediate_equal[4], intermediate_greater[4]);
   one_bit_comparator C4 (x[4], y[4], intermediate_less[4], intermediate_equal[4], intermediate_greater[4], intermediate_less[3], intermediate_equal[3], intermediate_greater[3]);
   one_bit_comparator C3 (x[3], y[3], intermediate_less[3], intermediate_equal[3], intermediate_greater[3], intermediate_less[2], intermediate_equal[2], intermediate_greater[2]);
   one_bit_comparator C2 (x[2], y[2], intermediate_less[2], intermediate_equal[2], intermediate_greater[2], intermediate_less[1], intermediate_equal[1], intermediate_greater[1]);
   one_bit_comparator C1 (x[1], y[1], intermediate_less[1], intermediate_equal[1], intermediate_greater[1], intermediate_less[0], intermediate_equal[0], intermediate_greater[0]);
   one_bit_comparator C0 (x[0], y[0], intermediate_less[0], intermediate_equal[0], intermediate_greater[0], less, equal, greater);

endmodule
