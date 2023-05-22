`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/01 13:59:14
// Design Name: 
// Module Name: ALU
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


module ALU( input [2:0] crtl, input [31:0] in1, in2, output reg  zero, output reg [31:0] out
    );
    
    always@(*)begin
        case(crtl)
            3'b000 : begin out <= in1 & in2; zero <= 0; end //and
            3'b001 : begin out <= in1 | in2; zero <= 0; end //or
            3'b010 : begin out <= in1 + in2; zero <= 0; end //add
            3'b011 : begin out <= in1 + (~in2 + 1); zero <= 0; end //sub
            3'b111 : begin
                        if (in1 < in2) begin
                            zero <= 1;                     
                        end
                        else begin
                            zero <= 0;
                        end
                    end
        endcase
    end
    
endmodule
