`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2026 22:33:40
// Design Name: 
// Module Name: vending_machine
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


module vending_machine (
    input clk,
    input reset,
    input [1:0] in,        // 00=no coin, 01=5, 10=10
    output reg out,       // product
    output reg [1:0] change // 01=5, 10=10
);

parameter S0  = 2'b00,
          S5  = 2'b01,
          S10 = 2'b10,
          S15 = 2'b11;

reg [1:0] state, next;

always @(posedge clk) begin
    if(reset)
        state <= S0;
    else
        state <= next;
end

always @(*) begin
    out = 0;
    change = 2'b00;
    next = state;

    case(state)
        S0: begin
            if(in == 2'b01) next = S5;
            else if(in == 2'b10) next = S10;
        end

        S5: begin
            if(in == 2'b01) next = S10;
            else if(in == 2'b10) next = S15;
        end

        S10: begin
            if(in == 2'b01) next = S15;
            else if(in == 2'b10) begin
                next = S15;
                change = 2'b01; // return 5
            end
        end

        S15: begin
            out = 1;
            next = S0;
        end
    endcase
end

endmodule
