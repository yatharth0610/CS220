module one_bit_comparator (a, b, lin, ein, gin, less, equal, greater);

   // Inputs
   input a;
   input b;
   input lin;
   input ein;
   input gin;

   // Outputs
   output less;
   wire less;
   output equal;
   wire equal;
   output greater;
   wire greater;

   // Combinational logic
   assign less = lin|ein&~a&b;
   assign equal = ein&~(a^b);
   assign greater = gin|ein&a&~b; 

endmodule
