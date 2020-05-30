/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
	input clk_i,
	input rst_i
	);
/*PC*/
wire [31:0] pc_i;
wire [31:0] pc_o;
/* Mux 2-to-1 oringinalPCSrc */
wire [31:0] mux_oringinalPCSrc_o;
/* Mux 3-to-1 PCSrc */
//wire [31:0] mux_prcsrc_3to1_o;
wire [31:0] PCplus4 = pc_o + 32'b00000000000000000000000000000100;

/*Adder PC+4*/
wire [31:0] addr1_o;

/*I_Mem*/
wire [31:0] instr;

/*IF/ID Reg*/
wire [31:0] IF_ID_pc_o;
wire [31:0] IF_ID_instr_o;
wire [4-1:0] alu_ctrl_instr_IF_ID = {IF_ID_instr_o[30], IF_ID_instr_o[14:12]};

/*Decoder signal out*/
wire 	    MemRead,MemWrite;
wire 	    ALUSrc;
wire 	    Branch;
wire [1:0]  ALUOp;
wire 	    MemtoReg;
wire 	    RegWrite;
wire [1:0]  Jump;

/*RegFile*/
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] RDdata_i;

/*Imm_Gen*/
wire [31:0] Imm_Gen_o;

/*ID/EX*/
wire 	    MemRead_ID_EX_o,MemWrite_ID_EX_o;
wire 	    ALUSrc_ID_EX_o;
wire 	    Branch_ID_EX_o;
wire [1:0]  ALUOp_ID_EX_o;
wire 	    MemtoReg_ID_EX_o;
wire 	    RegWrite_ID_EX_o;
wire [32-1:0] pc_ID_EX_o;
wire [32-1:0] Imm_Gen_ID_EX_o;
wire [4-1:0] alu_ctrl_instr_ID_EX_o;
wire [32-1:0] RSData_ID_EX_o;
wire [32-1:0] RTData_ID_EX_o;
wire [5-1:0] RD_ID_EX_o;

/* Fowarding unit input*/
wire [5-1:0] Rs1_IF_ID_o;
wire [5-1:0] Rs2_IF_ID_o;
wire [2-1:0]  select_Foward_A;
wire [2-1:0]  select_Foward_B;

/*Shift-Left 1*/
wire [31:0] shift_res;

/*Adder PC+Imm*/
wire [31:0] addr2_o;

/*Mux ALUSrc output*/
wire [31:0] src2;

/*Mux_Foward_A output*/
wire [32-1:0] Forward_A_o;

/*Mux_Foward_B output*/
wire [32-1:0] Forward_B_o;

/*ALU*/
wire [31:0] ALUresult;
wire        zero;
wire 	    cout;
wire        overflow;

/*ALU_Control*/
wire [4-1:0] alu_ctrl;

/*EX/MEM*/
wire 	    	MemRead_EX_MEM_o,MemWrite_EX_MEM_o;
wire 	    	Branch_EX_MEM_o;
wire 	    	MemtoReg_EX_MEM_o;
wire 	    	RegWrite_EX_MEM_o;
wire  [32-1:0]  PCplusImm_EX_MEM_o;
wire        	zero_EX_MEM_o;
wire  [32-1:0]  alu_result_EX_MEM_o;     
wire  [32-1:0]  RTdata_EX_MEM_o;
wire  [5-1:0]   RD_EX_MEM_o; 

/*Data Memory*/
wire [31:0] DM_o;

/*Branch & Zero*/
wire 	     originalPCSrc = zero_EX_MEM_o & Branch_EX_MEM_o;	

/*MEM/WB*/
wire 	    	MemtoReg_MEM_WB_o;
wire 	    	RegWrite_MEM_WB_o;

wire  [32-1:0]  alu_result_MEM_WB_o;     
wire  [32-1:0]  DM_MEM_WB_o;
wire  [5-1:0]   RD_MEM_WB_o; 
/*Mux MemtoReg*/
wire [31:0] Mux_MemtoReg_o;

MUX_2to1 Mux_OringinalPCSrc(
		.data0_i(addr1_o),       
		.data1_i(PCplusImm_EX_MEM_o),
		.select_i(originalPCSrc),
		.data_o(mux_oringinalPCSrc_o)
		);	

ProgramCounter PC(
            .clk_i(clk_i),      
	    .rst_i(rst_i),     
	    .pc_i(mux_oringinalPCSrc_o) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
            .addr_i(pc_o),  
	    .instr_o(instr)    
	    );		

// PC+4		
Adder Adder1(
            .src1_i(pc_o),     
	    .src2_i(32'b00000000000000000000000000000100),     
	    .sum_o(addr1_o)    
	    );
// IF/ID
IF_ID_pipeline_reg IF_ID(
            .clk_i(clk_i),      
	    .rst_i(rst_i),
	    .pc_i(pc_o),
	    .instr_i(instr),
            .pc_o(IF_ID_pc_o),
            .instr_o(IF_ID_instr_o)
);

Decoder Decoder(
            .instr_i(IF_ID_instr_o), 
	    .ALUSrc(ALUSrc),
	    .MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
	    .MemRead(MemRead),
	    .MemWrite(MemWrite),
	    .Branch(Branch),
	    .ALUOp(ALUOp),
    	    .Jump(Jump) // need checking
	    );

Reg_File RF(
        .clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(IF_ID_instr_o[19:15]) ,  
        .RTaddr_i(IF_ID_instr_o[24:20]) ,  
        .RDaddr_i(RD_MEM_WB_o) , // from WB  
        .RDdata_i(Mux_MemtoReg_o)  , // from WB 
        .RegWrite_i (RegWrite_MEM_WB_o), // from MEM/WB
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );	

Imm_Gen ImmGen(
		.instr_i(IF_ID_instr_o),
		.Imm_Gen_o(Imm_Gen_o)
		);
// ID/EXE

ID_EX_pipeline_reg ID_EX(
	    .clk_i(clk_i),      
	    .rst_i(rst_i),
	/*Control signal input*/
	.ALUSrc_i(ALUSrc),
	.MemtoReg_i(MemtoReg),
	.RegWrite_i(RegWrite),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.Branch_i(Branch),
	.ALUOp_i(ALUOp),
	//.Jump_i() // not addressed in Lab5
	
	/*Data input*/
	.pc_ID_EX_i(IF_ID_pc_o),
        .RSdata_i(RSdata_o),
        .RTdata_i(RTdata_o),
        .Imm_Gen_i(Imm_Gen_o),
	.ALU_Ctrl_i(alu_ctrl_instr_IF_ID),
	.RDaddr_i(IF_ID_instr_o[11:7]), // rd number
	
	/* Fowarding input*/
	.Rs1_IF_ID_i(IF_ID_instr_o[19:15]),
	.Rs2_IF_ID_i(IF_ID_instr_o[24:20]),

	/*Control signal output*/
	.ALUSrc_o(ALUSrc_ID_EX_o),
	.MemtoReg_o(MemtoReg_ID_EX_o),
	.RegWrite_o(RegWrite_ID_EX_o),
	.MemRead_o(MemRead_ID_EX_o),
	.MemWrite_o(MemWrite_ID_EX_o),
	.Branch_o(Branch_ID_EX_o),
	.ALUOp_o(ALUOp_ID_EX_o),
	//.Jump_o() // not addressed in Lab5

	/*Data output*/
	.pc_ID_EX_o(pc_ID_EX_o),
	.RSdata_o(RSData_ID_EX_o),
        .RTdata_o(RTData_ID_EX_o),
	.Imm_Gen_o(Imm_Gen_ID_EX_o),
	.ALU_Ctrl_o(alu_ctrl_instr_ID_EX_o),
	.RDaddr_o(RD_ID_EX_o),

	/* Fowarding output*/
	.Rs1_IF_ID_o(Rs1_IF_ID_o),
	.Rs2_IF_ID_o(Rs2_IF_ID_o)
);

	
	
Shift_Left_1 SL1(
		.data_i(Imm_Gen_ID_EX_o),
		.data_o(shift_res)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTData_ID_EX_o),       
		.data1_i(Imm_Gen_ID_EX_o),
		.select_i(ALUSrc_ID_EX_o),
		.data_o(src2)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(alu_ctrl_instr_ID_EX_o),
		.ALUOp(ALUOp_ID_EX_o),
		.ALU_Ctrl_o(alu_ctrl)
		);
		
Adder Adder2(
            .src1_i(pc_ID_EX_o),     
	    .src2_i(shift_res),     
	    .sum_o(addr2_o)    
	    );

MUX_3to1 Mux_Foward_A(
		.data0_i(RSData_ID_EX_o),       
		.data1_i(Mux_MemtoReg_o),
		.data2_i(alu_result_EX_MEM_o),
		.select_i(select_Foward_A),
		.data_o(Forward_A_o)
		);

MUX_3to1 Mux_Forward_B(
		.data0_i(src2),       
		.data1_i(Mux_MemtoReg_o),
		.data2_i(alu_result_EX_MEM_o),
		.select_i(select_Foward_B),
		.data_o(Forward_B_o)
		);	
alu alu(
	.rst_n(rst_i),
	.src1(Forward_A_o),
	.src2(Forward_B_o),
	.ALU_control(alu_ctrl),
	.zero(zero),
	.result(ALUresult),
	.cout(cout),
	.overflow(overflow)
        );

Forwarding_Unit FU(
	.clk_i(clk_i),      
	.rst_i(rst_i),
	.Rs1_ID_EX(Rs1_IF_ID_o),
	.Rs2_ID_EX(Rs2_IF_ID_o),
	.Rd_EX_MEM(RD_EX_MEM_o),
	.Rd_MEM_WB(RD_MEM_WB_o),
	.RegWrite_EX_MEM(RegWrite_EX_MEM_o),
	.RegWrite_MEM_WB(RegWrite_MEM_WB_o),
	.Forward_A(select_Foward_A),
	.Forward_B(select_Foward_B)
);
// EX/MEM
EX_MEM_pipeline_reg EX_MEM(
	.clk_i(clk_i),      
	.rst_i(rst_i),
	/*Control signal input*/
	.MemtoReg_i(MemtoReg_ID_EX_o),
	.RegWrite_i(RegWrite_ID_EX_o),
	.MemRead_i(MemRead_ID_EX_o),
	.MemWrite_i(MemWrite_ID_EX_o),
	.Branch_i(Branch_ID_EX_o),
	//.Jump_i() // not addressed in Lab5
	//input [1:0]	Jump_i // not addressed in Lab5
	
	/*Data input*/
        .PC_add_sum_i(addr2_o),
        .zero_i(zero),
        .alu_result_i(ALUresult),
	.RTdata_i(Forward_B_o),
	.RDaddr_i(RD_ID_EX_o),

	/*Control signal output*/
	.MemtoReg_o(MemtoReg_EX_MEM_o),
	.RegWrite_o(RegWrite_EX_MEM_o),
	.MemRead_o(MemRead_EX_MEM_o),
	.MemWrite_o(MemWrite_EX_MEM_),
	.Branch_o(Branch_EX_MEM_o),
	//Jump_o // not addressed in Lab5

	/*Data output*/
	.PC_add_sum_o(PCplusImm_EX_MEM_o),
        .zero_o(zero_EX_MEM_o),
	.alu_result_o(alu_result_EX_MEM_o),
	.RTdata_o(RTdata_EX_MEM_o),
	.RDaddr_o(RD_EX_MEM_o)
);

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(alu_result_EX_MEM_o),
		.data_i(RTdata_EX_MEM_o),
		.MemRead_i(MemRead_EX_MEM_o),
		.MemWrite_i(MemWrite_EX_MEM_o),
		.data_o(DM_o)
		);	


/*MEM/WB*/
MEM_WB_pipeline_reg MEM_WB(
	.clk_i(clk_i),      
	.rst_i(rst_i),
	/*Control signal input*/
	.MemtoReg_i(MemtoReg_EX_MEM_o),
	.RegWrite_i(RegWrite_EX_MEM_o),
	
	//input [1:0]	Jump_i // not addressed in Lab5
	
	/*Data input*/
        .data_i(DM_o),
        .alu_result_i(alu_result_EX_MEM_o),
	.RDaddr_i(RD_EX_MEM_o),

	/*Control signal output*/
	.MemtoReg_o(MemtoReg_MEM_WB_o),
	.RegWrite_o(RegWrite_MEM_WB_o),
	
	//output reg [1:0]    Jump_o // not addressed in Lab5

	/*Data output*/
	.data_o(DM_MEM_WB_o),
	.alu_result_o(alu_result_MEM_WB_o),
	.RDaddr_o(RD_MEM_WB_o)
);

//MUX_3to1 Mux_PCSrc(
//		.data0_i(mux_oringinalPCSrc_o),       
//		.data1_i(shift_res),
//		.data2_i(RSdata_o),
//		.select_i(Jump),
//		.data_o(pc_i)
//		);

//MUX_3to1 Mux_WriteDataSrc(
//		.data0_i(Mux_MemtoReg_o),       
//		.data1_i(PCplus4),
//		.data2_i(32'b00000000000000000000000000000000),
//		.select_i(Jump),
//		.data_o(RDdata_i)
//		);
		
MUX_2to1 Mux_MemtoReg(
		.data0_i(alu_result_MEM_WB_o),       
		.data1_i(DM_MEM_WB_o),
		.select_i(MemtoReg_EX_MEM_o),
		.data_o(Mux_MemtoReg_o)
		);
always@(*)
begin 
//$display("%0dns :\$display: 2nd Stage RSdata_o  = %32b RTdata_o = %32b"  , $stime, RSdata_o, RSdata_o );
$display("%0dns :\$display: 3rd Stage Forward_A_o = %32b Forward_B_o = %32b"  , $stime, Forward_A_o, Forward_B_o);
$display("%0dns :\$display: 4th Stage alu_result_EX_MEM_o = %32b"  , $stime, alu_result_EX_MEM_o);
$display("%0dns :\$display: 5th Stage RD_MEM_WB_o = %5b MemtoReg_EX_MEM_o = %1b Mux_MemtoReg_o = %32b"  , $stime, RD_MEM_WB_o, MemtoReg_EX_MEM_o, Mux_MemtoReg_o);
end	
endmodule
		  


