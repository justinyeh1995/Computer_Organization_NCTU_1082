/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ProgramCounter(
    	input		    clk_i,
	input 		    rst_i,
	input	   [32-1:0] pc_i,
	output reg [32-1:0] pc_o
	);
 
always @(posedge clk_i) begin
    	if(~rst_i)
	    pc_o <= 0;
	else
	    pc_o <= pc_i;
//$display("PC = %32b", pc_o);
end

endmodule



                    
                    