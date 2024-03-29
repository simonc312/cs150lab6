module UATransmit(
  input   Clock,
  input   Reset,

  input   [7:0] DataIn,
  input         DataInValid,
  output   reg  DataInReady,

  output        SOut
);
  // for log2 function
  `include "util.vh"

  //--|Parameters|--------------------------------------------------------------

  parameter   ClockFreq         =   100_000_000;
  parameter   BaudRate          =   115_200;

  // See diagram in the lab guide
  localparam  SymbolEdgeTime    =   ClockFreq / BaudRate;
  localparam  ClockCounterWidth =   log2(SymbolEdgeTime);

  //--|Solution|----------------------------------------------------------------

 
  reg     [ClockCounterWidth-1:0] ClockCounter;
  reg     [3:0]                   BitCounter;
  reg     [9:0]                   TXShift;
  wire                            SymbolEdge;
  wire                            TXRunning;
 
  assign  SymbolEdge   = (ClockCounter == SymbolEdgeTime - 1);
  assign  Start =  (DataInValid && DataInReady);
  assign  TXRunning     = BitCounter != 4'd10;
 
  assign SOut = (TXShift[0]);
 
   
  always @ (posedge Clock) begin
    ClockCounter <= (Start || Reset || SymbolEdge) ? 0 : ClockCounter + 1;
  end
 
  always @ (posedge Clock) begin
    if (Reset) BitCounter <= 0;      
    else if (Start) begin
      BitCounter <= 0;
      TXShift <= { 1'b1, DataIn, 1'b0 };
    end else if (SymbolEdge && TXRunning) begin
      BitCounter <= BitCounter + 1;
      TXShift <= { 1'b1, TXShift[9:1] }; //shift in 1's because we need stop bit (>> wont work)
    end
  end
 
  always @ (posedge Clock) begin
    if (Reset) DataInReady <= 1'b1;
    else if (TXRunning) DataInReady <= 1'b0;
    else if ((~(TXRunning)) && SymbolEdge) DataInReady <= 1'b1;
  end
 endmodule
