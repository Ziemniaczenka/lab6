module rx_top_basys3 #(
)(
  input wire clk,
  input wire btnC,
  input wire RsRx,
  output wire [3:0] an,
  output wire [6:0] seg

);
rx_top u_rx_top (
    .clk(clk),
    .rst_n(!btnC),
    .rx(RsRx),
    .sseg_an(an),
    .sseg_ca(seg)
);



endmodule
