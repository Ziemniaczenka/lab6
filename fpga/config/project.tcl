# Vivado project configuration file

# set project_name sseg_basys3
# set top_module top_basys3
# set target xc7a35tcpg236-1

# set xdc_files {
#     constraints/top_basys3.xdc
# }

# set sv_files {
#     ../rtl/counter.sv
#     ../rtl/uart/uart_tx.sv
#     ../rtl/uart/uart_tx_out_buffer.sv
#     ../rtl/top.sv
#     rtl/top_basys3.sv
# }


set project_name rxUart_basys3
set top_module rx_top_basys3
set target xc7a35tcpg236-1

set xdc_files {
    constraints/rx_top_basys3.xdc
}

set sv_files {
    ../rtl/counter.sv
    ../rtl/ring_counter.sv
    ../rtl/sseg/hex2sseg.sv
    ../rtl/sseg/sseg_mux.sv
    ../rtl/sseg.sv
    ../rtl/uart/uart_rx.sv
    ../rtl/uart/uart_rx_buffer.sv
    ../rtl/rx_top.sv
    rtl/rx_top_basys3.sv
}
