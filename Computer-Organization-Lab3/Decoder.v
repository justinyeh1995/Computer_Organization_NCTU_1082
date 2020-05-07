/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input  [32-1:0] instr_i,
	output 		ALUSrc,
	output 		RegWrite,
	output 		Branch,
	output [2-1:0]	ALUOp
	);
	
/* Write your code HERE */
reg            alusrc;
reg            regwrite;
reg            branch;
reg    [2-1:0] ALU_OP;

always@ * 
	begin
	case(instr_i[7-1:0]) 
		/* R-format */
		7'b0110011:
			begin
				alusrc <= 0; regwrite <= 1; branch <= 0; ALU_OP <= 2'b10;
			end
		/* I-type Load */
		7'b0000011:
			begin
				alusrc <= 1; regwrite <= 1; branch <= 0; ALU_OP <= 2'b00;
			end
		/* S-type */
		7'b0100011:
			begin
				alusrc <= 1; regwrite <= 0; branch <= 0; ALU_OP <= 2'b00;
			end
		/* SB-type */
		7'b1100011:
			begin
				alusrc <= 0; regwrite <= 0; branch <= 1; ALU_OP <= 2'b01;
			end
		/* I-type immediate */
		7'b0010011:
			begin
				alusrc <= 1; regwrite <= 1; branch <= 0; ALU_OP <= 2'b00;
			end
	endcase
//$display("%0dns :\$display: Opcode = %7b ALUSrc=%b RegWrite=%b Branch =%b ALUOp =%2b"  , $stime, instr_i[7-1:0], alusrc, regwrite, branch, ALU_OP);

end

assign ALUSrc = alusrc;
assign RegWrite = regwrite;
assign Branch = branch;
assign ALUOp = ALU_OP;

endmodule





                    
                    