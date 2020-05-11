/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
reg [31:0] Imm_Gen_out;
wire [7-1:0] opcode = instr_i[6:0];
always@ *
begin
	case(opcode)
		// R
		7'b0110011: Imm_Gen_out <= instr_i;
		// Load
		7'b0000011: 
			begin
				
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31:20]}; 
			end
		// STORE
		7'b0100011: 
			begin
				
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]}; 
			end
		// I_type Imm
		7'b0010011: 
			begin
				
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31:20]}; 
			end
		// SB
		7'b1100011: 
			begin
				//Imm_Gen_o[12] <= instr_i[31]; 
				//Imm_Gen_o[10:5] <= instr_i[30:25];
				//Imm_Gen_o[4:1] <= instr_i[11:8]; 
				//Imm_Gen_o[11] <= instr_i[7]; 
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31],instr_i[7],instr_i[30:25],instr_i[11:8]}; 
			end
		/* JAL-type UJ-type*/
		7'b1101111:
			begin
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31],instr_i[19:12],instr_i[20],instr_i[30:21]};
			end
		/* JALR-type is like I-type*/
		7'b1100111:
			begin
				Imm_Gen_out <= {{20{instr_i[31]}},instr_i[31:20]};
			end
		default: Imm_Gen_out <= 32'b0;
	endcase
end	

assign Imm_Gen_o = Imm_Gen_out;

endmodule