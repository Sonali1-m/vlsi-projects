`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2026 22:35:48
// Design Name: 
// Module Name: tb_vending
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


module tb_vending;

reg clk;
reg reset;
reg [1:0] in;
wire out;
wire [1:0] change;

vending_machine dut (
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out),
    .change(change)
);

// clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    in = 2'b00;

    #10 reset = 0;

    // Case 1: 5 + 10 = 15
    #10 in = 2'b01; // 5
    #10 in = 2'b10; // 10 -> vend
    #10 in = 2'b00;

    // Case 2: 10 + 10 = 20 (change expected)
    #20 in = 2'b10; // 10
    #10 in = 2'b10; // 10 -> vend + change
    #10 in = 2'b00;

    #50 $stop;
end

endmodule
