/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps
//`include "./ALU_32bit.v"
`include "./ALU_1bit.v"
`include "./ALU_1bit_MSB.v"
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

wire Set; //the wire to link MSB to result[0]
wire [32-1:0] Cout;
wire   [32-1:0] result_wire;
wire overflow_wire;

ALU_1bit a1 (.src1(src1[0]),
              .src2(src2[0]),
              .less(Set),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),
              .Cin(ALU_control[2]),
	      .operation(ALU_control[1:0]),
              .result(result_wire[0]),
	      .cout(Cout[0])
             );



ALU_1bit a2 (.src1(src1[1]),
              .src2(src2[1]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[0]),
              .result(result_wire[1]),
              .cout(Cout[1])
             );


ALU_1bit a3 (.src1(src1[2]),
              .src2(src2[2]),
              .less(1'b0),
	      .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[1]),
              .result(result_wire[2]),
              .cout(Cout[2])
             );

ALU_1bit a4 (.src1(src1[3]),
              .src2(src2[3]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[2]),
              .result(result_wire[3]),
	      .cout(Cout[3])
             );

ALU_1bit a5 (.src1(src1[4]),
              .src2(src2[4]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[3]),
              .result(result_wire[4]),
	      .cout(Cout[4])
             );

ALU_1bit a6 (.src1(src1[5]),
              .src2(src2[5]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[4]),
              .result(result_wire[5]),
	      .cout(Cout[5])
             );

ALU_1bit a7 (.src1(src1[6]),
              .src2(src2[6]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[5]),
              .result(result_wire[6]),
	      .cout(Cout[6])      
             );

ALU_1bit a8 (.src1(src1[7]),
              .src2(src2[7]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[6]),
              .result(result_wire[7]),
	      .cout(Cout[7])     
             );

ALU_1bit a9 (.src1(src1[8]),
              .src2(src2[8]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[7]),
              .result(result_wire[8]),
	      .cout(Cout[8])
             );

ALU_1bit a10 (.src1(src1[9]),
              .src2(src2[9]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[8]),
              .result(result_wire[9]),
	      .cout(Cout[9])
             );

ALU_1bit a11 (.src1(src1[10]),
              .src2(src2[10]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[9]),
              .result(result_wire[10]),
	      .cout(Cout[10])
             );

ALU_1bit a12 (.src1(src1[11]),
              .src2(src2[11]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[10]),
              .result(result_wire[11]),
	      .cout(Cout[11])
             );

ALU_1bit a13 (.src1(src1[12]),
              .src2(src2[12]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[11]),
              .result(result_wire[12]),
	      .cout(Cout[12])
             );

ALU_1bit a14 (.src1(src1[13]),
              .src2(src2[13]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[12]),
              .result(result_wire[13]),
	      .cout(Cout[13])      
             );

ALU_1bit a15 (.src1(src1[14]),
              .src2(src2[14]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[13]),
              .result(result_wire[14]),
	      .cout(Cout[14])     
             );
ALU_1bit a16 (.src1(src1[15]),
              .src2(src2[15]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[14]),
              .result(result_wire[15]),
	      .cout(Cout[15])
             );



ALU_1bit a17 (.src1(src1[16]),
              .src2(src2[16]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[15]),
              .result(result_wire[16]),
	      .cout(Cout[16])
             );


ALU_1bit a18 (.src1(src1[17]),
              .src2(src2[17]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[16]),
              .result(result_wire[17]),
	      .cout(Cout[17])
             );

ALU_1bit a19 (.src1(src1[18]),
              .src2(src2[18]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[17]),
              .result(result_wire[18]),
	      .cout(Cout[18])
             );

ALU_1bit a20 (.src1(src1[19]),
              .src2(src2[19]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[18]),
              .result(result_wire[19]),
	      .cout(Cout[19])
             );

ALU_1bit a21 (.src1(src1[20]),
              .src2(src2[20]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[19]),
              .result(result_wire[20]),
	      .cout(Cout[20])
             );

ALU_1bit a22 (.src1(src1[21]),
              .src2(src2[21]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[20]),
              .result(result_wire[21]),
	      .cout(Cout[21])      
             );

ALU_1bit a23 (.src1(src1[22]),
              .src2(src2[22]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[21]),
              .result(result_wire[22]),
	      .cout(Cout[22])     
             );

ALU_1bit a24 (.src1(src1[23]),
              .src2(src2[23]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[22]),
              .result(result_wire[23]),
	      .cout(Cout[23])
             );



ALU_1bit a25 (.src1(src1[24]),
              .src2(src2[24]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[23]),
              .result(result_wire[24]),
	      .cout(Cout[24])
             );


ALU_1bit a26 (.src1(src1[25]),
              .src2(src2[25]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[24]),
              .result(result_wire[25]),
	      .cout(Cout[25])
             );

ALU_1bit a27 (.src1(src1[26]),
              .src2(src2[26]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[25]),
              .result(result_wire[26]),
	      .cout(Cout[26])
             );

ALU_1bit a28 (.src1(src1[27]),
              .src2(src2[27]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[26]),
              .result(result_wire[27]),
	      .cout(Cout[27])
             );

ALU_1bit a29 (.src1(src1[28]),
              .src2(src2[28]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[27]),
              .result(result_wire[28]),
	      .cout(Cout[28])
             );

ALU_1bit a30 (.src1(src1[29]),
              .src2(src2[29]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[28]),
              .result(result_wire[29]),
	      .cout(Cout[29])      
             );

ALU_1bit a31 (.src1(src1[30]),
              .src2(src2[30]),
              .less(1'b0),
              .A_invert(ALU_control[3]),
              .B_invert(ALU_control[2]),   
              .operation(ALU_control[1:0]),
              .Cin(Cout[29]),
              .result(result_wire[30]),
	      .cout(Cout[30])      
             );

ALU_1bit_MSB a32 (.src1(src1[31]),
              	  .src2(src2[31]),
                  .less(1'b0),
                  .A_invert(ALU_control[3]),
              	  .B_invert(ALU_control[2]),   
                  .operation(ALU_control[1:0]),
                  .Cin(Cout[30]),
		  .set(Set),
	          .cout(Cout[31]),     
                  .result(result_wire[31]),
		  .overflow(overflow_wire)  //need checking   
                 );



always @* 
   begin
      if (rst_n) begin
         result <= result_wire;
	 zero <= ~|result;         
	 cout <= Cout[31];
	 overflow <= overflow_wire;  
	 //$display("%0dns :\$display: result=%h overflow=%b"  , $stime, result, overflow);        
      end 
   end



endmodule
