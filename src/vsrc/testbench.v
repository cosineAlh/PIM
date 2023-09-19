`timescale 1ns / 100ps
`define latency 648
`define kernal 3
`define channel 10

module testbench;

parameter kernal = `kernal;
parameter latency = `latency;
parameter channel = `channel;

// Inputs
reg clk;
reg rst;
reg oflag = 0;
reg array_out0, array_out1, array_out2, array_out3, array_out4, array_out5, array_out6, array_out7, array_out8, array_out9;
reg array_out0b, array_out1b, array_out2b, array_out3b, array_out4b, array_out5b, array_out6b, array_out7b, array_out8b, array_out9b;

wire [3:0] sa0, sa1, sa2, sa3, sa4, sa5, sa6, sa7, sa8, sa9;
wire [3:0] sa0b, sa1b, sa2b, sa3b, sa4b, sa5b, sa6b, sa7b, sa8b, sa9b;
wire [3:0] sub0, sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9;

// Outputs
wire [3:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9;

// Other Signals
integer cntr = 0;
reg [2*channel-1:0] array_mem[0:latency-1];

// Instantiate the Unit Under Test (UUT)
shift_adder #(.kernal(kernal))
s_a0 (.clk(clk), .rst(rst), .in(array_out0), .out(sa0));
shift_adder #(.kernal(kernal))
s_a0b (.clk(clk), .rst(rst), .in(array_out0b), .out(sa0b));
substract subs0 (.in(sa0), .inb(sa0b), .out(sub0));
relu relu0 (.in(sub0), .out(out0));

shift_adder #(.kernal(kernal))
s_a1 (.clk(clk), .rst(rst), .in(array_out1), .out(sa1));
shift_adder #(.kernal(kernal))
s_a1b (.clk(clk), .rst(rst), .in(array_out1b), .out(sa1b));
substract subs1 (.in(sa1), .inb(sa1b), .out(sub1));
relu relu1 (.in(sub1), .out(out1));

shift_adder #(.kernal(kernal))
s_a2 (.clk(clk), .rst(rst), .in(array_out2), .out(sa2));
shift_adder #(.kernal(kernal))
s_a2b (.clk(clk), .rst(rst), .in(array_out2b), .out(sa2b));
substract subs2 (.in(sa2), .inb(sa2b), .out(sub2));
relu relu2 (.in(sub2), .out(out2));

shift_adder #(.kernal(kernal))
s_a3 (.clk(clk), .rst(rst), .in(array_out3), .out(sa3));
shift_adder #(.kernal(kernal))
s_a3b (.clk(clk), .rst(rst), .in(array_out3b), .out(sa3b));
substract subs3 (.in(sa3), .inb(sa3b), .out(sub3));
relu relu3 (.in(sub3), .out(out3));

shift_adder #(.kernal(kernal))
s_a4 (.clk(clk), .rst(rst), .in(array_out4), .out(sa4));
shift_adder #(.kernal(kernal))
s_a4b (.clk(clk), .rst(rst), .in(array_out4b), .out(sa4b));
substract subs4 (.in(sa4), .inb(sa4b), .out(sub4));
relu relu4 (.in(sub4), .out(out4));

shift_adder #(.kernal(kernal))
s_a5 (.clk(clk), .rst(rst), .in(array_out5), .out(sa5));
shift_adder #(.kernal(kernal))
s_a5b (.clk(clk), .rst(rst), .in(array_out5b), .out(sa5b));
substract subs5 (.in(sa5), .inb(sa5b), .out(sub5));
relu relu5 (.in(sub5), .out(out5));

shift_adder #(.kernal(kernal))
s_a6 (.clk(clk), .rst(rst), .in(array_out6), .out(sa6));
shift_adder #(.kernal(kernal))
s_a6b (.clk(clk), .rst(rst), .in(array_out6b), .out(sa6b));
substract subs6 (.in(sa6), .inb(sa6b), .out(sub6));
relu relu6 (.in(sub6), .out(out6));

shift_adder #(.kernal(kernal))
s_a7 (.clk(clk), .rst(rst), .in(array_out7), .out(sa7));
shift_adder #(.kernal(kernal))
s_a7b (.clk(clk), .rst(rst), .in(array_out7b), .out(sa7b));
substract subs7 (.in(sa7), .inb(sa7b), .out(sub7));
relu relu7 (.in(sub7), .out(out7));

shift_adder #(.kernal(kernal))
s_a8 (.clk(clk), .rst(rst), .in(array_out8), .out(sa8));
shift_adder #(.kernal(kernal))
s_a8b (.clk(clk), .rst(rst), .in(array_out8b), .out(sa8b));
substract subs8 (.in(sa8), .inb(sa8b), .out(sub8));
relu relu8 (.in(sub8), .out(out8));

shift_adder #(.kernal(kernal))
s_a9 (.clk(clk), .rst(rst), .in(array_out9), .out(sa9));
shift_adder #(.kernal(kernal))
s_a9b (.clk(clk), .rst(rst), .in(array_out9b), .out(sa9b));
substract subs9 (.in(sa9), .inb(sa9b), .out(sub9));
relu relu9 (.in(sub9), .out(out9));

//output file
integer fp;

//initialize the memories
initial begin
    $readmemb("../src/vsrc/array_input.txt", array_mem);
    fp=$fopen("../src/vsrc/array_output.txt","w");
end

//main data flow & output the results
always @(posedge clk or negedge clk)
begin
    if (cntr < latency) begin
        cntr = cntr + 1;
    end

    array_out0 = array_mem[cntr][0];
    array_out1 = array_mem[cntr][1];
    array_out2 = array_mem[cntr][2];
    array_out3 = array_mem[cntr][3];
    array_out4 = array_mem[cntr][4];
    array_out5 = array_mem[cntr][5];
    array_out6 = array_mem[cntr][6];
    array_out7 = array_mem[cntr][7];
    array_out8 = array_mem[cntr][8];
    array_out9 = array_mem[cntr][9];

    array_out0b = array_mem[cntr][10];
    array_out1b = array_mem[cntr][11];
    array_out2b = array_mem[cntr][12];
    array_out3b = array_mem[cntr][13];
    array_out4b = array_mem[cntr][14];
    array_out5b = array_mem[cntr][15];
    array_out6b = array_mem[cntr][16];
    array_out7b = array_mem[cntr][17];
    array_out8b = array_mem[cntr][18];
    array_out9b = array_mem[cntr][19];
   
    if (cntr%18 == 0) begin
        $fwrite(fp,"%d ",out0);        //write results into a file
        $fwrite(fp,"%d ",out1);
        $fwrite(fp,"%d ",out2);
        $fwrite(fp,"%d ",out3);
        $fwrite(fp,"%d ",out4);
        $fwrite(fp,"%d ",out5);
        $fwrite(fp,"%d ",out6);
        $fwrite(fp,"%d ",out7);
        $fwrite(fp,"%d ",out8);
        $fwrite(fp,"%d\n",out9);
        oflag = 1;
    end
    else oflag = 0;
end

initial begin
    //$vcdpluson; // vcs
    $dumpfile("../build/testbench.vcd");
	$dumpvars(0, testbench);

    $fwrite(fp,"out0 ");
    $fwrite(fp,"out1 ");
    $fwrite(fp,"out2 ");
    $fwrite(fp,"out3 ");
    $fwrite(fp,"out4 ");
    $fwrite(fp,"out5 ");
    $fwrite(fp,"out6 ");
    $fwrite(fp,"out7 ");
    $fwrite(fp,"out8 ");
    $fwrite(fp,"out9\n");

    clk = 1;
    rst = 0;

    //#5;
    //rst = 0;
end

//clock generator
always #2.5 clk = ~clk;

//finish
always @(posedge clk)
begin
    if(cntr==latency)
    begin
        $fclose(fp);
        $finish;
    end
end
endmodule