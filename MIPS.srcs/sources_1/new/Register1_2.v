`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 12:16:23
// Design Name: 
// Module Name: Register1_2
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


module Register1_2(input rst, input clk, input [1:0] DataIn, output reg [1:0] DataOut
    );
  
  
    always@(posedge clk, posedge rst)begin
        if(!rst)
            DataOut <= 0;
        else begin
            DataOut <= DataIn;
        end
    end
    
endmodule
