`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 16:17:13
// Design Name: 
// Module Name: Register1_1
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


module Register1_1(input rst, input clk, input DataIn, output reg DataOut
);
    
    always@(posedge clk, posedge rst)begin
        if(!rst)
            DataOut <= 0;
        else begin
            DataOut <= DataIn;
        end
    end
    

endmodule
