/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module ALU_1bit_MSB(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				less,       //1 bit less      (input)
	input 				A_invert,    //1 bit A_invert  (input)
	input				B_invert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 			[2-1:0] operation,  //2 bit operation (input)
	output reg    			result,     //1 bit result    (output)
	output reg	    		cout,        //1 bit carry out (output)
	output reg 			set,
	output reg     			overflow
	);

/* Write your code HERE */
wire in1 = src1 ^ A_invert; // implicit continuous assignment
wire in2 = src2 ^ B_invert;
wire AND = in1 & in2;
wire OR  = in1 | in2;
wire SUM = in1 ^ in2 ^ Cin;

always @* 
	begin
		case(operation)
			2'd0: begin result <= AND; cout <= 0; set <= 0; overflow <=0; end
			2'd1: begin result <= OR; cout <= 0; set <= 0; overflow <=0; end
			2'd2: 
				begin
					result <= SUM;
					cout <=  in1&in2 | in1&Cin | in2&Cin;
					set  <= SUM;    
					overflow <= Cin ^ cout; // Cin xor Cout to detect overflow
				end
			2'd3: 
				begin
					result <= less;
					cout <=  in1&in2 | in1&Cin | in2&Cin;
					set  <= SUM;    
					overflow <= Cin ^ cout; // Cin xor Cout to detect overflow
				end
		endcase
	end

endmodule