// =============================================================================
// Module      : tb_fir_filter (Testbench)
// Description : Testbench for the 8th-order FIR Low-Pass Filter.
//               Reads 32 binary input samples from 'signal.data' into RAM,
//               feeds them clock-synchronously to the DUT, and observes
//               filtered output on data_out.
//
//               How to use:
//               1. Run signal_gen.m in MATLAB to generate signal.data
//               2. Place signal.data in the Vivado simulation working directory
//               3. Set this file as the top simulation module in Vivado
//               4. Run Behavioral Simulation and observe waveforms
//
// Author      : Hari Kumar (2022UGEC018)
// Institute   : NIT Jamshedpur
// =============================================================================

`timescale 1ns / 1ps

module tb_fir_filter();

    // -------------------------------------------------------------------------
    // Parameters
    // -------------------------------------------------------------------------
    parameter N = 16;          // Data width
    parameter NUM_SAMPLES = 32; // Number of input samples in signal.data

    // -------------------------------------------------------------------------
    // Testbench signals
    // -------------------------------------------------------------------------
    reg                  clk;
    reg                  reset;
    reg  signed [N-1:0]  data_in;
    wire signed [N-1:0]  data_out;

    // -------------------------------------------------------------------------
    // DUT instantiation
    // -------------------------------------------------------------------------
    fir_filter dut (
        .clk      (clk),
        .reset    (reset),
        .data_in  (data_in),
        .data_out (data_out)
    );

    // -------------------------------------------------------------------------
    // RAM: stores binary input signal loaded from signal.data
    // -------------------------------------------------------------------------
    reg [N-1:0] RAMM [NUM_SAMPLES-1:0];

    initial begin
        $readmemb("signal.data", RAMM);
    end

    // -------------------------------------------------------------------------
    // Clock generation: 10 ns period (100 MHz)
    // -------------------------------------------------------------------------
    initial clk = 0;
    always #10 clk = ~clk;

    // -------------------------------------------------------------------------
    // Reset: assert for first 2 clock cycles
    // -------------------------------------------------------------------------
    initial begin
        reset = 1;
        #40;
        reset = 0;
    end

    // -------------------------------------------------------------------------
    // Address counter: cycles through 0 to NUM_SAMPLES-1
    // -------------------------------------------------------------------------
    reg [5:0] Address;

    initial Address = 0;

    always @(posedge clk) begin
        if (Address == NUM_SAMPLES - 1)
            Address <= 0;
        else
            Address <= Address + 1;
    end

    // -------------------------------------------------------------------------
    // Feed RAM data into DUT input
    // -------------------------------------------------------------------------
    always @(posedge clk) begin
        data_in <= RAMM[Address];
    end

    // -------------------------------------------------------------------------
    // Simulation end condition
    // -------------------------------------------------------------------------
    initial begin
        #50000;
        $display("Simulation complete.");
        $finish;
    end

    // -------------------------------------------------------------------------
    // Waveform dump (for GTKWave or Vivado waveform viewer)
    // -------------------------------------------------------------------------
    initial begin
        $dumpfile("fir_filter_sim.vcd");
        $dumpvars(0, tb_fir_filter);
    end

endmodule
