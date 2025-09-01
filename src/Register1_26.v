`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 12:15:02
// Design Name: 
// Module Name: Register1_26
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
//j에서 opcode를 제외한 나머지

module Register1_26(input rst, input clk, input [25:0] DataIn, output reg [25:0] DataOut
    );
  
  
    always@(posedge clk, posedge rst)begin
        if(!rst)
            DataOut <= 0;
        else begin
            DataOut <= DataIn;
        end
    end
    
endmodule