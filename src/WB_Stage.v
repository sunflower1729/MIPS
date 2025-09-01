`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 16:25:30
// Design Name: 
// Module Name: WB_Stage
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


module WB_Stage(input MemtoReg, input [31:0] ReadData, alu_result, output [31:0] WriteData
    );
    
    Mux2_32 u_Mux2_32( 
    .in1(alu_result), 
    .in2(ReadData), 
    .sel(MemtoReg), 
    .out(WriteData)
    );
endmodule