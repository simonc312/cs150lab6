//  Module: ALUTestbench
//  Desc:   32-bit ALU testbench for the MIPS150 Processor
//  Feel free to edit this testbench to add additional functionality
//  
//  Note that this testbench only tests correct operation of the ALU,
//  it doesn't check that you're mux-ing the correct values into the inputs
//  of the ALU. 

// If #1 is in the initial block of your testbench, time advances by
// 1ns rather than 1ps
`timescale 1ns / 1ps

`include "Opcode.vh"

module ALUTestbench();

    parameter Halfcycle = 5; //half period is 5ns
    
    localparam Cycle = 2*Halfcycle;
    
    reg Clock;
    
    // Clock Signal generation:
    initial Clock = 0; 
    always #(Halfcycle) Clock = ~Clock;
    
    // Register and wires to test the ALU
    reg [2:0] funct;
    reg add_rshift_type;
    reg [6:0] opcode;
    reg [31:0] A, B;
    wire [31:0] DUTout;
    reg [31:0] REFout; 
    wire [3:0] ALUop;

    reg [30:0] rand_31;
    reg [14:0] rand_15;

    // Signed operations; these are useful
    // for signed operations
    wire signed [31:0] B_signed;
    assign B_signed = $signed(B);

	wire signed [31:0] A_signed;
    assign A_signed = $signed(A);

    wire signed_comp, unsigned_comp;
    assign signed_comp = ($signed(A) < $signed(B));
    assign unsigned_comp = A < B;

    // Task for checking output
    task checkOutput;
        input [6:0] opcode;
        input [2:0] funct;
        input add_rshift_type;
        if ( REFout !== DUTout ) begin
            $display("FAIL: Incorrect result for opcode %b, funct: %b:, add_rshift_type: %b", opcode, funct, add_rshift_type);
            $display("\tA: 0x%h, B: 0x%h, DUTout: 0x%h, REFout: 0x%h", A, B, DUTout, REFout);
            $finish();
        end
        else begin
            $display("PASS: opcode %b, funct %b, add_rshift_type %b", opcode, funct, add_rshift_type);
            $display("\tA: 0x%h, B: 0x%h, DUTout: 0x%h, REFout: 0x%h", A, B, DUTout, REFout);
        end
    endtask

    //This is where the modules being tested are instantiated. 
    ALUdec DUT1(
        .opcode(opcode),
        .funct(funct),
        .add_rshift_type(add_rshift_type),
        .ALUop(ALUop));

    ALU DUT2( .A(A),
        .B(B),
        .ALUop(ALUop),
        .Out(DUTout));

    integer i;
    localparam loops = 25; // number of times to run the tests for

    // Testing logic:
    initial begin
        for(i = 0; i < loops; i = i + 1)
        begin
            /////////////////////////////////////////////
            // Put your random tests inside of this loop
            // and hard-coded tests outside of the loop
            // (see comment below)
            // //////////////////////////////////////////
            #1;
            // Make both A and B negative to check signed operations
            rand_31 = {$random} & 31'h7FFFFFFF;
            rand_15 = {$random} & 15'h7FFF;
            A = {1'b1, rand_31};
            // Hard-wire 16 1's in front of B for sign extension
            B = {16'hFFFF, 1'b1, rand_15};
            // Set funct random to test that it doesn't affect non-R-type insts

            // Tests for the non R-Type and I-Type instructions.
            // Add your own tests for R-Type and I-Type instructions
            opcode = `OPC_LUI;
            // Set funct random to verify that the value doesn't matter
            funct = $random & 3'b111;
            add_rshift_type = $random & 1'b1;
            REFout = B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

            opcode = `OPC_AUIPC;
            funct = $random & 3'b111;
            add_rshift_type = $random & 1'b1;
            REFout = A + B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

            opcode = `OPC_BRANCH;
            funct = $random & 3'b111;
            add_rshift_type = $random & 1'b1;
            REFout = A + B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

            opcode = `OPC_LOAD;
            funct = $random & 3'b111;
            add_rshift_type = $random & 1'b1;
            REFout = A + B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

            opcode = `OPC_STORE;
            funct = $random & 3'b111;
            add_rshift_type = $random & 1'b1;
            REFout = A + B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b000;
            add_rshift_type = 1'b0;
            REFout = A + B;
            #1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b000;
            add_rshift_type = 1'b1;
            REFout = A - B;
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b001;
            add_rshift_type = 1'b0;
            REFout = A << B[4:0]; //SLL
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b010;
            add_rshift_type = 1'b0;
            REFout = signed_comp; //SLT
			#1;
            checkOutput(opcode, funct, add_rshift_type);
		
			opcode = `OPC_ARI_RTYPE;
            funct = 3'b011;
            add_rshift_type = 1'b0;
            REFout = unsigned_comp; //SLTU
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b100;
            add_rshift_type = 1'b0;
            REFout = A^B; //XOR
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b101;
            add_rshift_type = 1'b0;
            REFout = A>>B[4:0]; //SRL
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b101;
            add_rshift_type = 1'b1;
            REFout = A_signed>>>B[4:0]; //SRA
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b110;
            add_rshift_type = 1'b0;
            REFout = A|B; //OR
			#1;
            checkOutput(opcode, funct, add_rshift_type);

			opcode = `OPC_ARI_RTYPE;
            funct = 3'b111;
            add_rshift_type = 1'b0;
            REFout = A&B; //AND
			#1;
            checkOutput(opcode, funct, add_rshift_type);
        end
        ///////////////////////////////
        // Hard coded tests go here
        ///////////////////////////////

		opcode = `OPC_ARI_RTYPE;
            funct = 3'b000;
            add_rshift_type = 1'b0;
			A = 32'hfd504144; B = 32'h5bfeca86;
            REFout = 32'h594f0bca; //AND OVERFLOW
			#1;
            checkOutput(opcode, funct, add_rshift_type);

		opcode = `OPC_LOAD;
            funct = 3'b011;
            add_rshift_type = 1'b0;
			A = 32'hfd504144; B = 32'h5bfeca86;
            REFout = 32'h594f0bca; //LOAD OVERFLOW
			#1;
            checkOutput(opcode, funct, add_rshift_type);

		opcode = `OPC_JAL;
			funct = 3'b001;
            add_rshift_type = 1'b0;
			A = 32'h0a79c3ab; B = 32'h7279a88c;
            REFout = 32'h7cf36c37; //JAL
			#1;
            checkOutput(opcode, funct, add_rshift_type);

        $display("\n\nALL TESTS PASSED!");
        $finish();
    end

  endmodule
