`timescale 1ps / 1ps


module tb_top;

  reg                   clk_i;
  reg                   rst_n_i;
  wire                  sclk_o;

  main_module main (
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .sclk_o(sclk_o)
  );

  derived_module derived (
      // .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .sclk_i(sclk_o)
  );

  // Generate Clock
  initial begin
    clk_i = 0;
    forever #5 clk_i = ~clk_i;
  end

  initial begin
    $dumpfile("top_wave.vcd");
    $dumpvars(0, tb_top);

    // Initialize signals
    clk_i            = 0;
    rst_n_i          = 0;

    // Reset
    #20 rst_n_i = 1;


    // Finish simulation
    #400 $finish;
  end

endmodule

