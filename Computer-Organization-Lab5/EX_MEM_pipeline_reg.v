/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module EX_MEM_pipeline_reg(
	input          clk_i,
    	input          rst_i,
	/*Control signal input*/
	input          MemtoReg_i,
	input          RegWrite_i,
	input          MemRead_i,
	input          MemWrite_i,
	input          Branch_i,
	
	//input [1:0]	Jump_i // not addressed in Lab5
	
	/*Data input*/
        input  		[32-1:0] PC_add_sum_i,
        input  			 zero_i,
        input 		[32-1:0] alu_result_i,
	input  		[32-1:0] RTdata_i,
	input  		[5-1:0]  RDaddr_i,

	/*Control signal output*/
	output reg          MemtoReg_o,
	output reg          RegWrite_o,
	output reg          MemRead_o,
	output reg          MemWrite_o,
	output reg          Branch_o,
	//output reg [1:0]    Jump_o // not addressed in Lab5

	/*Data output*/
	output reg [32-1:0] PC_add_sum_o,
        output reg 	    zero_o,
	output reg [32-1:0] alu_result_o,
	output reg [32-1:0]  RTdata_o,
	output reg [5-1:0]  RDaddr_o
);

always@(posedge clk_i) begin
	if(~rst_i) 
		begin
			/* WB */
			MemtoReg_o <= 1'b0;
	        	RegWrite_o <= 1'b0;
			// Jump_o <= 1'b0;
	        	/* M*/
			MemRead_o  <= 1'b0;
	        	MemWrite_o <= 1'b0;
	        	Branch_o   <= 1'b0;
			/* Data*/
			PC_add_sum_o   <= 32'd0;
			zero_o  <= 1'b0;
			alu_result_o  <= 32'd0;
			RTdata_o <= 32'd0;
			RDaddr_o   <= 5'd0;
	
		end
    	else 
		begin
			/* WB */
			MemtoReg_o <= MemtoReg_i;
	        	RegWrite_o <= RegWrite_i;
			// Jump_o <= Jump_i;
	        	/* M*/
			MemRead_o  <= MemRead_i;
	        	MemWrite_o <= MemWrite_i;
	        	Branch_o   <= Branch_i;
			/* Data*/
			PC_add_sum_o  <= PC_add_sum_i;
			zero_o   <= zero_i;
			alu_result_o  <= alu_result_i;
			RTdata_o <=  RTdata_i;
			RDaddr_o   <= RDaddr_i;
		end
//$display("%0dns :\$display: Opcode = %7b ALUSrc=%b RegWrite=%b Branch =%b ALUOp =%2b"  , $stime, instr_i[7-1:0], alusrc, regwrite, branch, ALU_OP);

end

endmodule 