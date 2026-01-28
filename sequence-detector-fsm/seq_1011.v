`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2026 23:11:53
// Design Name: 
// Module Name: seq_1011
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


module seq_1011 (
    input clk,
    input reset,
    input din,
    output reg y
);

parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
reg [1:0] state, next;

always @(posedge clk) begin
    if(reset)
        state <= S0;
    else
        state <= next;
end

always @(*) begin
    y = 0;
    case(state)
        S0: next = (din) ? S1 : S0;
        S1: next = (din) ? S1 : S2;
        S2: next = (din) ? S3 : S0;
        S3: begin
            if(din) begin
                next = S1;
                y = 1;
            end else
                next = S2;
        end
        default: next = S0;
    endcase
end

endmodule

