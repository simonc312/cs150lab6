// UC Berkeley CS150
// Lab 4, Fall 2014

module ml505top (
    input  [5:0] GPIO_DIP,
    input        GPIO_COMPSW_C,
    input        CLK_33MHZ_FPGA,
    output [7:0] GPIO_LED,
    output [4:0] GPIO_COMPLED
);

    // Clock and reset:
    wire clk;
	BUFG clock_buf(.I(CLK_33MHZ_FPGA), .O(clk));

    // Use the center compass switch to reset/trigger chipscope:
    wire rst;
    Debouncer rst_parse(
        .clk(clk),
        .in(GPIO_COMPSW_C),
        .out(rst));

    // Datapath control signals:
    wire        addr_sel;
    wire        wr_en;
    wire [3:0]  alu_op;

    // Datapath output signals:
    wire        ram_zero;
    wire [31:0] accum_result;
    

    Lab4Datapath datapath(
        .clk(clk),
        .rst(rst),
        .addr_sel(addr_sel),
        .wr_en(wr_en),
        .alu_op(alu_op),
        .ram_zero(ram_zero),
        .accum_result(accum_result)
    );

    Lab4Control controller(
        .clk(clk),
        .rst(rst),
        .ram_zero(ram_zero),
        .funct(GPIO_DIP[2:0]),
        .add_rshift_type(GPIO_DIP[3]),
        .alu_op(alu_op),
        .addr_sel(addr_sel),
        .wr_en(wr_en),
        .done(GPIO_COMPLED[0])
    );

    // LED output assignments:
    assign GPIO_LED = accum_result[7:0]; 
    assign GPIO_COMPLED[4:1] = 4'b0;

endmodule
