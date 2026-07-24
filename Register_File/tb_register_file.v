`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 05:20:37 PM
// Design Name: 
// Module Name: tb_register_file
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


module tb_register_file();
    reg clk;
    reg rst;
    reg we;
    reg [2:0]waddr;
    reg [7:0]wdata;
    reg [2:0]raddr1;
    reg [2:0]raddr2;
    wire [7:0]rdata1;
    wire [7:0]rdata2;
register_file dut(
.clk(clk),
.rst(rst),
.we(we),
.waddr(waddr),
.wdata(wdata),
.raddr1(raddr1),
.raddr2(raddr2),
.rdata1(rdata1),
.rdata2(rdata2));
always #5 clk=~clk;
initial begin
    clk=0;
    rst = 1;
    we = 0;
    waddr = 0;
    wdata = 0;
    raddr1 = 0;
    raddr2 = 0;
#10;
rst=0;
waddr=3'd0;//writing 25 to reg0
we=1;
wdata=8'd25;
raddr1=3'd0;
raddr2=3'd5;
#10;

waddr=3'd5;//writing 100 to reg5
we=1;
wdata=8'd100;
raddr1=3'd0;
raddr2=3'd5;
#10;

we=0;//disable writing
waddr=3'd4;
wdata=8'd55;
raddr1=3'd4;
#10;

raddr1=3'd0;//reading 2 regs at same time
raddr2=3'd5;
#10;
$finish;
end
initial begin 
$monitor("t=%0t rst=%0d we=%0d waddr=%0d wdata=%0d raddr1=%0d rdata1=%0d raddr2=%0d rdata2=%0d",$time,rst,we,waddr,wdata,raddr1,rdata1,raddr2,rdata2);
end
endmodule
