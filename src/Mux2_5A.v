`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 16:09:15
// Design Name: 
// Module Name: Mux2_5A
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

//입력값 또는 4의 값 J에 활용

module Mux2_5A( input [4:0] in1, input sel, output [4:0] out
    );
    
assign out = sel ? 5'b00100 : in1 ;
    
endmodule
