module vending(clk,rst,i,sel,seg_money,seg_product);
input clk, rst;
input [2:0] i;
input [3:0] sel; 
output reg [0:6] seg_money;
output reg [0:6] seg_product;

parameter A = 3'b000;
parameter SMALL = 3'b001;
parameter MEDIUM = 3'b010;
parameter LARGE = 3'b011;
parameter DISPENSE = 3'b100;
reg [2:0] cs, ns;
reg [2:0] money_display;


always @(*) begin
ns = cs;
seg_money = 7'b1111111;
seg_product = 7'b1111111;
case (cs)
A: begin
case (i)
3'b001: ns = SMALL;
3'b010: ns = MEDIUM;
3'b100: ns = LARGE;
default: ns = A;
endcase
end
SMALL: begin
case (sel)
4'b0001: seg_product = 7'b0001000;
4'b0010: seg_product = 7'b0110000;
4'b0100: seg_product = 7'b0110110;
4'b1000: seg_product = 7'b0111000;
default: seg_product = 7'b1111111;
endcase
money_display = 3'b001;
ns = DISPENSE;
end
MEDIUM: begin
case (sel)
4'b0001: seg_product = 7'b0001000;
4'b0010: seg_product = 7'b0110000;
4'b0100: seg_product = 7'b0110110;
4'b1000: seg_product = 7'b0111000;
default: seg_product = 7'b1111111;
endcase
money_display = 3'b010;
ns = DISPENSE;
end
LARGE: begin
case (sel)
4'b0001: seg_product = 7'b0001000;
4'b0010: seg_product = 7'b0110000;
4'b0100: seg_product = 7'b0110110;
4'b1000: seg_product = 7'b0111000;
default: seg_product = 7'b1111111;
endcase
money_display = 3'b100;
ns = DISPENSE;
end
DISPENSE: begin
ns = A;
end
endcase
end

always @(posedge clk or posedge rst) begin
if (rst) 
cs <= A;
else 
cs <= ns;
end

always @(money_display) begin
case (money_display)
3'b001: seg_money = 7'b0010010;
3'b010: seg_money = 7'b1001100;
3'b100: seg_money = 7'b0100000;
default: seg_money = 7'b1111111;
endcase
end
endmodule

