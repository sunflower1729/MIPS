

//기본 레지스터 모듈 

module Register1 (input rst, input clk, input [31:0] DataIn, output reg [31:0] DataOut
);
    
    always@(posedge clk)begin
        if(rst)
            DataOut = 32'b0;
        else begin
            DataOut = DataIn;
        end
    end
    

endmodule