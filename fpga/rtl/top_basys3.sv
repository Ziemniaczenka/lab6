module top_basys3 (
    input wire clk,
    input wire btnC,
    input wire [7:0] sw,
    output wire RsTx,
    output wire [1:0] JB
);

top u_top(
    .clk(clk),
    .rst_n(!btnC),
    .din(sw),
    .tx(RsTx),
    .tx_buf(JB[0]),
    .tx_done_tick_buf(JB[1])
);

endmodule
