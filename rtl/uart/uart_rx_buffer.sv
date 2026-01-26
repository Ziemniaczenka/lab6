module uart_rx_buffer #(
    parameter DBIT = 8
)(
    input logic clk,
    input logic rst_n,
    input logic rx_done_tick,
    input logic [(DBIT-1):0] din,
    output logic[(DBIT-1):0] dout
);


always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        dout <= 1'b0;
    end else if (rx_done_tick) begin
        dout <= din;
    end
end


endmodule
