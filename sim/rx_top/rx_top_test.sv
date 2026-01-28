/* Copyright (C) 2025  AGH University of Krakow */

module rx_top_test;

/* Local variables and signals */

logic clk, rst_n;
logic rx;
logic [3:0] sseg_an;
logic [6:0] sseg_ca;


/* Submodules placement */

rx_top  #(
    .S_TICK(9), //10-1
    .DISPLAY_COUNTER(10)
    ) dut (
    .clk,
    .rst_n,
    .rx,
    .sseg_an,
    .sseg_ca
);


/* Tasks and functions definitions */

task automatic reset();
    rst_n = 1'b0;
    #20ns;
    rst_n = 1'b1;
endtask

/* Clock generation */

initial begin
    clk = 1'b0;
    forever #5ns clk = ~clk;
end

task automatic send_message(input bit  [7:0] message);
    rx = 1'b0;
    #1600ns;
    for (int i=0; i < 8; ++i) begin
        rx = message[i];
        #1600ns; //16*S_TICK*10ns
    end
    rx = 1'b1;
    #1600ns;
endtask

/* Test */

initial begin
    rx = 1;
    reset();
    #500ns
    send_message(8'h67);
    #1600ns
    send_message(8'h0f);
    #1600ns
    send_message(8'h3b);
    #4000ns;

    $finish;
end

endmodule
