`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2026 08:55:19 PM
// Design Name: 
// Module Name: tb_uart_top_module
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


module tb_uart_top_module();
reg clk;
reg rst;
reg tx_start;
reg [7:0]tx_data;
//reg rx;

//wire tx;
wire tx_done;
wire tx_busy;
wire rx_done;
wire [7:0]rx_data;
wire serial_line;


uart_top_module #(.CLOCK_FREQ(100),.BAUD_RATE(10)) uut(
.clk(clk),
.rst(rst),
.tx_start(tx_start),
.tx_data(tx_data),
.rx(serial_line),
.tx(serial_line),
.tx_done(tx_done),
.tx_busy(tx_busy),
.rx_done(rx_done),
.rx_data(rx_data)
);
always #5 clk=~clk;

task send_byte;
input [7:0]data;
begin
tx_data=data;
tx_start=1;
@(posedge clk);
#1;
tx_start=0;
@(posedge tx_done);

end
endtask
initial begin
clk=0;rst=1;tx_start=0;tx_data=0;
#20;
rst=0;
send_byte(8'hFF);
send_byte(8'hAB);
$finish;
end

always @(posedge rx_done)
begin
$display("Received=%0h",rx_data);
end
endmodule
