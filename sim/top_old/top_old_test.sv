/* Copyright (C) 2025  AGH University of Krakow */

module top_old_test;

/* Local variables and signals */
localparam SIZE = 4'd4;
localparam VALUE_MAX = 4'd7;

logic clk, rst_n;
logic [SIZE-1:0] ring;
logic enabled;


/* Submodules placement */

top dut (
    .clk,
    .rst_n,
    .enabled,
    .ring
);


/* Tasks and functions definitions */

task reset();
    for (int i = 0; i < 2; ++i) begin
        @(negedge clk);
        rst_n = i[0];
    end
endtask

task test_disabled_counter();
    enabled = 1'b0;

    reset();

    for (int i = 0; i < 10; ++i) begin
        @(negedge clk);
    end
endtask

task test_enabled_counter();
    enabled = 1'b1;

    reset();

    for (int i = 0; i < 90; ++i) begin
        @(negedge clk);
    end
endtask


/* Clock generation */

initial begin
    clk = 1'b0;

    forever begin
        clk = #5ns ~clk;
    end
end


/* Test */

initial begin
    rst_n = 1'b1;
    enabled = 1'b0;

    test_disabled_counter();
    test_enabled_counter();

    $finish;
end

endmodule