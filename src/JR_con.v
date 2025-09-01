`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 12:25:35
// Design Name: 
// Module Name: JR_con
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


module JR_con(input alu_op, input [5:0] func, output reg JR
    );
    always@(alu_op, func)begin
        if(alu_op == 1'b1 && func == 6'b001000)
            JR <= 1'b1;
        else
            JR <= 1'b0; 
    end
endmodule
