module relu(
    input [3:0] in,
    output [3:0] out
);

assign out = (in[3] == 0)? in : 0;

endmodule