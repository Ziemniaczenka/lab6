/* Copyright (C) 2025  AGH University of Krakow */

module top_test;

/* Local variables and signals */

logic clk, rst_n;
logic [3:0] digit0, digit1, digit2, digit3;
logic [3:0] sseg_an;
logic [6:0] sseg_ca;


/* Submodules placement */

top dut (
    .clk,
    .rst_n,
    .digit0,
    .digit1,
    .digit2,
    .digit3,
    .sseg_an,
    .sseg_ca
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
    digit0 = 4'h0;
    digit1 = 4'h1;
    digit2 = 4'h2;
    digit3 = 4'h3;

    reset();

    #20000ns;

    $finish;
end

endmodule
