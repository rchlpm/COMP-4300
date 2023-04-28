entity mux is
	generic(prop_delay : Time := 5 ns);
	port (
		input_1,input_0 : in dlx_word;
		which: in bit;
		output: out dlx_word
	);
end entity mux;