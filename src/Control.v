`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 18:35:45
// Design Name: 
// Module Name: Control
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


module Control(input [5:0] op_field, output reg RegWrite, MemtoReg, // WB 
                Jump, Branch, BranchN, MemRead, MemWrite,       //MEM
                JAL, RegDst, output reg [1:0] ALUOp, output reg ALUSrc  //EX
    );
    
    always@(op_field)begin
        case(op_field)
            6'b000000 : begin //R-Type
                        JAL = 0; RegDst = 1; ALUOp = 2'b10; ALUSrc = 0; Jump = 0; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 1; MemtoReg = 0;
                        end
            6'b100011 : begin //Lw
                        JAL = 0; RegDst = 0; ALUOp = 2'b00; ALUSrc = 1; Jump = 0; Branch = 0; BranchN = 0; MemRead = 1; MemWrite = 0; RegWrite = 1; MemtoReg = 1;
                        end
            6'b101011 : begin //Sw
                        JAL = 0; RegDst = 1'bx; ALUOp = 2'b00; ALUSrc = 1; Jump = 0; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 1; RegWrite = 0; MemtoReg = 1'bx;
                        end
            6'b000100 : begin //Beq
                        JAL = 0; RegDst = 1'bx; ALUOp = 2'b01; ALUSrc = 0; Jump = 0; Branch = 1; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 0; MemtoReg = 1'bx;
                        end
            6'b000101 : begin //Bne
                        JAL = 0; RegDst = 1'bx; ALUOp = 2'b01; ALUSrc = 0; Jump = 1; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 0; MemtoReg = 1'bx;
                        end
            6'b000010 : begin //J
                        JAL = 0; RegDst = 1'bx; ALUOp = 2'bxx; ALUSrc = 1'bx; Jump = 1; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 0; MemtoReg = 1'bx;
                        end
            6'b000011 : begin //JAL
                        JAL = 1; RegDst = 0; ALUOp = 2'b00; ALUSrc = 1; Jump = 1; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 1; MemtoReg = 0;
                        end
            6'b001000 : begin //Addi
                        JAL = 0; RegDst = 0; ALUOp = 2'b00; ALUSrc = 1; Jump = 0; Branch = 0; BranchN = 0; MemRead = 0; MemWrite = 0; RegWrite = 1; MemtoReg = 0;
                        end
            endcase
    
    end
endmodule
