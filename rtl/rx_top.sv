module rx_top #(
    parameter S_TICK = 54
)(
  input logic clk,
  input logic rst_n,
  input logic rx,
  output logic [3:0] sseg_an,
  output logic [6:0] sseg_ca

);

logic [7:0] rx_out;
logic [7:0] buffer_out;
logic rx_done_tick;
logic s_tick;
logic overflow_internal;



counter #(
    .VALUE_MAX(S_TICK) //100mhz/(115200*16) = 54
) u_tick_counter (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(s_tick)
);

uart_rx u_uart_rx(
    .clk,
    .rst_n,
    .rx,
    .s_tick(s_tick),
    .rx_done_tick(rx_done_tick),
    .dout(rx_out)
);

uart_rx_buffer #(
    .DBIT(8)
) u_uart_rx_buffer (
    .clk,
    .rst_n,
    .rx_done_tick(rx_done_tick),
    .din(rx_out),
    .dout(buffer_out)
);
counter #(
    .VALUE_MAX(250000) //100mhz, 250 000 for 100Hz
) u_display_counter (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(overflow_internal)
);

sseg u_sseg (
    .clk,
    .rst_n,
    .enabled(overflow_internal),
    .digit0(buffer_out[3:0]),
    .digit1(buffer_out[7:4]),
    .digit2(1'b0),
    .digit3(1'b0),
    .sseg_an(sseg_an),
    .sseg_ca(sseg_ca)
);

endmodule
