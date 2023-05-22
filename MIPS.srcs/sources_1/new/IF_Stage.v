`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 13:15:35
// Design Name: 
// Module Name: IF_Stage
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


module IF_Stage(input rst, clk, PCSrc, Jump, output [31:0] pipe_inc_pc, pipe_instruction, jump_pc, Branch_pc
    );
    wire [31:0] Current_pc = 32'b0;
    wire [31:0] Next_pc;
    wire [31:0] Inc_pc;
    wire [31:0] Instruction;
    wire [1:0] PCSel = 2'b0;
    
    assign PCSel = {PCSrc, Jump};
    
Register1 pc(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Next_pc), 
    .DataOut(Current_pc)
);

pc_4 pc_4( 
    .in_data(Current_pc),
    .out_data(Inc_pc)
    );
    
I_Memory I_Mem(
    .address(Current_pc),
    .rst(rst),
    .MemData(Instruction)
    );
    
Mux3_32 u_Mux3_32( 
    .in1(Inc_pc), 
    .in2(jump_pc), 
    .in3(Branch_pc), 
    .sel(PCSel), 
    .out_data(Next_pc)
    );
    
Register1 pipe_incpc(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Inc_pc), 
    .DataOut(pipe_inc_pc)
);

Register1 pipeinstruction(
    .rst(rst), 
    .clk(clk), 
    .DataIn(Instruction), 
    .DataOut(pipe_instruction)
);

    
endmodule
