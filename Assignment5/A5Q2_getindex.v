module get_index(a, b, c, d, index);

    // Inputs
    input [2:0] a, b, c, d;
    
    // Outputs
    output wire [1:0] index;
    
    // Intermediate wires
    wire Less1, Less2, Less3;
    wire Equal1, Equal2, Equal3;
    wire Greater1, Greater2, Greater3;
    wire [2:0] out1, out2;

    // Combinational Logic for finding max_index 
    three_bit_comparator COMPARATOR1 (a, b, 1'b0, 1'b1, 1'b0, Less1, Equal1, Greater1);
    mux_2to1 MUX1 (a, b, Greater1, out1);
    three_bit_comparator COMPARATOR2 (c, d, 1'b0, 1'b1, 1'b0, Less2, Equal2, Greater2);
    mux_2to1 MUX2 (c, d, Greater2, out2);
    three_bit_comparator COMPARATOR3 (out1, out2, 1'b0, 1'b1, 1'b0, Less3, Equal3, Greater3);
    assign index = Greater3 ? {{1'b1}, Greater2} : {{1'b0}, Greater1};

endmodule