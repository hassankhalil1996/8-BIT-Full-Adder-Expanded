//One bit full adder module
// This module used to build 8 bit full adder as requested
module one_bit_full_adder(a,b,c_in,sum,c_out);
	input a , b , c_in ;
	output   sum , c_out ;

	assign sum = a ^ b ^ c_in ;
	assign c_out = (a & b) | ((a^b)&c_in) ;

endmodule
