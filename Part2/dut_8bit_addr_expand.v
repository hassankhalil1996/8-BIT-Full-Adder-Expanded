// 8 bit full adder module "expanded- part 2" 
module dut_8bit_addr_expand(
	input clk ,
	input reset_n ,
	input wire Data_val ,
 	input wire [7:0] Value_a ,
	input wire [7:0] Value_b ,
	input wire  c_in , 

	// interface inputs (for expand part)	
	input [2:0] Des_address ,
	input [7:0] Des_value ,
	input Des_req_valid ,
	input Des_wr_rd ,

	
	output reg [7:0] Sum_result , 
	output reg Sum_carry ,
	output reg Data_ready,

	// interface output (for expand part)
	output reg [7:0] Des_rd_value  
	);

// regesters to sample the inputs
reg Data_val_reg ;
reg c_in_reg ;
reg [7:0] Value_a_reg ;
reg [7:0] Value_b_reg ;

// wires in first 8bit module
wire [6:0] c_net;
wire [7:0] sum;    
wire Sum_carry_wire;
wire Data_val_wire;
//////////////


// wires in secound 8bit module 
wire [6:0] c_net2;
wire [7:0] sum2;    
wire Sum_carry_wire2;
//wire Data_val_wire2;

// regesters to sample the output of the modulw
reg [7:0] Sum_result_reg_out ; 
reg Sum_carry_reg_out ;
reg Data_ready_reg_out ;


// this registers to hold the 3 expand registers value ... 
reg [7:0] control_register ;
reg [7:0] offset_value ;     
reg [7:0] general_purpose ;


		// 8bit full adder first instant to add value_a + value_b  
                one_bit_full_adder first_inst(.a(Value_a_reg[0]), .b(Value_b_reg[0]), .c_in(c_in), .sum(sum[0]), .c_out(c_net[0]));
                one_bit_full_adder second_inst(.a(Value_a_reg[1]), .b(Value_b_reg[1]), .c_in(c_net[0]), .sum(sum[1]), .c_out(c_net[1]));
                one_bit_full_adder third_inst(.a(Value_a_reg[2]), .b(Value_b_reg[2]), .c_in(c_net[1]), .sum(sum[2]), .c_out(c_net[2]));
                one_bit_full_adder fourth_inst(.a(Value_a_reg[3]), .b(Value_b_reg[3]), .c_in(c_net[2]), .sum(sum[3]), .c_out(c_net[3]));
                one_bit_full_adder fifth_inst(.a(Value_a_reg[4]), .b(Value_b_reg[4]), .c_in(c_net[3]), .sum(sum[4]), .c_out(c_net[4]));
                one_bit_full_adder sixth_inst(.a(Value_a_reg[5]), .b(Value_b_reg[5]), .c_in(c_net[4]), .sum(sum[5]), .c_out(c_net[5]));
                one_bit_full_adder seventh_inst(.a(Value_a_reg[6]),.b(Value_b_reg[6]), .c_in(c_net[5]), .sum(sum[6]), .c_out(c_net[6]));
                one_bit_full_adder eighth_inst(.a(Value_a_reg[7]), .b(Value_b_reg[7]), .c_in(c_net[6]), .sum(sum[7]), .c_out(Sum_carry_wire));


		// 8bit full adder second instant to add (value_a+value_b) + offset_reg value
                one_bit_full_adder first_inst_expand(.a(sum[0]), .b(offset_value[0]), .c_in(Sum_carry_wire), .sum(sum2[0]), .c_out(c_net2[0]));
                one_bit_full_adder second_inst_expand(.a(sum[1]), .b(offset_value[1]), .c_in(c_net2[0]), .sum(sum2[1]), .c_out(c_net2[1]));
                one_bit_full_adder third_inst_expand(.a(sum[2]), .b(offset_value[2]), .c_in(c_net2[1]), .sum(sum2[2]), .c_out(c_net2[2]));
                one_bit_full_adder fourth_inst_expand(.a(sum[3]), .b(offset_value[3]), .c_in(c_net2[2]), .sum(sum2[3]), .c_out(c_net2[3]));
                one_bit_full_adder fifth_inst_expand(.a(sum[4]), .b(offset_value[4]), .c_in(c_net2[3]), .sum(sum2[4]), .c_out(c_net2[4]));
                one_bit_full_adder sixth_inst_expand(.a(sum[5]), .b(offset_value[5]), .c_in(c_net2[4]), .sum(sum2[5]), .c_out(c_net2[5]));
                one_bit_full_adder seventh_inst_expand(.a(sum[6]),.b(offset_value[6]), .c_in(c_net2[5]), .sum(sum2[6]), .c_out(c_net2[6]));
                one_bit_full_adder eighth_inst_expand(.a(sum[7]), .b(offset_value[7]), .c_in(c_net2[6]), .sum(sum2[7]), .c_out(Sum_carry_wire2));

		assign Data_val_wire = Data_val_reg ;



always @(posedge clk or negedge reset_n  ) begin
  if (!reset_n) begin // if reset is sown to zero .. reset all levels of regester to zero
	c_in_reg <= 1'b0;
	Value_a_reg <= 8'b00000000;
        Value_b_reg <= 8'b00000000; 
	Data_val_reg <= 1'b0;

	Sum_result_reg_out <= 8'b00000000 ;
	Sum_carry_reg_out <=  1'b0 ;
	Data_ready_reg_out <= 1'b0 ;

        Sum_result <= 8'b00000000;
        Sum_carry <=  1'b0;
	Data_ready <= 1'b0;
      
   end  
   else if(!Data_val) begin // id data_val = 0 just down to zero the input vals
	Data_val_reg <= 1'b0;
	c_in_reg <= 1'b0;
	Value_a_reg <= 8'b00000000;
	Value_b_reg <= 8'b00000000;
        
	Sum_result_reg_out <= sum ;
	Sum_carry_reg_out <=  Sum_carry_wire ;
	Data_ready_reg_out <= Data_val_wire ;

        Sum_result <= Sum_result_reg_out;
        Sum_carry <=  Sum_carry_reg_out;
	Data_ready <= Data_ready_reg_out;

   end else if(!Des_req_valid) begin // if Des_req_valid =0 , interface not a part .. no transaction is made so the output is the sum of val_a and val_b
	Data_val_reg <= Data_val;
	c_in_reg <= c_in;
	Value_a_reg <= Value_a;
	Value_b_reg <= Value_b;

	Sum_result_reg_out <= sum ;
	Sum_carry_reg_out <=  Sum_carry_wire ;
	Data_ready_reg_out <= Data_val_wire ;


	Sum_result <= Sum_result_reg_out ;
	Sum_carry <= Sum_carry_reg_out ;
	Data_ready <= Data_ready_reg_out;
	      
	   
   end else begin // Des_req_valid == 1 .. nterface is a part of calculation ... check if read or write transaction ..
		if(Des_wr_rd)begin  // Write transaction .. write for the des_address + write to general_purpose reg that his value stored in any write
			case(Des_address)
				3'b000 : begin
						control_register <= Des_value ;
						general_purpose <= Des_value ;
					end
				3'b001 : begin
						offset_value <= Des_value ;
						general_purpose <= Des_value ;
					end
				3'b010: begin
						general_purpose <= Des_value ;
					end
				default : ; // dont do anything (bad address)
			endcase
				
		end 
		else begin     // Read transaction 
			case(Des_address)
				3'b000 : begin
						Des_rd_value <= control_register ;
					end
				3'b001 : begin
						Des_rd_value <= offset_value ;
					end
				3'b010 :begin
						Des_rd_value <= general_purpose ;
					end
				default : ; // dont do anything (bad address)
			endcase 		
  		end 
	end  
	
	// determind to add offset or not according to control_register[0] value
	if( control_register[0] == 1 &&  Des_req_valid == 1'b1 )begin  // if control_register[0] == 1 and its a transacion then calculate (val_a + val_b ) + offset_val in second instanse and take the sum to output
		Data_val_reg <= Data_val;
	   	c_in_reg <= c_in;
	   	Value_a_reg <= Value_a;
	   	Value_b_reg <= Value_b;

		Sum_result_reg_out <= sum2 ;
		Sum_carry_reg_out <= Sum_carry_wire2 | Sum_carry_wire ; 
		Data_ready_reg_out <= Data_val_wire ;

	   	Sum_result <= Sum_result_reg_out ;
	   	Sum_carry <=  Sum_carry_reg_out;
	  	Data_ready <= Data_ready_reg_out;
		
	end else begin // take just the val_a + val_b to the output
		Data_val_reg <= Data_val;
		c_in_reg <= c_in;
	   	Value_a_reg <= Value_a;
	   	Value_b_reg <= Value_b;
	
		Sum_result_reg_out <= sum ;
		Sum_carry_reg_out <=  Sum_carry_wire ;
		Data_ready_reg_out <= Data_val_wire ;
	   	
		Sum_result <= Sum_result_reg_out ;
		Sum_carry <= Sum_carry_reg_out ;
		Data_ready <= Data_ready_reg_out ;
   	end
end 

endmodule