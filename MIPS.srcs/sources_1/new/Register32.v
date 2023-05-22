`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 12:19:44
// Design Name: 
// Module Name: Register32
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
//RegisterFile

module Register32(input clk, rst, RegWrite, input [4:0] ReadReg1, ReadReg2, WriteReg, input [31:0] WriteData, output  [31:0] ReadData1, ReadData2
    );
    
    reg [31:0] REGS [31:0];
    
    always@(negedge clk, posedge rst)begin
        if(rst)begin
            REGS[0] <= 32'b0;
            REGS[1] <= 32'b0;
            REGS[2] <= 32'b0;
            REGS[3] <= 32'b0;
            REGS[4] <= 32'b0;
            REGS[5] <= 32'b0;
            REGS[6] <= 32'b0;
            REGS[7] <= 32'b0;
            REGS[8] <= 32'b0;
            REGS[9] <= 32'b0;
            REGS[10] <= 32'b0;
            REGS[11] <= 32'b0;
            REGS[12] <= 32'b0;
            REGS[13] <= 32'b0;
            REGS[14] <= 32'b0;
            REGS[15] <= 32'b0;
            REGS[16] <= 32'b0;
            REGS[17] <= 32'b0;
            REGS[18] <= 32'b0;
            REGS[19] <= 32'b0;
            REGS[20] <= 32'b0;
            REGS[21] <= 32'b0;
            REGS[22] <= 32'b0;
            REGS[23] <= 32'b0;
            REGS[24] <= 32'b0;
            REGS[25] <= 32'b0;
            REGS[26] <= 32'b0;
            REGS[27] <= 32'b0;
            REGS[28] <= 32'b0;
            REGS[29] <= 32'b0;
            REGS[30] <= 32'b0;
            REGS[31] <= 32'b0;
        end
        else begin
            if(RegWrite & !(WriteReg == 0))
                REGS[WriteReg] <= WriteData; 
        end
    end
    
    assign ReadData1 = (ReadReg1 == 0) ? 32'b0 : REGS[ReadReg1];
    assign ReadData2 = (ReadReg2 == 0) ? 32'b0 : REGS[ReadReg2];
    
endmodule
