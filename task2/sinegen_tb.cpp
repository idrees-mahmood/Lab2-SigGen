#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"

#include "vbuddy.cpp" // Vbuddy functions
#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main (int argc, char **argv, char **env) {
    int simcycle = 0;
    int tick = 0;


    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen *top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");

    // init Vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader("Lab 2.1: sinegen");
    //vbdSetMode(1); //Vbd flag in one shot mode

    // intialise simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1;

    for (simcycle = 0; simcycle < MAX_SIM_CYC; simcycle++) {
        // dump variables into VCD file and toggle clock
        for (tick = 0; tick < 2; tick++) {
            tfp -> dump(2*simcycle+tick); // unit is in ps (periods)
            top -> clk = !top -> clk;
            top -> eval();
        }
        
        top -> offset = vbdValue();
        top -> incr = 2; // gets a full waveform on the screen
        // plot ROM output and print cycle count
        vbdPlot (int (top->dout1), 0, 255);
        vbdPlot (int (top->dout2), 0, 255);
        vbdCycle(simcycle);
        
        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey() == 'q')) exit(0);

    }
    vbdClose();
    tfp->close();
    exit(0);
}