/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output          Branch,
	output [1:0]	ALUOp,
	output [1:0]	Jump
	);

/* Write your code HERE */
reg            alusrc;
reg            regwrite;
reg            branch;
reg    [2-1:0] ALU_OP;

reg 	       memtoReg;
reg 	       memRead;
reg 	       memWrite;
reg    [2-1:0] jump;

always@ * 
	begin
	case(instr_i[7-1:0]) 
		/* R-format */
		7'b0110011:
			begin
				alusrc <= 0; memtoReg <= 0; regwrite <= 1; memRead <= 0; memWrite <= 0; branch <= 0; ALU_OP <= 2'b10; jump <= 2'b00;
			end
		/* I-type Load */
		7'b0000011:
			begin
				alusrc <= 1; memtoReg <= 1; regwrite <= 1; memRead <= 1; memWrite <= 0; branch <= 0; ALU_OP <= 2'b00; jump <= 2'b00;
			end
		/* S-type */
		7'b0100011:
			begin
				alusrc <= 1; memtoReg <= 1'bx; regwrite <= 0; memRead <= 0; memWrite <= 1; branch <= 0; ALU_OP <= 2'b00; jump <= 2'b00;
			end
		/* SB-type */
		7'b1100011:
			begin
				alusrc <= 0; memtoReg <= 1'bx; regwrite <= 0; memRead <= 0; memWrite <= 0; branch <= 1; ALU_OP <= 2'b01; jump <= 2'b00;
			end
		/* I-type immediate */
		7'b0010011:
			begin
				alusrc <= 1; memtoReg <= 0; regwrite <= 1; memRead <= 0; memWrite <= 0; branch <= 0; ALU_OP <= 2'b11; jump <= 2'b00;
			end

		/* JAL-type */
		7'b1101111:
			begin
				alusrc <= 0; memtoReg <= 0; regwrite <= 1; memRead <= 0; memWrite <= 0; branch <= 0; ALU_OP <= 2'b11; jump <= 2'b01;
			end
		/* JALR-type */
		7'b1100111:
			begin
				alusrc <= 0; memtoReg <= 0; regwrite <= 1; memRead <= 0; memWrite <= 0; branch <= 0; ALU_OP <= 2'b11; jump <= 2'b10;
			end
		/* Might need to be commented out after all*/		
		default: 
			begin
				alusrc <= 1'bx; memtoReg <= 1'b0; regwrite <= 1'bx; memRead <= 1'bx; memWrite <= 1'bx; branch <= 1'b0; ALU_OP <= 2'bxx; jump <= 2'bxx;
			end
	endcase
//$display("%0dns :\$display: Opcode = %7b ALUSrc=%b RegWrite=%b Branch =%b ALUOp =%2b"  , $stime, instr_i[7-1:0], alusrc, regwrite, branch, ALU_OP);

end

assign ALUSrc = alusrc;
assign RegWrite = regwrite;
assign Branch = branch;
assign ALUOp = ALU_OP;

assign MemtoReg = memtoReg;
assign MemRead = memRead;
assign MemWrite = memWrite;
assign Jump = jump;

endmodule





                    
                    