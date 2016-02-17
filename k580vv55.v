// ====================================================================
//                Bashkiria-2M FPGA REPLICA
//
//            Copyright (C) 2010 Dmitry Tselikov
//
// This core is distributed under modified BSD license. 
// For complete licensing information see LICENSE.TXT.
// -------------------------------------------------------------------- 
//
// An open implementation of Bashkiria-2M home computer
//
// Author: Dmitry Tselikov   http://bashkiria-2m.narod.ru/
// 
// Design File: k580vv55.v
//
// Parallel interface k580vv55 design file of Bashkiria-2M replica.
//
// Warning: This realization is not fully operational.

module k580vv55
(
	input           clk, 
	input           reset, 
	input     [1:0] addr, 
	input           we_n,
	input     [7:0] idata, 
	output    [7:0] odata,
	input     [7:0] ipa, 
	output reg[7:0] opa,
	input     [7:0] ipb, 
	output reg[7:0] opb,
	input     [7:0] ipc, 
	output reg[7:0] opc
);

//reg[6:0] mode;

assign odata = (addr == 0) ? ipa :
               (addr == 1) ? ipb :
               (addr == 2) ? ipc : 8'd0;


always @(posedge clk or posedge reset) begin
	if (reset) begin
		//mode <= 7'b0011011;
		{opa,opb,opc} <= {8'hFF,8'hFF,8'hFF};
	end else
	if (~we_n) begin
		if (addr==2'b00) opa <= idata;
		if (addr==2'b01) opb <= idata;
		if (addr==2'b10) opc <= idata;
		//if (addr==2'b11 &&  idata[7]) mode <= idata[6:0];
		if (addr==2'b11 && ~idata[7]) opc[idata[3:1]] <= idata[0];
	end
end

endmodule
