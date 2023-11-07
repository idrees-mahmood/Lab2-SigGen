module sinegen #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(

    input logic clk, //clock
    input logic rst, // reset
    input logic en, // enable
    input logic [DATA_WIDTH-1:0] incr, // increment for addr counter
    input logic [DATA_WIDTH-1:0] offset,
    output logic [DATA_WIDTH-1:0] dout1, // output data
    output logic [DATA_WIDTH-1:0] dout2 // output data
);

logic [ADDRESS_WIDTH-1:0] addr1;
logic [ADDRESS_WIDTH-1:0] addr2;

counter addrCounter ( // intialise the counter module called addrcounter
    .clk (clk),
    .rst (rst),
    .en (en),
    .offset (offset),
    .incr (incr),
    .count (addr1), // left has the internal signals, right has the external signals
    .count_off (addr2)
    // which the whole module can see
);

rom2ports sineRom ( // initialise the rom module called sinerom
    .clk (clk),
    .addr1 (addr1),
    .addr2 (addr2),
    .dout1 (dout1),
    .dout2 (dout2)
);
endmodule
