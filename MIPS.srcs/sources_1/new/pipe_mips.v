`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 18:02:04
// Design Name: 
// Module Name: pipe_mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipe_mips( input clk, rst
    );
    
    //Control
    wire PCSrc, Jump, RegWrite, ALUSrc, JAL, RegDst; //IF~EX
    wire MEMWrite, MEMRead, JR, MEMtoReg; //MEM~WB
    wire zero; //input
    
    //IF Stage output
    wire [31:0] ID_inc_pc;
    wire [31:0] Instruction;
    
    //ID Stage output 
    wire [31:0] EX_inc_pc, Rs_val, EX_rt_val, imm32;
    wire [4:0] rt, rd;
    wire [25:0] imm26;
    
    //EX Stage output
    wire [31:0] Branch_pc, J_pc, MEM_Alu_result, MEM_rt_val;
    wire [4:0] MEM_dest;
    
    //MEM Stage output
    wire [31:0] Jump_pc, ReadData, WB_alu_result;
    wire [4:0] WriteReg;
    
    //WB Stage output
    wire [31:0] WriteData;
    
    IF_Stage u_IF_Stage(
    .rst(rst), 
    .clk(clk), 
    .jump_pc(Jump_pc),
    .Branch_pc(Branch_pc), 
    .PCSrc(PCSrc), 
    .Jump(Jump), 
    .pipe_inc_pc(ID_inc_pc),
    .pipe_instruction(Instruction)
    );
    
    //ID output Control
    wire [1:0] EX_WB;
    wire [4:0] EX_M;
    wire [4:0] EX_EX;
    
    wire WB_WB1, WB_WB0;
    
    ID_Stage u_ID_Stage(
    .clk(clk), 
    .rst(rst), 
    .RegWrite(WB_WB1), 
    .WriteReg(WriteReg), 
    .inc_pc(ID_inc_pc), 
    .instruction(Instruction), 
    .WriteData(WriteData),
    .pipe_inc_pc(EX_inc_pc), 
    .pipe_rt(rt), 
    .pipe_rd(rd), 
    .pipe_imm26(imm26), 
    .pipe_rs_val(Rs_val), 
    .pipe_rt_val(EX_rt_val), 
    .pipe_imm32(imm32),
    //control signal
    .pipe_WB(EX_WB),
    .pipe_M(EX_M),
    .pipe_EX(EX_EX)
    );
    
    //EX input control reg
    wire [1:0] ALUOp;
    assign JAL = EX_EX[4];
    assign RegDst = EX_EX[3];
    assign ALUOp = EX_EX[2:1];
    assign ALUSrc = EX_EX[0];
    
    //EX  output control reg
    wire [1:0] MEM_WB;
    wire [4:0] MEM_M;
    
    EX_Stage u_EX_Stage(
    .rst(rst), 
    .clk(clk), 
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .JAL(JAL), 
    .rt(rt), 
    .rd(rd), 
    .imm26(imm26), 
    .inc_pc(EX_inc_pc),
    .rs_val(Rs_val),
    .rt_val(EX_rt_val), 
    .imm32(imm32),
    .pipe_zero(zero), 
    .pipe_dest(MEM_dest), 
    .pipe_j_pc(J_pc), 
    .pipe_branch_pc(Branch_pc), 
    .pipe_alu_result(MEM_Alu_result), 
    .pipe_rt_val(MEM_rt_val),
    //control signal
    .WB(EX_WB),
    .ALUOp(ALUOp),
    .M(EX_M),
    .pipe_WB(MEM_WB),
    .pipe_M(MEM_M),
    .pipe_JR(JR)
    );
    
    //MEM output control Reg
    wire [1:0] WB_WB;
    
    MEM_Stage u_MEM_Stage(
    .rst(rst), 
    .clk(clk),
    .JR(JR), 
    .dest(MEM_dest), 
    .J_pc(J_pc), 
    .alu_result(MEM_Alu_result), 
    .rt_val(MEM_rt_val),
    .pipe_dest(WriteReg), 
    .Jump_pc(Jump_pc), 
    .pipe_ReadData(ReadData), 
    .pipe_alu_result(WB_alu_result),
    .WB(MEM_WB),
    .MEM_M(MEM_M),
    .zero(zero),
    .pipe_WB(WB_WB),
    .Jump(Jump),
    .PCSrc(PCSrc)
    );
    
    //WB control reg
    assign WB_WB1 = WB_WB[1];
    assign WB_WB0 = WB_WB[0];
    
    WB_Stage u_WB_Stage(
    .MemtoReg(WB_WB0), 
    .ReadData(ReadData),
    .alu_result(WB_alu_result), 
    .WriteData(WriteData)
    );
    
endmodule
