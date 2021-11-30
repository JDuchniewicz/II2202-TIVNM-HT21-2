library ieee;
use ieee.fixed_pkg.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

use work.neuron_type_pkg.all;

entity sigmoid is
    port(x:  in fixed_point;
         fx: out fixed_point);
end sigmoid;

architecture behave of sigmoid is
    signal x_as_vector : std_logic_vector(int_size+frac_size-1 downto 0);
    signal half_x_as_vector : std_logic_vector(int_size+frac_size-1 downto 0);
    signal half_x_int_part : std_logic_vector(int_size-1 downto 0);
    signal one_plus_half_x_int : std_logic_vector(int_size-1 downto 0);
    signal one_plus_half_x_as_vector : std_logic_vector(int_size+frac_size-1 downto 0);
    signal fx_as_vector : std_logic_vector(int_size+frac_size-1 downto 0);

begin
    x_as_vector <= to_slv(x);
    half_x_as_vector <= x_as_vector(int_size+frac_size-1) & x_as_vector(int_size+frac_size-1 downto 1);
    half_x_int_part <= half_x_as_vector(int_size+frac_size-1 downto frac_size);
    one_plus_half_x_int <= half_x_int_part + 1;
    one_plus_half_x_as_vector <= one_plus_half_x_int & half_x_as_vector(frac_size-1 downto 0);
    fx_as_vector <= one_plus_half_x_as_vector(int_size+frac_size-1) &
                    one_plus_half_x_as_vector(int_size+frac_size-1 downto 1);

    process(x, fx_as_vector)
    begin
        if x < -2 then
            fx <= to_sfixed(0, int_size-1, -frac_size);
        elsif x > 2 then
            fx <= to_sfixed(1, int_size-1, -frac_size);
        else
            fx <= to_sfixed(fx_as_vector,int_size-1, -frac_size);
        end if;
    end process;
end behave;