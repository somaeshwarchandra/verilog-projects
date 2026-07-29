`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 04:40:28 PM
// Design Name: 
// Module Name: tb_uart_tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//=========================================================
// UART Transmitter Testbench
//
// Instructions:
// 1. Launch Behavioral Simulation.
// 2. Click "Run All".
// 3. The testbench automatically ends with $finish.
//
// NOTE:
// A fixed "Run 1000 ns" stops before the first transmission
// completes, so use "Run All".
//=========================================================
module tb_uart_tx(
);
reg clk;
reg rst;
reg [7:0]data_in;
reg tx_start;

wire tx;
wire tx_busy;
wire tx_done;
uart_tx #(.CLOCK_FREQ(100),
.BAUD_RATE(10)) dut(
.clk(clk),
.rst(rst),
.data_in(data_in),
.tx_start(tx_start),
.tx(tx),
.tx_busy(tx_busy),
.tx_done(tx_done)
);

always #5 clk=~clk;//10ns=100MHZ

initial begin
clk=0;rst=1;tx_start=0;data_in=0;
#20;
rst=0;
data_in=8'hA5;
tx_start=1;
#10;
tx_start=0;
@(posedge tx_done);
data_in=8'h55;
tx_start=1;
#10;
tx_start=0;
#50;
data_in=8'hFF;
tx_start=1;
#10;
tx_start=0;
@(posedge tx_done);
#100;
$finish;
end

initial begin
$monitor(
"t=%0t clk=%0d rst=%0d data_in=%0h tx_start=%0d tx=%0d tx_busy=%0d tx_done=%0d state=%0d baud_count=%0d bit_count=%0d "
,$time,clk,rst,data_in,tx_start,tx,tx_busy,tx_done,dut.state,dut.baud_count,dut.bit_count
);
end
always @(posedge tx_done)
begin
    $display("Transmission completed at time %0t", $time);
end
endmodule
