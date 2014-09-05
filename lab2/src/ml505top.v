// UC Berkeley CS150
// Lab 2, Fall 2014

module ml505top (
  input  [4:0]  GPIO_COMPSW,
  output [7:0]  GPIO_LED,
  input         CLK_33MHZ_FPGA
);

  parameter Width   = 8;
  localparam CWidth = Width*2;
  
  wire                Clock;
  wire                Reset;
  reg [CWidth-1:0]    Count;

  wire [Width-1:0]    CUTResult;
  wire [Width-1:0]    ExpectedResult;
  wire                CUTCout;
  wire                ExpectedCout;

  //--------------------------------------------------------------------------
  // Clock Buffer
  //   In order to get a clean, glitch free clock signal all over the FPGA,
  //   we use this special clock buffer module.  It does not change the
  //   signal functionally, it only affects timing.
  //--------------------------------------------------------------------------
  BUFG ClockBuf(
    .I(CLK_33MHZ_FPGA), 
    .O(Clock));

  assign Reset = GPIO_COMPSW[4] | GPIO_COMPSW[3] |
    GPIO_COMPSW[2] | GPIO_COMPSW[1] | GPIO_COMPSW[0];
 
  // Circuit Under Test
  Adder #(.Width(Width)) CUT (
    .A(Count[CWidth-1:Width]),
    .B(Count[Width-1:0]),
    .Result(CUTResult),
    .Cout(CUTCout)
    );
  
  BehavioralAdder #(.Width(Width)) Solution (
    .A(Count[CWidth-1:Width]),
    .B(Count[Width-1:0]),
    .Result(ExpectedResult),
    .Cout(ExpectedCout)
    );

  always @(posedge Clock) begin
    if(Reset) Count <= {CWidth{1'b0}};
    else if ((Count != {CWidth{1'b1}}) && GPIO_LED[0]) Count <= Count + 1'b1;
  end

  assign GPIO_LED[0] = CUTResult == ExpectedResult && CUTCout == ExpectedCout;
  assign GPIO_LED[1] = ~GPIO_LED[0];

  /* The unsed LEDs are simply left turned off. Feel free to implement your 
   * your own logic! */
  assign GPIO_LED[7:2] = 6'b0;

endmodule
