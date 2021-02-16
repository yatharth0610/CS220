module one_bit_full_adder (a, b, cin, sum, cout);

   // Inputs
   input a;
   input b;
   input cin;

   // Outputs
   output sum;
   wire sum;
   output cout;
   wire cout;

   // Combinational logic for the module
   assign sum = a^b^cin;
   assign cout = (a&b)|(b&cin)|(a&cin); 

endmodule
