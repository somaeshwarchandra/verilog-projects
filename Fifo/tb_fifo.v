`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 10:36:53 PM
// Design Name: 
// Module Name: tb_fifo
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


module tb_fifo();
reg clk;
reg rst;
reg rd_en;
reg wr_en;
reg[7:0]data_in;
wire full;
wire empty;
wire [7:0]data_out;
fifo dut(
.clk(clk),
.rst(rst),
.rd_en(rd_en),
.wr_en(wr_en),
.data_in(data_in),
.full(full),
.empty(empty),
.data_out(data_out)
);
always #5 clk=~clk;//clock generation
initial begin
clk=0;wr_en=0;rd_en=0;data_in=8'h11;rst=1;//reset
#10;

rst=0;wr_en=1;
#10;

data_in=8'h22;wr_en=1;
#10;

data_in=8'h33;wr_en=1;
#10;

data_in=8'h44;wr_en=1;
#10;

data_in=8'h55;wr_en=1;
#10;

wr_en=0;rd_en=1;
#10;

rd_en=1;
#10;

wr_en=1;data_in=8'h77;rd_en=1;
#10;

wr_en=0;
repeat(4)
begin
#10;
end
$finish;
end
initial begin//monitoring signals
$monitor("t=%0t rst=%0d wr_en=%0d data_in=%0h rd_en=%0d data_out=%0h count=%0d wptr=%0d rptr=%0d full=%0d empty=%0d",$time,rst,wr_en,data_in,rd_en,data_out,dut.count,dut.wr_ptr,dut.rd_ptr,full,empty);
end
endmodule
