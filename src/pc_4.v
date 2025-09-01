module pc_4( input [31:0] in_data, output [31:0] out_data);

    assign out_data = in_data + 32'b00000000000000000000000000000100;

endmodule
