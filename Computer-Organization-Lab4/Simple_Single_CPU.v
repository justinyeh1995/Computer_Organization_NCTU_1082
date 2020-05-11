/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

wire [31:0] pc_i;
wire [31:0] pc_o;
// new aded
wire [31:0] mux_oringinalPCSrc_o;

wire [31:0] instr;
wire 	    RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
// new added
wire [31:0] RDdata_i;

wire [31:0] ALUresult;
wire 	    MemRead,MemWrite;
wire 	    ALUSrc;
wire 	    Branch;
wire [1:0]  ALUOp;
wire [31:0] Imm_Gen_o;
// new added
wire 	    MemtoReg;
// new added
wire [1:0]  Jump;

wire [31:0] DM_o;

wire [31:0] shift_res;
wire [31:0] src2;
wire        zero;
wire [31:0] addr1_o;
wire [31:0] addr2_o;
//?
wire 	     originalPCSrc = zero & Branch;	
wire [4-1:0] alu_ctrl_instr = {instr[30], instr[14:12]};
wire [4-1:0] alu_ctrl;
wire cout;
wire overflow;

wire [31:0] mux_prcsrc_3to1_o;
wire [31:0] Mux_MemtoReg_o;
wire [31:0] PCplus4 = pc_o + 32'b00000000000000000000000000000100;

ProgramCounter PC(
            .clk_i(clk_i),      
	    .rst_i(rst_i),     
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
        .RDdata_i(RDdata_i)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );		

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult),
		.data_i(RTdata_o),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		.data_o(DM_o)
		);
		
Decoder Decoder(
            .instr_i(instr), 
	    .ALUSrc(ALUSrc),
	    .MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
	    .MemRead(MemRead),
	    .MemWrite(MemWrite),
	    .Branch(Branch),
	    .ALUOp(ALUOp),
    	    .Jump(Jump)
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

MUX_2to1 Mux_OringinalPCSrc(
		.data0_i(addr1_o),       
		.data1_i(addr2_o),
		.select_i(originalPCSrc),
		.data_o(mux_oringinalPCSrc_o)
		);	

MUX_3to1 Mux_PCSrc(
		.data0_i(mux_oringinalPCSrc_o),       
		.data1_i(shift_res),
		.data2_i(RSdata_o),
		.select_i(Jump),
		.data_o(pc_i)
		);

MUX_3to1 Mux_WriteDataSrc(
		.data0_i(Mux_MemtoReg_o),       
		.data1_i(PCplus4),
		.data2_i(32'b00000000000000000000000000000000),
		.select_i(Jump),
		.data_o(RDdata_i)
		);
		
MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult),       
		.data1_i(DM_o),
		.select_i(MemtoReg),
		.data_o(Mux_MemtoReg_o)
		);
always@(instr)
begin 
$display("%0dns :\$display: Instruction = %32b "  , $stime, instr);
//if(instr == 32'b0)
//begin
//end
end	
endmodule
		  


