// UC Berkeley CS150
// Lab 3, Fall 2014
// Module: ALUdecoder
// Desc:   Sets the ALU operation
// Inputs: opcode: the top 6 bits of the instruction
//         funct: the funct, in the case of r-type instructions
//         add_rshift_type: selects whether an ADD vs SUB, or an SRA vs SRL
// Outputs: ALUop: Selects the ALU`s operation
//

`include "Opcode.vh"
`include "ALUop.vh"

module ALUdec(
  input [6:0]       opcode,
  input [2:0]       funct,
  input             add_rshift_type,
  output reg [3:0]  ALUop
);

  always@(*) begin
	  
	  case(opcode)
		`OPC_LUI: ALUop = `ALU_COPY_B;
		`OPC_AUIPC,`OPC_JAL,`OPC_JALR: ALUop = `ALU_ADD;
		`OPC_BRANCH: begin
			case(funct)
				`FNC_BEQ,`FNC_BNE,`FNC_BLT,`FNC_BGE,`FNC_BLTU,`FNC_BGEU:
					ALUop = `ALU_ADD;
				default:
					ALUop = `ALU_ADD;
			endcase
		end
		`OPC_STORE,`OPC_LOAD: begin
			case(funct)
		`FNC_LB,`FNC_LH,`FNC_LW,`FNC_LD,`FNC_LBU,`FNC_LHU,`FNC_LWU:
					ALUop = `ALU_ADD;
		`FNC_SB,`FNC_SH,`FNC_SW:
					ALUop = `ALU_ADD;
				default:
					ALUop = `ALU_ADD;
			endcase 
		end
	  	`OPC_ARI_RTYPE,`OPC_ARI_ITYPE: begin
		  case(funct)
			3'b000: if(add_rshift_type) 
						ALUop = `ALU_SUB;
 					else
						ALUop = `ALU_ADD;
			3'b001: ALUop = `ALU_SLL;
			3'b010: ALUop = `ALU_SLT;
			3'b011: ALUop = `ALU_SLTU;
			3'b100: ALUop = `ALU_XOR;
			3'b101: if(add_rshift_type)
						 ALUop = `ALU_SRA;
 					else ALUop = `ALU_SRL;
			3'b110: ALUop = `ALU_OR;
			3'b111: ALUop = `ALU_AND;
			default: ALUop = `ALU_XXX; 
		  endcase
		end
		default: ALUop = `ALU_XXX; //default for opcode case 
	  endcase
  end
endmodule
