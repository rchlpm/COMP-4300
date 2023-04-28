entity pcplusone is
generic(prop_delay: Time := 5 ns);
port (input: in dlx_word; clock: in bit; output: out dlx_word);
end entity pcplusone;

architecture rtl of pcplusone is
  signal incremented_value : dlx_word;
begin
  process(clock)
  begin
    if rising_edge(clock) then
      incremented_value <= input + 1;
    end if;
  end process;
  output <= incremented_value;
end architecture rtl;
