

//입력값 또는 4의 값 J에 활용



module Mux2_32A( input [31:0] in1, input sel, output [31:0] out
    );
    
assign out = sel ? 32'b00000000000000000000000000000100 : in1;
    
endmodule
                            