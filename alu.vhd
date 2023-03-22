library ieee;
USE work.dlx_types.ALL;
USE work.bv_arithmetic.ALL;


entity alu is
    generic(prop_delay: time := 15 ns);
    port(
        operand1,
        operand2 : in dlx_word;
        operation : in alu_operation_code;
        result : out dlx_word;
        error : out error_code);

end entity alu;

architecture unit of alu is
 
begin
    
    alu: process(op1, op2, operation) is
    
        variable overflow : boolean := false;
        variable operation_result : dlx_word;
        variable div_by_zero: boolean;
    
begin
        error <= "0000";
        case(operation) is
            when "0000" => 
                bv_addu(op1, op2, operation_result, overflow);
                if overflow then
                    error <= "0001" after prop_delay;
                end if;
                result <= operation_result after prop_delay;

            when "0001" => 
                bv_subu(operand1, operand2, operation_result, overflow);
                if overflow then
                    error <= "0010" after prop_delay;
                end if;
                result <= operation_result after prop_delay;

            when "0010" => 
                bv_add(op1, op2, operation_result, overflow);
                if overflow then
                    if op1(31) = '0' AND op2(31) = '0' then
                        error <= "0001" after prop_delay;
                    else
                        error <= "0010" after prop_delay;
                    end if;
                end if;
                result <= operation_result after prop_delay;
                        
            when "0011" => 
                bv_sub(op1, op2, operation_result, overflow);
                if overflow then
                    if operand1(31) = '0' then
                        error <= "0001" after prop_delay;
                    else
                        error <= "0010" after prop_delay;
                    end if;
                end if;
                result <= operation_result after prop_delay;
                        
            when "0100" => -- 
                bv_mult(op1, op2, operation_result, overflow);
                if overflow then
                    if op1(31) = op2(31) then
                        error <= "0001" after prop_delay;
                    else
                        error <= "0010" after prop_delay;
                    end if;
                end if;
                result <= operation_result after prop_delay;
                        
            when "0101" => 
                bv_div(op1, op2, operation_result, div_by_zero, overflow);
                if div_by_zero then
                    error <= "0011" after prop_delay;
                end if;
                result <= operation_result after prop_delay;
                    
            when "0110" => -- 
                if op1 /= x"00000000" AND op2 /= x"00000000" then
                    result <= x"00000001" after prop_delay;
                else
                    result <= x"00000000" after prop_delay;
                    
                end if;
                    
            when "0111" => --  
                result <= operand1 AND operand2 after prop_delay;
                    
            when "1000" => --  OR
                if op1 /= x"00000000" OR op2 /= x"00000000" then
                    result <= x"00000001" after prop_delay;
                else
                    result <= x"00000000" after prop_delay;
                end if;
                    
            when "1001" => --  
                result <= op1 OR op2 after prop_delay;
            when "1010" => --  
                if op1 /= x"00000000" then
                    result <= x"00000001" after prop_delay;
                else
                    result <= x"00000000" after prop_delay;
                end if;
                    
            when "1011" => -- 
                result <= NOT operand1 after prop_delay;
            when others =>
                result <= x"00000000";
                    
        end case;
    end process alu;
end architecture unit;
