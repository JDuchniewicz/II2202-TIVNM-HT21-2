library IEEE;
use IEEE.fixed_pkg.all;

entity test is
end test;

architecture test_MAC of test is

    constant INT_PART : natural := 3;
    constant FRAC_PART : natural := 5;
    
    component MAC
        generic(INT_SIZE: natural;
                FRAC_SIZE: natural);
        port(A, B : IN  sfixed(INT_SIZE-1       downto -FRAC_SIZE);
             C    : IN  sfixed(2*(INT_SIZE-1)+1 downto -2*FRAC_SIZE);
             Q    : OUT sfixed(2*(INT_SIZE-1)+1 downto -2*FRAC_SIZE));
    end component;

    signal a_in, b_in  : sfixed(INT_PART-1       downto -FRAC_PART);
    signal c_in, q_out : sfixed(2*(INT_PART-1)+1 downto -2*FRAC_PART);
    signal test_out : real;

begin

    DUT: MAC
        generic map(INT_SIZE => INT_PART,
                    FRAC_SIZE => FRAC_PART)
        port map(A => a_in,
                 B => b_in,
                 C => c_in,
                 q => q_out);

    test_out <= to_real(q_out);

    process
    begin
        for i in 1 to 5 loop
            a_in <= to_sfixed(i, INT_PART-1, -FRAC_PART);
            b_in <= to_sfixed(2.5, INT_PART-1, -FRAC_PART);
            c_in <= to_sfixed(9.9, 2*(INT_PART-1)+1, -2*FRAC_PART); 
            wait for 1 ns;
        end loop;
    end process;


end test_MAC;