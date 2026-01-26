/* Copyright (C) 2025  AGH University of Krakow */

module ring_counter #(
    parameter SIZE = 4,
    parameter bit HOT_VAL = 1 // 1 = One-Hot (wędrująca 1), 0 = One-Cold (wędrujące 0)
)(
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic [SIZE-1:0] ring
);


logic [SIZE-1:0] ring_nxt;
logic [SIZE-1:0] reset_pattern;

assign reset_pattern = HOT_VAL ? {{SIZE-1{1'b0}}, 1'b1} : {{SIZE-1{1'b1}}, 1'b0};

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ring <= reset_pattern;
    end else begin
        ring <= ring_nxt;
    end
end

always_comb begin
    ring_nxt = ring;

    if (enabled) begin
        ring_nxt = {ring[SIZE-2:0], ring[SIZE-1]};
    end
end

endmodule