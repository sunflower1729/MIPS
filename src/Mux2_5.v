`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 00:24:07
// Design Name: 
// Module Name: Mux2_5
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


module Mux2_5(input [4:0] in1, in2, input sel, output [4:0] out
    );
    
    assign out = sel ? in2 : in1;
    
endmodule
