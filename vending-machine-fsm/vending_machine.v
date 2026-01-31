`timescale 1ns/1ps

module vending_machine (
    input clk,
    input reset,
    input [1:0] in,
    output reg out,
    output reg [1:0] change
);

parameter S0  = 2'b00,
          S5  = 2'b01,
          S10 = 2'b10,
          S15 = 2'b11;

reg [1:0] state, next;

// 1) State register
always @(posedge clk) begin
    if (reset)
        state <= S0;
    else
        state <= next;
end

// 2) Next-state logic
always @(*) begin
    next = state;
    case (state)
        S0: begin
            if (in == 2'b01)      next = S5;
            else if (in == 2'b10) next = S10;
        end

        S5: begin
            if (in == 2'b01)      next = S10;
            else if (in == 2'b10) next = S15;
        end

        S10: begin
            if (in == 2'b01)      next = S15;
            else if (in == 2'b10) next = S15;
        end

        S15: begin
            next = S0;   // auto reset after vend
        end
    endcase
end

// 3) Output logic (Moore style)
always @(*) begin
    out = 0;
    change = 2'b00;

    if (state == S15)
        out = 1;

    if (state == S10 && in == 2'b10)
        change = 2'b01; // return 5
end

endmodule
