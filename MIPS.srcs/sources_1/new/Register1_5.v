`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 12:03:17
// Design Name: 
// Module Name: Register1_5
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
// 5비트 레지스터 모듈 rs 및 rt 한주기의 데이터를 저장
// 여기서 하나의 레지스터를 더 만들어서 적재해야하는 이유는 ?

module Register1_5(input rst, input clk, input [4:0] DataIn, output reg [4:0] DataOut
    );
  
  
    always@(posedge clk, posedge rst)begin
        if(rst)
            DataOut <= 0;
        else begin
            DataOut <= DataIn;
        end
    end
    
endmodule
