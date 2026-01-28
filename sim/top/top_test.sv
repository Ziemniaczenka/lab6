/* Copyright (C) 2025  AGH University of Krakow */

module top_test;

/* Local variables and signals */

logic clk, rst_n;
logic [7:0] din;
logic tx, tx_buf, tx_done_tick_buf;


/* Submodules placement */

top  #(
    .S_TICK(1), //Divides clock frequency by 2.
    .START_TICK(400)
    ) dut (
    .clk,
    .rst_n,
    .din,
    .tx,
    .tx_buf,
    .tx_done_tick_buf
);


/* Tasks and functions definitions */

task reset();
    rst_n = 1'b0;
    #20ns;
    rst_n = 1'b1;
endtask


/* Clock generation */

initial begin
    clk = 1'b0;
    forever #5ns clk = ~clk;
end


/* Test */

initial begin
    din = 0;


    reset();
    #4000ns
    din = 8'hFF;
    #4000ns
    din = 8'h67;
    #4000ns
    din = 8'h65;
    #4000ns
    din = 8'hA9;
    #8000ns;

    $finish;
end

endmodule
