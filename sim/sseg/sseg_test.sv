/* Copyright (C) 2025  AGH University of Krakow */

module sseg_test;

/* Local variables and signals */

logic clk, rst_n, enabled;
logic [3:0] digit0, digit1, digit2, digit3;
logic [3:0] sseg_an;
logic [6:0] sseg_ca;


/* Submodules placement */

sseg dut (
    .clk,
    .rst_n,
    .enabled,
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
    enabled = 1'b0;

    reset();

    repeat(20) begin
        @(negedge clk);
        enabled = 1'b1;
        @(negedge clk);
        enabled = 1'b0;
        #50ns;
    end

    $finish;
end

endmodule
