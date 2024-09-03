`timescale 1ps / 1ps

module main_module (
    input  logic clk_i,    // System clock
    input  logic rst_n_i,  // Active low reset
    output logic sclk_o    // SPI clock
);


  logic [2:0] r_bit_cnt;  // Bit counter
  logic       r_waiting;

  always_ff @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      r_bit_cnt <= 7;
      r_waiting <= 1;
    end else begin
      if (r_bit_cnt == 0) begin
        r_bit_cnt <= 7;  // Reset bit counter
        r_waiting <= ~(r_waiting);
      end else begin
        r_bit_cnt <= r_bit_cnt - 1;
      end
    end
  end

  assign sclk_o = r_waiting == 0 ? clk_i : 0;

endmodule

