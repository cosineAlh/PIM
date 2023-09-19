module substract(
    input [3:0] in,
    input [3:0] inb,
    output [3:0] regout
);

assign out = in - inb;

endmodule