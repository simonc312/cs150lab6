//-----------------------------------------------------------------------------
// UC Berkeley CS150
// Lab 0, Spring 2012
// Module: FA.v
// Desc: Full Adder. See http://en.wikipedia.org/wiki/Full_adder#Full_adder 
//       if you are not familiar with the circuit.
//
//       You may only use structural verilog in this module.       
//-----------------------------------------------------------------------------
module FA(
    input A, B, Cin,
    output Sum, Cout
);

    /********YOUR CODE HERE********/

    wire ab_xor;
    wire bc_and;
    wire ab_and;

    xor (ab_xor, A, B);
    xor (Sum, Cin, ab_xor);
    and  (bc_and, ab_xor, Cin);
    and  (ab_and, A, B);
    or(Cout, ab_and, bc_and);

endmodule

