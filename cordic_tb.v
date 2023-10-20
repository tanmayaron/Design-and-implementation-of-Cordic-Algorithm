`include "Cordic copy.v"
`default_nettype none
`timescale 1ns/1ps

module tb_cordic;

reg clk;
reg rst_n;
reg signed [7:0] in;
wire signed [7:0] cosine;
wire signed [7:0] sine;
time period=6;
localparam sf = 2.0 ** -6.0;
localparam o_SF = 2.0 ** -7.0;

cordic c
(
    .rst (rst_n),
    .clk (clk),
    .in (in),
    .sine (sine),
    .cosine (cosine)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_cordic.vcd");
    $dumpvars(0, tb_cordic);
end

initial begin
    clk =1'b0;
repeat(1200)
clk=~clk;
end

initial begin
    $monitor("Cycle: %t Cosine: %f Sine: %f angle: %f",$itor($time/period),$itor(cosine*o_SF),$itor(sine*o_SF),$itor(in*sf));
    #5 rst_n = 1'b0;
	#5 rst_n = 1'b1;
    //in=8'b00_001110;
    //in=8'b00_101011;
    
    repeat(14) @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire