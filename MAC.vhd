library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.fixed_pkg.all;

entity MAC is
    generic(INT_SIZE: natural := 3;
            FRAC_SIZE: natural := 5);
    port(A, B : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
         C    : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
         Q    : OUT sfixed(INT_SIZE-1 downto -FRAC_SIZE));
end MAC;

architecture behave of MAC is
    signal mul    : sfixed(2*(INT_SIZE-1)+1 downto -2*FRAC_SIZE);
    signal mul_rd : sfixed(INT_SIZE-1 downto -FRAC_SIZE);
    signal sum    : sfixed(INT_SIZE   downto -FRAC_SIZE);
    
begin   
    mul    <= a * b;
    mul_rd <= mul(INT_SIZE-1 downto -FRAC_SIZE);
    sum    <= mul_rd + c;
    q      <= sum(INT_SIZE-1 downto -FRAC_SIZE);
end behave;
