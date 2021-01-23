module one_bit_comparator (a, b, lin, ein, gin, less, equal, greater);

   input a;
   input b;
   input lin;
   input ein;
   input gin;

   output less;
   wire less;
   output equal;
   wire equal;
   output greater;
   wire greater;

   assign less = lin|~gin&~a&b;
   assign equal = ein&~(a^b);
   assign greater = gin|~lin&a&~b; 

endmodule
