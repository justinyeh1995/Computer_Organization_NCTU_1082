/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Forwarding_Unit(
	input clk_i,
	input rst_i,
	input [5-1:0] Rs1_ID_EX,
	input [5-1:0] Rs2_ID_EX,
	input [5-1:0] Rd_EX_MEM,
	input [5-1:0] Rd_MEM_WB,
	input          RegWrite_EX_MEM,
	input          RegWrite_MEM_WB,
	output reg [2-1:0] Forward_A,
	output reg [2-1:0] Forward_B
	);

always@(*) begin
		// Rs1
		/*EX Hazard*/
		if(RegWrite_EX_MEM && Rd_EX_MEM != 5'd0 && Rd_EX_MEM == Rs1_ID_EX) 
		    begin
			Forward_A <= 2'b10;
		    end
		/*MEM Hazard*/
		else if(RegWrite_MEM_WB && Rd_MEM_WB != 5'd0 && !((RegWrite_EX_MEM && Rd_EX_MEM != 5'd0) && (Rd_EX_MEM == Rs1_ID_EX)) && Rd_MEM_WB == Rs1_ID_EX) 
		    begin
			Forward_A <= 2'b01;
		    end
		/* Source ID/EX*/
		else 
		    begin
			Forward_A <= 2'b00;
		    end
		// Rs2
		/*EX Hazard*/
		if(RegWrite_EX_MEM && Rd_EX_MEM != 5'd0 && Rd_EX_MEM == Rs2_ID_EX) 
		    begin
			Forward_B <= 2'b10;
		    end
		/*MEM Hazard*/
		else if(RegWrite_MEM_WB && Rd_MEM_WB != 5'd0 && !((RegWrite_EX_MEM && Rd_EX_MEM != 5'd0) && (Rd_EX_MEM == Rs2_ID_EX)) && Rd_MEM_WB == Rs2_ID_EX) 
		    begin
			Forward_B <= 2'b01;
		    end
		/* Source ID/EX*/
		else 
		    begin
			Forward_B <= 2'b00;
		    end
$display("%0dns :\$display: 3rd Stage Rs1 = %5b Rs2=%5b RegWrite_EX_MEM = %b RegWrite_MEM_WB = %b RD_EX_MEM = %5b, RD_MEM_WB = %5b Foward A = %2b Forward B = %2b"  , $stime, Rs1_ID_EX, Rs2_ID_EX, RegWrite_EX_MEM, RegWrite_MEM_WB, Rd_EX_MEM, Rd_MEM_WB, Forward_A, Forward_B);

	end
endmodule 