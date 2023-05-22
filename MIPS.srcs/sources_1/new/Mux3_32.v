`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 15:04:12
// Design Name: 
// Module Name: Mux3_32
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
//3개의 입력값중 고르기

module Mux3_32( input [31:0] in1, in2, in3, input [1:0] sel, output reg [31:0] out_data
    );

    always@(*)
        case(sel)
            2'b00 : out_data = in1;
            2'b01 : out_data = in2;
            2'b10 : out_data = in3;
            2'b11 : out_data = 32'bz;
        endcase
endmodule
