/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module MUX_3to1(
	input  [31:0] data0_i,       
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	input  [ 1:0] select_i,
	output [31:0] data_o
    );		   

/* Write your code HERE */
reg [32-1:0] data_out;   
/* Write your code HERE */
always@(*)begin
	case(select_i) 
	2'b00:
		begin//sel=0 output_Z=input_A
			data_out = data0_i;
		end
	2'b01:
		begin//sel=1 output_Z=input_B
			data_out = data1_i;
		end
	2'b10:
		begin//sel=2 output_Z=input_C
			data_out = data2_i;
		end
	//default: data_out = data0_i - 32'b00000000000000000000000000000100;
	endcase
//$display("%0dns : jump = %2b",$stime, select_i );
end

assign data_o = data_out;   


endmodule      
          