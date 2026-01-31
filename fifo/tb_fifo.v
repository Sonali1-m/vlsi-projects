`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2026 10:08:18
// Design Name: 
// Module Name: tb_fifo
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


`timescale 1ns/1ps

module tb_fifo;

parameter DEPTH = 16;
parameter DATA_WIDTH = 8;
parameter PTR_SIZE = 5;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [DATA_WIDTH-1:0] data_in;

wire [DATA_WIDTH-1:0] data_out;
wire empty;
wire full;

FIFO #(
    .DEPTH(DEPTH),
    .DATA_WIDTH(DATA_WIDTH),
    .PTR_SIZE(PTR_SIZE)
) dut (
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .data_in(data_in),
    .data_out(data_out),
    .empty(empty),
    .full(full)
);

// clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    write_en = 0;
    read_en  = 0;
    data_in  = 0;

    #10 reset = 0;

    // -----------------------------
    // Write until FIFO is full
    // -----------------------------
    $display("Writing data...");
    repeat (DEPTH) begin
        @(posedge clk);
        write_en = 1;
        data_in = data_in + 8'h01;
        read_en = 0;
    end
    @(posedge clk);
    write_en = 0;

    // -----------------------------
    // Read until FIFO is empty
    // -----------------------------
    $display("Reading data...");
    repeat (DEPTH) begin
        @(posedge clk);
        read_en = 1;
        write_en = 0;
    end
    @(posedge clk);
    read_en = 0;

    // -----------------------------
    // Simultaneous read & write
    // -----------------------------
    $display("Simultaneous read/write...");
    repeat (5) begin
        @(posedge clk);
        write_en = 1;
        read_en  = 1;
        data_in = data_in + 8'h10;
    end

    @(posedge clk);
    write_en = 0;
    read_en  = 0;

    #50 $stop;
end

endmodule
