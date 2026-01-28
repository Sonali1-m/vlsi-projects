`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2026 23:13:08
// Design Name: 
// Module Name: tb_seq_1011
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_seq_1011;

reg clk, reset, din;
wire y;

seq_1011 dut(.clk(clk), .reset(reset), .din(din), .y(y));

always #5 clk = ~clk;

initial begin
    clk = 0; reset = 1; din = 0;
    #10 reset = 0;

    // 1011 011
    #10 din = 1;
    #10 din = 0;
    #10 din = 1;
    #10 din = 1; // detect
    #10 din = 0;
    #10 din = 1;
    #10 din = 1; // detect again

    #40 $stop;
end

endmodule

