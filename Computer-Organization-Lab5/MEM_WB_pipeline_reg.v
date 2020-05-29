/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MEM_WB_pipeline_reg(
	input          clk_i,
    	input          rst_i,
	/*Control signal input*/
	input          MemtoReg_i,
	input          RegWrite_i,
	
	//input [1:0]	Jump_i // not addressed in Lab5
	
	/*Data input*/
        input		[31:0]   data_i,
        input 		[32-1:0] alu_result_i,
	input  		[5-1:0]  RDaddr_i,

	/*Control signal output*/
	output reg          MemtoReg_o,
	output reg          RegWrite_o,
	
	//output reg [1:0]    Jump_o // not addressed in Lab5

	/*Data output*/
	output reg [32-1:0] data_o,
	output reg [32-1:0] alu_result_o,
	output reg [5-1:0]  RDaddr_o
);

always@(posedge clk_i) begin
	if(~rst_i) 
		begin
			/* WB */
			MemtoReg_o <= 1'b0;
	        	RegWrite_o <= 1'b0;
	        	//Jump_o <= 0;
			/* Data*/
			data_o <= 32'd0;
			alu_result_o  <= 32'd0;
			RDaddr_o   <= 5'd0;
	
		end
    	else 
		begin
			/* WB */
			MemtoReg_o <= MemtoReg_i;
	        	RegWrite_o <= RegWrite_i;
	        	// Jump_o <= Jump_i;
			/* Data*/
			data_o  <= data_i;
			alu_result_o  <= alu_result_i;
			RDaddr_o   <= RDaddr_i;
		end
//$display("%0dns :\$display: Opcode = %7b ALUSrc=%b RegWrite=%b Branch =%b ALUOp =%2b"  , $stime, instr_i[7-1:0], alusrc, regwrite, branch, ALU_OP);

end

endmodule 