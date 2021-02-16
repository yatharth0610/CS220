module eight_bit_adder_subtractor (x, y, opcode, sum, carry_out, overflow);

   // Inputs
   input [7:0] x;
   input [7:0] y;
   input opcode;

   // Outputs
   output wire [7:0] sum;
   output wire carry_out;
   output wire overflow;

   // Intermediate wire
   wire [6:0] intermediate_carry;

   // Instantiating the 8 one-adder modules
   one_bit_full_adder_subtractor FAS0 (x[0], y[0], opcode, opcode, sum[0], intermediate_carry[0]);
   one_bit_full_adder_subtractor FAS1 (x[1], y[1], intermediate_carry[0], opcode, sum[1], intermediate_carry[1]);
   one_bit_full_adder_subtractor FAS2 (x[2], y[2], intermediate_carry[1], opcode, sum[2], intermediate_carry[2]);
   one_bit_full_adder_subtractor FAS3 (x[3], y[3], intermediate_carry[2], opcode, sum[3], intermediate_carry[3]);
   one_bit_full_adder_subtractor FAS4 (x[4], y[4], intermediate_carry[3], opcode, sum[4], intermediate_carry[4]);
   one_bit_full_adder_subtractor FAS5 (x[5], y[5], intermediate_carry[4], opcode, sum[5], intermediate_carry[5]);
   one_bit_full_adder_subtractor FAS6 (x[6], y[6], intermediate_carry[5], opcode, sum[6], intermediate_carry[6]);
   one_bit_full_adder_subtractor FAS7 (x[7], y[7], intermediate_carry[6], opcode, sum[7], carry_out);

   assign overflow = intermediate_carry[6] ^ carry_out;

endmodule