`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 16:18:58
// Design Name: 
// Module Name: MEM_Stage
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


module MEM_Stage(input rst, clk, JR, input [4:0] dest, input [31:0] J_pc, alu_result, rt_val, 
                output [4:0] pipe_dest, output [31:0] Jump_pc, pipe_ReadData, pipe_alu_result,
                //control input output
                input [1:0] WB, input [4:0] MEM_M, input zero, output [1:0] pipe_WB, output reg Jump, PCSrc);
    
    wire [31:0] ReadData;
    
    //control signal
    wire J, Branch, BranchN, MEMRead, MEMWrite;
    reg PCSrc1, PCSrc2;
    assign J = MEM_M[4];
    assign Branch = MEM_M[3];
    assign BranchN = MEM_M[2];
    assign MEMRead = MEM_M[1];
    assign MEMWrite = MEM_M[0];    
    
    
    always@(posedge clk)begin
        Jump <= J || JR;
        PCSrc1 <= Branch && zero;
        PCSrc2 <= BranchN && ~(zero);
        PCSrc <= PCSrc1 || PCSrc2;
    end
    
    //control Register
    Register1_2 u_register_WB(
    .rst(rst), 
    .clk(clk), 
    .DataIn(WB), 
    .DataOut(pipe_WB)
    );
    
    
    D_Memory u_D_Memory( 
    .MemRead(MEMRead), 
    .MemWrite(MEMWrite), 
    .address(alu_result), 
    .Write_data(rt_val), 
    .ReadData(ReadData)
    );
        
    Mux2_32 u_Mux2_32(
    .in1(J_pc),
    .in2(alu_result),
    .sel(JR),
    .out(Jump_pc)
    );
    
    Register1 U_ReadData(
    .rst(rst), 
    .clk(clk), 
    .DataIn(ReadData), 
    .DataOut(pipe_ReadData)
    );
    
    Register1 Alt_result(
    .rst(rst), 
    .clk(clk), 
    .DataIn(alu_result), 
    .DataOut(pipe_alu_result)
    );
    
    Register1_5 u_dest(
    .rst(rst), 
    .clk(clk), 
    .DataIn(dest), 
    .DataOut(pipe_dest)
    );
    
endmodule
