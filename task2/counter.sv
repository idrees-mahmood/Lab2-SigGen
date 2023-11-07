module counter #(
    parameter  WIDTH = 8
)(
    // interface signals
    input logic clk, //clock
    input logic rst, //reset
    input logic en, //counter enable
    input logic[WIDTH-1:0] incr, //increment value
    input logic[WIDTH-1:0] offset, //offset value
    output logic [WIDTH-1:0] count, //counter output
    output logic [WIDTH-1:0] count_off //counter output
);

always_ff @ (posedge clk)
    if (rst) count <= {WIDTH{1'b0}};
    else if (en) begin
        count <= count + incr;
        $display("Count" , count);
        count_off <= count + offset;
        $display("Offset" , count_off);
    end
    else count <= count;

endmodule
