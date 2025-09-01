`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 16:44:22
// Design Name: 
// Module Name: D_Memory
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


module D_Memory( input MemRead, MemWrite, input [31:0] address, Write_data, output reg [31:0] ReadData
    );
    
    reg [7:0] MEM_TYPE [1023:0];
    reg [7:0] ReadData0, ReadData1, ReadData2, ReadData3;
    integer i, j;
    
    initial begin
        ReadData <= 0;
        for(i = 0; i < 1024; i = i+1)
               MEM_TYPE[i] <= 8'b0;
    end

    always@(*)begin
        j = address;
        if(MemRead)begin
            ReadData0 <= MEM_TYPE[address];
            ReadData1 <= MEM_TYPE[address+1];
            ReadData2 <= MEM_TYPE[address+2];
            ReadData3 <= MEM_TYPE[address+3];
            ReadData <= {ReadData3, ReadData2, ReadData1, ReadData0};
        end
        if(MemWrite)begin
            MEM_TYPE[address+3] <= Write_data[31:24];
            MEM_TYPE[address+2] <= Write_data[23:16];
            MEM_TYPE[address+1] <= Write_data[15:8];
            MEM_TYPE[address] <= Write_data[7:0];
        end
    end
    
    
endmodule
