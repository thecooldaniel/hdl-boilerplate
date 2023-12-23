`timescale 1ns / 1ps

module boilerplate_tb;

  // Parameters
  localparam int PARAM1 = 10;
  localparam int PARAM2 = 20;

  // Signals
  logic clk;
  logic reset;
  logic [PARAM1-1:0] in;
  logic [PARAM2-1:0] out;

  // Instance of the boilerplate module
  boilerplate #(
      .PARAM1(PARAM1),
      .PARAM2(PARAM2)
  ) uut (
      .clk(clk),
      .reset(reset),
      .in(in),
      .out(out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Clock period of 10 ns
  end

  // Test sequence
  initial begin
    // Initialize inputs
    reset = 1;
    in = 0;

    // Apply reset
    #10 reset = 0;
    #10 reset = 1;

    // Stimulus
    @(posedge clk);
    in = 123;  // Example input

    @(posedge clk);
    in = 456;  // Another example input

    // Add more test cases as needed
  end

  initial begin
    // Finish simulation
    #100 $finish;
  end

  // Monitor changes
  initial begin
    $monitor($time, " ns -- clk: %b, reset: %b, in: %0d, out: %0d", clk, reset, in, out);
  end

endmodule
