`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 19:10:02
// Design Name: 
// Module Name: ID_Stage
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


module ID_Stage(input clk, rst, RegWrite, input [4:0] WriteReg, input [31:0] inc_pc, instruction, WriteData,
                output [4:0] pipe_rt, pipe_rd, output [25:0] pipe_imm26, output [31:0] pipe_rs_val, pipe_rt_val, pipe_imm32, pipe_inc_pc,
                //control signal
                output [1:0] pipe_WB, output [4:0] pipe_M, pipe_EX    );
           
    wire [31:0] Rs_val;
    wire [31:0] Rt_val;
    wire [31:0] imm32;     
    
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] offset;
    wire [25:0] imm26;
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign offset = instruction[15:0];
    assign imm26 = instruction[25:0];
    
    //Control input & output
    wire [5:0] op_field; 
    assign op_field = instruction[31:26];
    wire [1:0] WB;
    wire [4:0] M, EX;
    wire WB0, WB1;
    wire M0, M1, M2, M3, M4;
    wire EX0, EX3, EX4;
    wire [1:0] EX1;
    assign WB = {WB1, WB0};
    assign M = {M4, M3, M2, M1, M0};
    assign EX = {EX4, EX3, EX1, EX0};    
    
 Control u_Control(
    .op_field(op_field), 
    .RegWrite(WB1), 
    .MemtoReg(WB0), // WB 
    .Jump(M4), 
    .Branch(M3), 
    .BranchN(M2), 
    .MemRead(M1), 
    .MemWrite(M0), //MEM
    .JAL(EX4), 
    .RegDst(EX3), 
    .ALUOp(EX1), 
    .ALUSrc(EX0)  //EX
    );
    
 Register1_2 u_register_WB(
    .rst(rst), 
    .clk(clk), 
    .DataIn(WB), 
    .DataOut(pipe_WB)
    );
    
 Register1_5 u_register_M(
    .rst(rst),
    .clk(clk), 
    .DataIn(M), 
    .DataOut(pipe_M)
    );
    
  Register1_5 u_register_EX(
    .rst(rst),
    .clk(clk), 
    .DataIn(EX), 
    .DataOut(pipe_EX)
    );
 
 //datapath
 Register32 u_register32(
    .clk(clk), 
    .rst(rst), 
    .RegWrite(RegWrite), 
    .ReadReg1(rs), 
    .ReadReg2(rt), 
    .WriteReg(WriteReg),
    .WriteData(WriteData),
    .ReadData1(Rs_val), 
    .ReadData2(Rt_val)
    );
    
    SignExtender u_Sign( 
    .in(offset), 
    .out(imm32)
    );
    
    Register1 u_inc_pc(
    .rst(rst), 
    .clk(clk), 
    .DataIn(inc_pc), 
    .DataOut(pipe_inc_pc)
    );
    
    Register1 u_rs_val(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Rs_val), 
    .DataOut(pipe_rs_val)
    );
    
    Register1 u_rt_val(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Rt_val), 
    .DataOut(pipe_rt_val)
    );
    
    Register1 u_imm32(
    .rst(rst), 
    .clk(clk), 
    .DataIn(imm32), 
    .DataOut(pipe_imm32)
    );
    
    Register1_5 u_reg_Rt(
    .rst(rst),
    .clk(clk), 
    .DataIn(rt), 
    .DataOut(pipe_rt)
    );
    
    Register1_5 u_reg_rd(
    .rst(rst),
    .clk(clk), 
    .DataIn(rd), 
    .DataOut(pipe_rd)
    );
    
    Register1_26 u_reg1_26(
    .rst(rst), 
    .clk(clk), 
    .DataIn(imm26), 
    .DataOut(pipe_imm26)
    );
    
                
endmodule
