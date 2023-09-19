module shift_adder #(
    parameter kernal = 3
)
(
    input clk,
    input rst,
    input in,
    output reg [3:0] out
);

reg [3:0] cntr;

always@(posedge clk or posedge rst) begin
    if (rst) begin
        out = 0;
        cntr = 0;
    end
    else begin
        if (cntr < kernal*kernal-1) begin
            cntr = cntr + 1;
            out = out + in;
        end
        else begin
            cntr = 0;
            out = in;
        end        
    end
end

endmodule