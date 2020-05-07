/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input  [32-1:0] data0_i,       
	input  [32-1:0] data1_i,
	input       	select_i,
	output [32-1:0] data_o
               );

reg [32-1:0] data_out;   
/* Write your code HERE */
always@(*)begin
	if(!select_i) begin//sel=0 output_Z=input_A
		data_out = data0_i;
	end
	else begin//sel=1 output_Z=input_B
		data_out = data1_i;
	end
end

assign data_o = data_out;   

endmodule      
          