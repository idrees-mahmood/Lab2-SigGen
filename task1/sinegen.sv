module sinegen #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(

    input logic clk, //clock
    input logic rst, // reset
    input logic en, // enable
    input logic [DATA_WIDTH-1:0] incr, // increment for addr counter
    output logic [DATA_WIDTH-1:0] dout // output data
);

logic [ADDRESS_WIDTH-1:0] addr;

counter addrCounter ( // intialise the counter module called addrcounter
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (addr) // left has the internal signals, right has the external signals
    // which the whole module can see
);

rom sineRom ( // initialise the rom module called sinerom
    .clk (clk),
    .addr (addr),
    .dout (dout)
);
endmodule
