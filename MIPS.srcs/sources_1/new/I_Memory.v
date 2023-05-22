
// 수정필요
module I_Memory(input [31:0] address, input rst, output reg [31:0] MemData
    );
    
    reg [7:0] MEM_TYPE [1023:0];
    reg [7:0] MemData0, MemData1, MemData2, MemData3; 
    
    integer i;
    integer j;
    always@(*)begin
        if(rst)begin
            MEM_TYPE[0] = 8'b00000010;
            MEM_TYPE[1] = 8'b00000000;
            MEM_TYPE[2] = 8'b00000001;
            MEM_TYPE[3] = 8'b00100000; // addi $1, $0, 2
            MEM_TYPE[4] = 8'b00000011; 
            MEM_TYPE[5] = 8'b00000000;
            MEM_TYPE[6] = 8'b00000010;
            MEM_TYPE[7] = 8'b00100000; // addi $2, $0, 3
            MEM_TYPE[8] = 8'b00000000; 
            MEM_TYPE[9] = 8'b00000000;
            MEM_TYPE[10] = 8'b00000000;
            MEM_TYPE[11] = 8'b00000000; // nop
            MEM_TYPE[12] = 8'b00000000; 
            MEM_TYPE[13] = 8'b00000000;
            MEM_TYPE[14] = 8'b00000000;
            MEM_TYPE[15] = 8'b00000000; // nop
            MEM_TYPE[16] = 8'b00000000; 
            MEM_TYPE[17] = 8'b00000000;
            MEM_TYPE[18] = 8'b00000000;
            MEM_TYPE[19] = 8'b00000000; // nop
            MEM_TYPE[20] = 8'b00001100;
            MEM_TYPE[21] = 8'b00000000;
            MEM_TYPE[22] = 8'b00000010;
            MEM_TYPE[23] = 8'b10101100; // sw $2, 12($0)
            MEM_TYPE[24] = 8'b00100100;
            MEM_TYPE[25] = 8'b00011000;
            MEM_TYPE[26] = 8'b01000001;
            MEM_TYPE[27] = 8'b00000000; // and $3, $2, $1
            MEM_TYPE[28] = 8'b00100101;
            MEM_TYPE[29] = 8'b00100000;
            MEM_TYPE[30] = 8'b01000001;
            MEM_TYPE[31] = 8'b00000000; // or $4, $2, $1
            MEM_TYPE[32] = 8'b00100000;
            MEM_TYPE[33] = 8'b00101000;
            MEM_TYPE[34] = 8'b01000001;
            MEM_TYPE[35] = 8'b00000000; // add $5, $2, $1
            MEM_TYPE[36] = 8'b00001100;
            MEM_TYPE[37] = 8'b00000000;
            MEM_TYPE[38] = 8'b00000110;
            MEM_TYPE[39] = 8'b10001100; // lw $6, 12($0)
            
            for(i = 40; i < 1024; i = i+1)
               MEM_TYPE[i] <= 8'b0;
               end
        else
            j = address;
            MemData0 <= MEM_TYPE[j];
            MemData1 <= MEM_TYPE[j+1];
            MemData2 <= MEM_TYPE[j+2];
            MemData3 <= MEM_TYPE[j+3];
            MemData <= {MemData3, MemData2, MemData1, MemData0};
    end
   
    
endmodule