`timescale 1ns / 1ps

module MuxData(Output, Input0, Input1,Selector);
    output reg [31:0] Output;
    input [31:0] Input0, Input1;
    input [0:0] Selector;
    
    initial begin
        Output=32'd0;
    end 
	 
    always @ (Input0 or Input1 or Selector) begin
        case (Selector)
            0: Output = Input0;
            1: Output = Input1;
			default:Output =32'd0;
        endcase
    end
endmodule