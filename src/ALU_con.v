`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 12:09:12
// Design Name: 
// Module Name: ALU_con
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


module ALU_con(input [5:0] inst, input [1:0] alu_op, output reg [2:0] ctrl
    );
    
    always@(inst, alu_op) begin
        case(alu_op)
            2'b00 : begin ctrl <= 3'b010; end   // Lw, Sw, Hal, Addi
            2'b01 : begin ctrl <= 3'b110; end   // Beq, Bne
            2'b10 : begin 
                case(inst)
                    6'b001000 : ctrl <= 3'b010; //JR
                    6'b100000 : ctrl <= 3'b010; //Add
                    6'b100010 : ctrl <= 3'b110; //Sub
                    6'b100100 : ctrl <= 3'b000; //and 
                    6'b100101 : ctrl <= 3'b001; //Or
                    6'b101010 : ctrl <= 3'b111; //Slt 
                endcase
             end
        endcase    
    end
endmodule
