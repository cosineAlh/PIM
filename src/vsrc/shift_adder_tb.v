`timescale 1ns / 100ps

module shift_adder_tb;

parameter kernal = 3;

// Inputs
reg clk;
reg rst;
reg in;

// Outputs
wire [3:0] out;

// Other Signals
reg [8:0] in_mem;
integer cntr = 0;

// Instantiate the Unit Under Test (UUT)
shift_adder #(
    .kernal(kernal)
)
shift_adder
(
    .clk(clk), 
    .rst(rst), 
    .in(in), 
    .out(out)
);

//output file
//integer fp_w;

//initialize the memories
//initial
//begin
//    fp_w=$fopen("./my_output.txt","w");
//end


//main data flow & output the results
always @(posedge clk)
begin
    if (rst) begin
        in = 0;
        cntr = 0;
    end
    else begin
        if (cntr < kernal*kernal-1) begin
            cntr = cntr + 1;
        end
        else begin
            cntr = 0;
        end
        
        in = in_mem[cntr];
    end
   
    //$fwrite(fp_w,"%d\n",out);        //write results into a file
end

initial begin
    $dumpfile("../../build/shift_adder.vcd");
	$dumpvars(0, shift_adder_tb);
    //$vcdpluson; // vcs
    //$sdf_annotate("my_sdf.sdf",shift_adder_tb.shift_adder); // vcs sythesis

    in_mem = 9'b100000000;

    clk = 0;
    rst = 1;

    #5;
    rst = 0;

    #150;
    //$fclose(fp_w);
    $finish;
end

//clock generator
always #2.5 clk = ~clk;

endmodule