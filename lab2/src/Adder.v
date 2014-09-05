// UC Berkeley CS150
// Lab 2, Fall 2014
// Module: Adder.v
// Desc: Parametrized structural ripple-carry adder

module Adder #(
  parameter Width = 16
)
(
  input   [Width-1:0] A,
  input   [Width-1:0] B,
  output  [Width-1:0] Result,
  output              Cout
);

  // Wire used to connect the Cin and Cout of the FA cells
  wire [Width:0] Carry;
  // Cin of the lowest-bit FA is a 0 for addition
  assign Carry[0] = 1'b0;
  // Cout of the highest-bit FA is assigned to Cout of the adder
  assign Cout = Carry[Width];

  genvar i;
  
  /********YOUR CODE HERE********/
endmodule
