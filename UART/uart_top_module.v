`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2026 07:14:32 PM
// Design Name: 
// Module Name: uart_top_module
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


module uart_top_module #(parameter CLOCK_FREQ=100000000,parameter BAUD_RATE=9600)(
input clk,
input rst,
input tx_start,
input [7:0]tx_data,
input rx,

output tx,
output tx_done,
output tx_busy,
output rx_done,
output [7:0]rx_data

    );
    
    uart_tx #(.CLOCK_FREQ(CLOCK_FREQ),.BAUD_RATE(BAUD_RATE))uut1(
 .clk(clk),
.rst(rst),
.data_in(tx_data),
.tx_start(tx_start),
.tx(tx),
.tx_busy(tx_busy),
.tx_done(tx_done)
    );
    
    
uart_rx #(.CLOCK_FREQ(CLOCK_FREQ),.BAUD_RATE(BAUD_RATE)) uut2(
.clk(clk),
.rst(rst), 
.rx(rx),
.rx_data(rx_data),
.rx_done(rx_done)
);

endmodule
