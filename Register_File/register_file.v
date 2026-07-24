`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 04:36:13 PM
// Design Name: 
// Module Name: register
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


module register_file(
    input clk,
    input rst,
    input we,
    input [2:0]waddr,
    input [7:0]wdata,
    input [2:0]raddr1,
    input [2:0]raddr2,
    output [7:0]rdata1,
    output [7:0]rdata2  );
    reg [7:0]regs[0:7];
    integer i;//loop variable
    always @(posedge clk)begin//write operation
    if (rst)begin//reset condition
   for (i=0;i<8;i=i+1)
    begin
    regs[i]<=8'd0;
    end
    end
    else if (we)
    begin
    regs[waddr]<=wdata;
    end
    end
    //write before read
   assign rdata1=regs[raddr1];//read operation
   assign rdata2=regs[raddr2];//read operation

endmodule
