module five_bit_fulladder (x, y, carry_in, sum, carry_out);

   // Inputs
   input [4:0] x;
   input [4:0] y;
   input carry_in;

   // Outputs
   output [4:0] sum;
   wire [4:0] sum;
   output carry_out;
   wire carry_out;

   // Intermediate wire
   wire [4:0] intermediate_carry;

   // Instantiating the 5 one-adder modules
   one_bit_full_adder FA0 (x[0], carry_in^y[0], carry_in, sum[0], intermediate_carry[0]);
   one_bit_full_adder FA1 (x[1], carry_in^y[1], intermediate_carry[0], sum[1], intermediate_carry[1]);
   one_bit_full_adder FA2 (x[2], carry_in^y[2], intermediate_carry[1], sum[2], intermediate_carry[2]);
   one_bit_full_adder FA3 (x[3], carry_in^y[3], intermediate_carry[2], sum[3], intermediate_carry[3]);
   one_bit_full_adder FA4 (x[4], carry_in^y[4], intermediate_carry[3], sum[4], carry_out);

endmodule
