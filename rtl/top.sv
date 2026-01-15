/* Copyright (C) 2025  AGH University of Krakow */

module top #(
)(
    input logic clk,
    input logic [7:0] din,
    input logic rst_n,
    output logic tx,
    output logic [7:0] tx_buf, //idk ile bit
    output logic [7:0] tx_done_tick_buf //idk ile bit
);

logic s_tick;
logic tx_start;

counter #(
    .VALUE_MAX(250000) //100mhz, 250 000 for 100Hz //idk
) u_counter_s_tick (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(s_tick)
);

counter #(
    .VALUE_MAX(250000) //100mhz, 250 000 for 100Hz //idk
) u_counter_tx_start (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(tx_start)
);

endmodule
