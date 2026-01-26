module sseg (
    input logic clk,
    input logic rst_n,
    input logic enabled,
    input logic [3:0] digit0,
    input logic [3:0] digit1,
    input logic [3:0] digit2,
    input logic [3:0] digit3,
    output logic [3:0] sseg_an,
    output logic [6:0] sseg_ca
);

logic [3:0] digit_selected;

ring_counter #(
    .SIZE(4),
    .HOT_VAL(0)
)u_ring_counter(
    .clk(clk),
    .rst_n(rst_n),
    .enabled(enabled),
    .ring(sseg_an)
);

sseg_mux u_sseg_mux(
    .sel(sseg_an),
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .digit_selected(digit_selected)
);

hex2sseg u_hex2sseg(
    .hex(digit_selected),
    .sseg(sseg_ca)
);


endmodule