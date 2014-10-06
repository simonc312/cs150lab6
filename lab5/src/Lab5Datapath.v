//-----------------------------------------------------------------------------
// Lab5Datapath
// CS 150 Spring 2013
// Description:
//     Datapath for a linked-list accumulator. The list begins at address 0 of 
//     the block ram. Each list element contains a data field and a pointer to
//     the next element, stored in sequential addresses.
//-----------------------------------------------------------------------------
 
module Lab5Datapath(
    input clk, rst,
    input addr_sel, wr_en,
    input [3:0] alu_op,
    output ram_zero,
    output [31:0] accum_result
);


    // Block memory instantiation. The module definition is in 
    // blk_ram/blk_mem_gen_v4_3.v (after you run build in the blk_ram
    // directory).
    blk_mem_gen_v4_3 blk_mem(
	    .clka(      ),
	    .addra(     ),
	    .douta(     )
    );


endmodule
