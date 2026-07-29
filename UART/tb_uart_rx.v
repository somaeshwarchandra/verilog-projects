`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2026 05:25:41 PM
// Design Name: 
// Module Name: tb_uart_rx
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


module tb_uart_rx();
reg clk;
reg rst; 
reg rx;

wire [7:0] rx_data;
wire rx_done;

uart_rx #(.CLOCK_FREQ(100),.BAUD_RATE(10)) dut(
.clk(clk),
.rst(rst), 
.rx(rx),
.rx_data(rx_data),
.rx_done(rx_done)
);

always #5 clk=~clk;//clock generatioin

task uart_send_byte;
input [7:0]data;
integer i;
begin
rx=0;
#(dut.CLKS_PER_BIT*10);
for (i=0;i<8;i=i+1)
begin
rx=data[i];
#(dut.CLKS_PER_BIT*10);
end
rx=1;
#(dut.CLKS_PER_BIT*10);

end
endtask

initial
begin
clk=0;rst=1;rx=1;
#20;
rst=0;
uart_send_byte(8'hAA);
uart_send_byte(8'h55);
uart_send_byte(8'h34);
$finish;
end

always@(posedge rx_done)
begin
$display("Received=%0h",rx_data);
end
endmodule
