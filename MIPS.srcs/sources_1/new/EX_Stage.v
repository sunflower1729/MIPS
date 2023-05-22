`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 23:48:44
// Design Name: 
// Module Name: EX_Stage
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


module EX_Stage(input rst, clk, ALUSrc, RegDst, JAL, input [4:0] rt, rd, input [25:0] imm26, input [31:0] inc_pc, rs_val, rt_val, imm32,
                output pipe_zero, output [4:0] pipe_dest, output [31:0] pipe_j_pc, pipe_branch_pc, pipe_alu_result, pipe_rt_val,
                //control signal
                input [1:0] WB, ALUOp, input [4:0] M,
                output [1:0] pipe_WB, output [4:0] pipe_M, output pipe_JR);
    
    wire [2:0] Alu_sel;
    wire [31:0] Alu_in1;
    wire [31:0] Alu_in2;
    wire [31:0] Alu_result;
    
    wire [31:0] Branch_pc;
    
    wire [27:0] Sll_imm26;
    
    wire [31:0] Sll_imm32;    
    
    
    wire [31:0] Rt_val_adv;    
    
    wire [4:0] RtTo31;    
    wire [4:0] dest;    
    
    wire [31:0] J_pc;
    assign J_pc = {inc_pc[31:28], Sll_imm26};    
    
    //ALU-CON, JR-CON wire
    wire [5:0] lmm32_5_0;
    wire ALUOp1;
    wire JR;
    assign lmm32_5_0 = imm32[5:0];
    assign ALUOp1 = ALUOp[1];
    
    ALU_con u_Alu_con(
    .inst(lmm32_5_0), 
    .alu_op(ALUOp), 
    .ctrl(Alu_sel)
    );
    
    JR_con u_JR_con(
    .alu_op(ALUOp1), 
    .func(lmm32_5_0), 
    .JR(JR)
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
    
  Register1_1 u_register_JR(
    .rst(rst),
    .clk(clk), 
    .DataIn(JR), 
    .DataOut(pipe_JR)
    );
    
    wire Zero;
    
    //datapath
    ALU u_ALU( 
    .crtl(Alu_sel), 
    .in1(Alu_in1), 
    .in2(Alu_in2), 
    .zero(Zero), 
    .out(Alu_result)
    );
    
    Branch_adder u_Branch_adder( 
    .in1(inc_pc), 
    .in2(Sll_imm32), 
    .out_data(Branch_pc)
    );
    
    Shift2_28 u_Shift2_28( 
    .in(imm26), 
    .out(Sll_imm26)
    );
    
    Shift2_32 u_Shift2_32(
    .in(imm32), 
    .out(Sll_imm32)
    );
    
    Mux2_32A u_ALU_in1( 
    .in1(rs_val), 
    .sel(JAL), 
    .out(Alu_in1)
    );
    
    Mux2_32 u_ALU_in2( 
    .in1(rt_val), 
    .in2(Rt_val_adv), 
    .sel(ALUSrc), 
    .out(Alu_in2)
    );
    
    Mux2_32 u_rt_val_adv( 
    .in1(imm32), 
    .in2(inc_pc), 
    .sel(JAL), 
    .out(Rt_val_adv)
    );
    
    Mux2_5A u_Mux2_5A( 
    .in1(rt), 
    .sel(JAL), 
    .out(RtTo31)
    );
    
    Mux2_5 u_Mux2_5(
    .in1(RtTo31), 
    .in2(rd), 
    .sel(RegDst), 
    .out(dest)
    );
    
    Register1 u_j_pc(
    .rst(rst), 
    .clk(clk), 
    .DataIn(J_pc), 
    .DataOut(pipe_j_pc)
    );
    Register1 u_branch_pc(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Branch_pc), 
    .DataOut(pipe_branch_pc)
    );
    
    Register1_1 u_zero(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Zero), 
    .DataOut(pipe_zero)    
    );
    
    Register1 u_alu_result(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Alu_result), 
    .DataOut(pipe_alu_result)
    );
    
    Register1 u_rt_val(
    .rst(rst), 
    .clk(clk), 
    .DataIn(rt_val), 
    .DataOut(pipe_rt_val)
    );
    
    Register1_5 u_dest(
    .rst(rst), 
    .clk(clk), 
    .DataIn(dest), 
    .DataOut(pipe_dest)
    );
    
endmodule
