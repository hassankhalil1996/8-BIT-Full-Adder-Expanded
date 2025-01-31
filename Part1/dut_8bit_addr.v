// 8 bit full adder module
module dut_8bit_addr(
	input clk,
	input reset_n,
	input wire Data_val,
 	input wire [7:0] Value_a ,
	input wire [7:0] Value_b,
	input wire  c_in,
 
	output reg [7:0] Sum_result , 
	output reg Sum_carry ,
	output reg Data_ready   
	);
 

	// These registers are added to sample the values ??at the input before entering 8 bit full adder module. 
	reg Data_val_reg ;
	reg c_in_reg ;
	reg [7:0] Value_a_reg ;
	reg [7:0] Value_b_reg ;

	// This registers are added to sample the output befor they sapmled at the output of the module
	reg [7:0] sum_reg_out ;
	reg Sum_carry_red_out ;
	reg Data_val_reg_out ;

	// wires to conect the small one bit full adder modules in otder to git 8 bit full adder module
	wire [6:0] c_net;
	wire [7:0] sum;    
	wire Sum_carry_wire;
	wire Data_val_wire ;

		// using 8 modules and connect them in way to get 8_bit_full_adder module behaviour
                one_bit_full_adder first_inst(.a(Value_a_reg[0]), .b(Value_b_reg[0]), .c_in(c_in_reg), .sum(sum[0]), .c_out(c_net[0]));
                one_bit_full_adder second_inst(.a(Value_a_reg[1]), .b(Value_b_reg[1]), .c_in(c_net[0]), .sum(sum[1]), .c_out(c_net[1]));
                one_bit_full_adder third_inst(.a(Value_a_reg[2]), .b(Value_b_reg[2]), .c_in(c_net[1]), .sum(sum[2]), .c_out(c_net[2]));
                one_bit_full_adder fourth_inst(.a(Value_a_reg[3]), .b(Value_b_reg[3]), .c_in(c_net[2]), .sum(sum[3]), .c_out(c_net[3]));
                one_bit_full_adder fifth_inst(.a(Value_a_reg[4]), .b(Value_b_reg[4]), .c_in(c_net[3]), .sum(sum[4]), .c_out(c_net[4]));
                one_bit_full_adder sixth_inst(.a(Value_a_reg[5]), .b(Value_b_reg[5]), .c_in(c_net[4]), .sum(sum[5]), .c_out(c_net[5]));
                one_bit_full_adder seventh_inst(.a(Value_a_reg[6]),.b(Value_b_reg[6]), .c_in(c_net[5]), .sum(sum[6]), .c_out(c_net[6]));
                one_bit_full_adder eighth_inst(.a(Value_a_reg[7]), .b(Value_b_reg[7]), .c_in(c_net[6]), .sum(sum[7]), .c_out(Sum_carry_wire));

		assign Data_val_wire = Data_val_reg ;


always @(posedge clk or negedge reset_n ) 
begin
   if (!reset_n) begin  // if reset then reset all regs and wires to zero 
        Data_val_reg <= 1'b0;
	c_in_reg <= 1'b0;
        Value_a_reg <= 8'b00000000;
        Value_b_reg <= 8'b00000000;

	sum_reg_out <= 8'b00000000 ;
	Sum_carry_red_out <= 1'b0 ;
	Data_val_reg_out <= 1'b0;

        Sum_result <= 8'b00000000 ;
        Sum_carry <= 1'b0 ;
	Data_ready <= 1'b0 ;

   end else if (!Data_val) begin // if Data_val =0 then the input not valed and reset just the val_a and val_b to zero with Data_val =0  

	Data_val_reg <= 1'b0;
	c_in_reg <= 1'b0;
	Value_a_reg <= 8'b00000000;
	Value_b_reg <= 8'b00000000;
        
	sum_reg_out <= sum ;
	Sum_carry_red_out <= Sum_carry_wire ;
	Data_val_reg_out <= Data_val_wire;

	Sum_result <= sum_reg_out ;
	Sum_carry <= Sum_carry_red_out ;
	Data_ready <= Data_val_reg_out; 

   end else begin
	// sampling the input to in regs
	Data_val_reg <= Data_val;
	c_in_reg <=  c_in;
	Value_a_reg <= Value_a;
	Value_b_reg <= Value_b;

	// sampling the output to out regs 
	sum_reg_out <= sum ;
	Sum_carry_red_out <= Sum_carry_wire ;
	Data_val_reg_out <= Data_val_wire;

	// update the output pf the module 
	Sum_result <= sum_reg_out ;
	Sum_carry <= Sum_carry_red_out ;
	Data_ready <= Data_val_reg_out;  
	
   end
end

endmodule
