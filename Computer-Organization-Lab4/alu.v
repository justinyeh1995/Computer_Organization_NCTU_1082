/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input	       rst_n,         // Reset                     (input)
	input	[31:0] src1,          // 32 bits source 1          (input)
	input	[31:0] src2,          // 32 bits source 2          (input)
	input 	[ 3:0] ALU_control,   // 4 bits ALU control input  (input)
	output  [31:0] result,        // 32 bits result            (output)
	output         zero,          // 1 bit when the output is 0, zero must be set (output)
	output         cout,          // 1 bit carry out           (output)
	output         overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

reg   [32-1:0] 	Result;
reg             Cout;
reg             Overflow;
reg		Zero;

always @* 
   begin
      if (rst_n) begin          
	 //$display("%0dns :\$display: result=%h overflow=%b"  , $stime, result, overflow);
	Cout <= 1'b0; //Don't care
	Overflow <= 1'b0; //Don't care

	case(ALU_control)
		/* AND :0*/
		4'b0000: 
			begin 
				Result <= src1 & src2;
				Zero <= (Result == 0)?1:0; 
			end
		/* OR :1*/	
		4'b0001: 
			begin 
				Result <= src1 | src2; 
				Zero <= (Result == 0)?1:0;  
			end
		/* ADD :2*/
		4'b0010: 
			begin
				Result <= src1 + src2;
				Zero <= (Result == 0)?1:0; 
			end
		/* SUB :6*/
		4'b0110: 
			begin
				Result <= src1 - src2;
				Zero <= (Result == 0)?1:0; 	
			end
		/* SLT :7*/
		4'b0111: 
			begin
				Result <= (src1 < src2)?1:0;
				Zero <= (Result == 0)?1:0; 	   
			end
		/* NOR :12*/
		4'b1100: 
			begin
				Result <= ~(src1 | src2);
				Zero <= (Result == 0)?1:0; 	
			end
		/* XOR :13*/
		4'b1101: 
			begin
				Result <= src1 ^ src2;
				Zero <= (Result == 0)?1:0; 
			end
		/* SLL :3*/
		4'b0011: 
			begin
				Result <= src1 << src2;
				Zero <= (Result == 0)?1:0; 
			end
		/* SRL :4*/
		4'b0100: 
			begin
				Result <= src1 >> src2;
				Zero <= (Result == 0)?1:0; 
			end
		/* SRA :5*/
		4'b0101: 
			begin
				Result <= src1 >>> src2;
				Zero <= (Result == 0)?1:0; 
			
			end

		/* BEQ :10*/
		4'b1010: 
			begin
				Result <= src1 - src2;
				Zero <= ((src1 - src2) == 0)?1:0; 
			end

		/* BNE :11*/
		4'b1011: 
			begin
				Result <= src1 - src2;
				Zero <= ((src1 - src2) == 0)?0:1;
			
			end
		
		/* BLT :8*/
		4'b1000: 
			begin
				Result <= src1 - src2;
				Zero <= (src1 < src2)?1:0;
				$display("%0dns : RESULT =%d" ,$stime , Result);
			end
		
		/* BGE :9*/
		4'b1001: 
			begin
				Result <= src1 - src2;
				Zero <= (src1 >= src2)?1:0;
			
			end
		
		default: 
			begin
				Result <= 32'b00000000000000000000000000000000;
				Zero <= (Result == 0)?1:0;  
			end
	endcase

	/* Used in beq/bne*/
	//zero <= ~|result; 
	
      end 
   end

assign result = Result;
assign zero = Zero;
assign cout = Cout;
assign overflow = Overflow;

endmodule
