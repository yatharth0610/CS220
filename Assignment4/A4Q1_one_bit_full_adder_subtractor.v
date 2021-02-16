module one_bit_full_adder_subtractor (a, b, cin, opcode, sum, cout);

   // Inputs
   input a;
   input b;
   input cin;
   input opcode;

   // Intermediate wires
   wire b_in;

   // Outputs
   output wire sum;
   output wire cout;

   // Combinational logic for the module
   assign b_in = b ^ opcode;
   assign sum = a ^ b_in ^ cin;
   assign cout = (a & b_in) | (b_in & cin) | (a & cin); 

endmodule
