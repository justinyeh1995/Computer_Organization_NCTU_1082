/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire 	    RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire 	    ALUSrc;
wire 	    Branch;
wire [1:0]  ALUOp;
wire [31:0] Imm_Gen_o;

wire [31:0] shift_res;
wire [31:0] src2;
wire        zero;
wire [31:0] addr1_o;
wire [31:0] addr2_o;
//?
wire 	    PCSrc = zero & Branch;	
wire [4-1:0] alu_ctrl_instr = {instr[30], instr[14:12]};
wire [4-1:0] alu_ctrl;
wire cout;
wire overflow;
 
ProgramCounter PC(
            .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
            .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        	.instr_i(instr), 
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.Branch(Branch),
		.ALUOp(ALUOp)      
	       );		

Adder Adder1(
            .src1_i(pc_o),     
	    .src2_i(32'b00000000000000000000000000000100),     
	    .sum_o(addr1_o)    
	    );
		
Imm_Gen ImmGen(
	      .instr_i(instr),
	      .Imm_Gen_o(Imm_Gen_o)
	      );
	
Shift_Left_1 SL1(
		.data_i(Imm_Gen_o),
		.data_o(shift_res)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(Imm_Gen_o),
		.select_i(ALUSrc),
		.data_o(src2)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(alu_ctrl_instr),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(alu_ctrl)
		);
		
Adder Adder2(
            .src1_i(pc_o),     
	    .src2_i(shift_res),     
	    .sum_o(addr2_o)    
	    );
		
alu alu(
	.rst_n(rst_i),
	.src1(RSdata_o),
	.src2(src2),
	.ALU_control(alu_ctrl),
	.zero(zero),
	.result(ALUresult),
	.cout(cout),
	.overflow(overflow)
        );
	
MUX_2to1 Mux_PCSrc(
		.data0_i(addr1_o),       
		.data1_i(addr2_o),
		.select_i(PCSrc),
		.data_o(pc_i)
		);
//always@ *
//begin
//$display("PC INPUT = %32b", pc_i);
//end
	
endmodule
		  


