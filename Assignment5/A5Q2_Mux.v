module mux_2to1 (input [2:0] a, input [2:0] b, input s, output [2:0] out);   
 
   assign out = s ? b : a;  
  
endmodule