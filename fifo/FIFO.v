module FIFO #(
    parameter DEPTH = 16,
    parameter DATA_WIDTH = 8,
    parameter PTR_SIZE = 5
)(
    input  wire clk,
    input  wire reset,
    input  wire write_en,
    input  wire read_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,
    output wire empty,
    output wire full
);

reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];
reg [PTR_SIZE-1:0] wr_ptr, rd_ptr;
reg [PTR_SIZE:0] count;

// write
always @(posedge clk) begin
    if (reset)
        wr_ptr <= 0;
    else if (write_en && !full) begin
        memory[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
    end
end

// read
always @(posedge clk) begin
    if (reset)
        rd_ptr <= 0;
    else if (read_en && !empty) begin
        data_out <= memory[rd_ptr];
        rd_ptr <= rd_ptr + 1;
    end
end

// count
always @(posedge clk) begin
    if (reset)
        count <= 0;
    else begin
        case ({write_en && !full, read_en && !empty})
            2'b10: count <= count + 1;
            2'b01: count <= count - 1;
        endcase
    end
end

assign empty = (count == 0);
assign full  = (count == DEPTH);

endmodule
