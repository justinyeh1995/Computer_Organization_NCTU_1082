/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps
`include "./ALU_32bit.v"

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire   [32-1:0] result_wire;
wire            carryout;
wire            overflow_wire;

ALU_32bit a1u32 (.src1(src1),
          	 .src2(src2),
            	 .less(1'b0),
                 .A_invert(ALU_control[3]),
                 .B_invert(ALU_control[2]),
                 .Cin(ALU_control[2]),
                 .operation(ALU_control[1:0]),
                 .result(result_wire),
                 .cout(carryout),
		 .overflow(overflow_wire)
                );

always @* 
   begin
      if (rst_n) begin
         result <= result_wire;
	 zero <= ~|result_wire;         
	 cout <= carryout;
	 overflow <= overflow_wire;  
	 //$display("%0dns :\$display: result=%h overflow=%b"  , $stime, result, overflow);        
      end 
   end



endmodule
