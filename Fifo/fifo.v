`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 09:54:19 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
input clk,
input rst,
input rd_en,
input wr_en,
input[7:0]data_in,

output full,
output empty,
output reg [7:0]data_out
);
parameter DEPTH=4;//can be changed if required
reg [7:0]mem[0:DEPTH-1];
reg [$clog2(DEPTH)-1:0]rd_ptr;
reg [$clog2(DEPTH)-1:0]wr_ptr;
reg [$clog2(DEPTH+1)-1:0]count;
integer i;
wire write_ok;
wire read_ok;
assign write_ok = wr_en && !full;
assign read_ok  = rd_en && !empty;
always @(posedge clk)
begin
if (rst)
begin
for (i=0;i<DEPTH;i=i+1)//reset
begin
mem[i]<=8'd0;
end
count<=0;
rd_ptr<=0;
wr_ptr<=0;
data_out<=8'd0;
end

else 
begin
if(write_ok)//fifo write
begin
mem[wr_ptr]<=data_in;
wr_ptr<=wr_ptr+1;
end

if(read_ok)//fifo read
begin
data_out<=mem[rd_ptr];
rd_ptr<=rd_ptr+1;
end

if(write_ok&&(!read_ok))//count variations (used write_ok and read_ok to cover full and empty corner cases)
begin
count<=count+1;
end
else if(read_ok&&(!write_ok))
begin
count<=count-1;
end
end
end
assign full=(count==DEPTH);//fifo full signal generation
assign empty=(count==0);//fifo empty signal generation
endmodule
