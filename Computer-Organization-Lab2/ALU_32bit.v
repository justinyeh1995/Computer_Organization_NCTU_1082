/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps
`include "./ALU_1bit.v"
`include "./ALU_1bit_MSB.v"

module ALU_32bit(
	input		       [32-1:0]	src1,       //32 bit source 1  (input)
	input		       [32-1:0]	src2,       //32 bit source 2  (input)
	input 				less,       //1 bit less      (input)
	input 				A_invert,    //1 bit A_invert  (input)
	input				B_invert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 		       [ 2-1:0] operation,  //2 bit operation (input)
	output     	       [32-1:0]	result,     //32 bit result    (output)
	output 	    			cout,        //1 bit carry out (output)
	output      			overflow
	);

/* Write you code here */

wire Set; //the wire to link MSB to result[0]
wire [32-1:0] Cout;
wire overflow_wire;
//wire carryout_wire;
//wire connect1;
ALU_1bit a1 (.src1(src1[0]),
              .src2(src2[0]),
              .less(Set),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cin),
              .operation(operation),
              .result(result[0]),
	      .cout(Cout[0])
             );



ALU_1bit a2 (.src1(src1[1]),
              .src2(src2[1]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[0]),
	      .operation(operation),
              .result(result[1]),
              .cout(Cout[1])
             );


ALU_1bit a3 (.src1(src1[2]),
              .src2(src2[2]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[1]),
	      .operation(operation),
              .result(result[2]),
              .cout(Cout[2])
             );

ALU_1bit a4 (.src1(src1[3]),
              .src2(src2[3]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[2]),
              .operation(operation),
              .result(result[3]),
	      .cout(Cout[3])
             );

ALU_1bit a5 (.src1(src1[4]),
              .src2(src2[4]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[3]),
              .operation(operation),
              .result(result[4]),
	      .cout(Cout[4])
             );

ALU_1bit a6 (.src1(src1[5]),
              .src2(src2[5]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[4]),
              .operation(operation),
              .result(result[5]),
	      .cout(Cout[5])
             );

ALU_1bit a7 (.src1(src1[6]),
              .src2(src2[6]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[5]),
              .operation(operation),
              .result(result[6]),
	      .cout(Cout[6])      
             );

ALU_1bit a8 (.src1(src1[7]),
              .src2(src2[7]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[6]),
              .operation(operation),
              .result(result[7]),
	      .cout(Cout[7])     
             );

ALU_1bit a9 (.src1(src1[8]),
              .src2(src2[8]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[7]),
              .operation(operation),
              .result(result[8]),
	      .cout(Cout[8])
             );

ALU_1bit a10 (.src1(src1[9]),
              .src2(src2[9]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[8]),
              .operation(operation),
              .result(result[9]),
	      .cout(Cout[9])
             );

ALU_1bit a11 (.src1(src1[10]),
              .src2(src2[10]),
              .less(less),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[9]),
              .operation(operation),
              .result(result[10]),
	      .cout(Cout[10])
             );

ALU_1bit a12 (.src1(src1[11]),
              .src2(src2[11]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[10]),
              .operation(operation),
              .result(result[11]),
	      .cout(Cout[11])
             );

ALU_1bit a13 (.src1(src1[12]),
              .src2(src2[12]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[11]),
              .operation(operation),
              .result(result[12]),
	      .cout(Cout[12])
             );

ALU_1bit a14 (.src1(src1[13]),
              .src2(src2[13]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[12]),
              .operation(operation),
              .result(result[13]),
	      .cout(Cout[13])      
             );

ALU_1bit a15 (.src1(src1[14]),
              .src2(src2[14]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[13]),
              .operation(operation),
              .result(result[14]),
	      .cout(Cout[14])     
             );
ALU_1bit a16 (.src1(src1[15]),
              .src2(src2[15]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[14]),
              .operation(operation),
              .result(result[15]),
	      .cout(Cout[15])
             );



ALU_1bit a17 (.src1(src1[16]),
              .src2(src2[16]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[15]),
              .operation(operation),
              .result(result[16]),
	      .cout(Cout[16])
             );


ALU_1bit a18 (.src1(src1[17]),
              .src2(src2[17]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[16]),
              .operation(operation),
              .result(result[17]),
	      .cout(Cout[17])
             );

ALU_1bit a19 (.src1(src1[18]),
              .src2(src2[18]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[17]),
              .operation(operation),
              .result(result[18]),
	      .cout(Cout[18])
             );

ALU_1bit a20 (.src1(src1[19]),
              .src2(src2[19]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[18]),
              .operation(operation),
              .result(result[19]),
	      .cout(Cout[19])
             );

ALU_1bit a21 (.src1(src1[20]),
              .src2(src2[20]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[19]),
              .operation(operation),
              .result(result[20]),
	      .cout(Cout[20])
             );

ALU_1bit a22 (.src1(src1[21]),
              .src2(src2[21]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[20]),
              .operation(operation),
              .result(result[21]),
	      .cout(Cout[21])      
             );

ALU_1bit a23 (.src1(src1[22]),
              .src2(src2[22]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[21]),
              .operation(operation),
              .result(result[22]),
	      .cout(Cout[22])     
             );

ALU_1bit a24 (.src1(src1[23]),
              .src2(src2[23]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[22]),
              .operation(operation),
              .result(result[23]),
	      .cout(Cout[23])
             );



ALU_1bit a25 (.src1(src1[24]),
              .src2(src2[24]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[23]),
              .operation(operation),
              .result(result[24]),
	      .cout(Cout[24])
             );


ALU_1bit a26 (.src1(src1[25]),
              .src2(src2[25]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[24]),
              .operation(operation),
              .result(result[25]),
	      .cout(Cout[25])
             );

ALU_1bit a27 (.src1(src1[26]),
              .src2(src2[26]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[25]),
              .operation(operation),
              .result(result[26]),
	      .cout(Cout[26])
             );

ALU_1bit a28 (.src1(src1[27]),
              .src2(src2[27]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[26]),
              .operation(operation),
              .result(result[27]),
	      .cout(Cout[27])
             );

ALU_1bit a29 (.src1(src1[28]),
              .src2(src2[28]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[27]),
              .operation(operation),
              .result(result[28]),
	      .cout(Cout[28])
             );

ALU_1bit a30 (.src1(src1[29]),
              .src2(src2[29]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[28]),
              .operation(operation),
              .result(result[29]),
	      .cout(Cout[29])      
             );

ALU_1bit a31 (.src1(src1[30]),
              .src2(src2[30]),
              .less(1'b0),
              .A_invert(A_invert),
              .B_invert(B_invert),
              .Cin(Cout[29]),
              .operation(operation),
              .result(result[30]),
	      .cout(Cout[30])      
             );

ALU_1bit_MSB a32 (.src1(src1[31]),
              	  .src2(src2[31]),
                  .less(1'b0),
                  .A_invert(A_invert),
                  .B_invert(B_invert),
                  .Cin(Cout[30]),
		  .set(Set),
                  .operation(operation),
	          .cout(Cout[31]),     // what to do with carry out bit?
                  .result(result[31]),
		  .overflow(overflow_wire)  //need checking   
                 );

assign overflow = overflow_wire;
assign cout = Cout[31];
endmodule
