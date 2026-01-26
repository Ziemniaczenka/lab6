/* Copyright (C) 2025  AGH University of Krakow */

module top #(
    parameter S_TICK = 54,
    parameter START_TICK = 100000000
)(
    input logic clk,
    input logic [7:0] din,
    input logic rst_n,
    output logic tx,
    output logic tx_buf, //idk ile bit
    output logic tx_done_tick_buf //idk ile bit
);

logic s_tick;
logic tx_start;
logic tx_done_tick;

counter #(
    .VALUE_MAX(S_TICK) //100mhz/(115200*16) = 54
) u_counter_s_tick (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(s_tick)
);

counter #(
    .VALUE_MAX(START_TICK) //100mhz * 1s
) u_counter_tx_start (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(tx_start)
);
uart_tx #(
    .DBIT(8), // # data bits
    .SB_TICK(16) // # ticks for stop bits
) u_uart_tx (
    .clk,
    .rst_n,
    .tx_start,
    .s_tick,
    .din,
    .tx_done_tick,
    .tx
);

uart_tx_out_buffer #(
) u_uart_tx_out_buffer (
    .clk,
    .rst_n,
    .tx_in(tx),
    .tx_done_tick_in(tx_done_tick),
    .tx_out(tx_buf),
    .tx_done_tick_out(tx_done_tick_buf)
);

endmodule
