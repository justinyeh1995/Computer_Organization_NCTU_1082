/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module IF_ID_pipeline_reg(
	input          clk_i,
    	input          rst_i,
	
	
	/*Data input*/
        input  		[32-1:0] pc_i,
        input		[32-1:0] instr_i,

	/*Data output*/
	output reg [32-1:0] pc_o,
	output reg [32-1:0] instr_o
);

always@(posedge clk_i) begin
	if(~rst_i) 
		begin
			pc_o <= 32'd0;
	        	instr_o <= 32'd0;
	
		end
    	else 
		begin
			pc_o <= pc_i;
	        	instr_o <= instr_i;
		end
//$display("%0dns :\$display: Opcode = %7b ALUSrc=%b RegWrite=%b Branch =%b ALUOp =%2b"  , $stime, instr_i[7-1:0], alusrc, regwrite, branch, ALU_OP);

end

endmodule 