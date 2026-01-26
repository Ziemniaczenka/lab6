module rx_interface #(
    parameter DIGITS = 2
)(
    input logic clk,
    input logic rst_n,
    input logic [(DIGITS*4 - 1):0] din,
    output logic[(DIGITS*4 - 1):0] dout
);

uart_rx_buffer #(
    .DBIT(4*DIGITS)
) u_uart_rx_buffer (
    .clk,
    .rst_n,
    .din,
    .dout

);

endmodule
