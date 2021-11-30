library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.fixed_pkg.all;

package neuron_type_pkg is

    -- 32 BITS
    constant int_size : natural := 12;
    constant frac_size : natural := 20;

    -- 16 BITS
    -- constant int_size : natural := 6;
    -- constant frac_size : natural := 10;

    -- 8 BITS
    -- constant int_size : natural := 3;
    -- constant frac_size : natural := 5;


    subtype fixed_point is sfixed(int_size-1 downto -frac_size);
    type neuron_inputs is array (natural range <>) of fixed_point;
    constant bval : fixed_point :=  to_sfixed(0.02, int_size-1, -frac_size);

    constant weights : neuron_inputs(0 to 63) := (
        to_sfixed(-0.289,  int_size-1, -frac_size), to_sfixed(-0.461,  int_size-1, -frac_size),
        to_sfixed(-1.009,  int_size-1, -frac_size), to_sfixed(-1.651,  int_size-1, -frac_size), 
        to_sfixed(-0.114,  int_size-1, -frac_size), to_sfixed(-0.465,  int_size-1, -frac_size), 
        to_sfixed(-0.559,  int_size-1, -frac_size), to_sfixed(-0.192,  int_size-1, -frac_size),
        to_sfixed(-1.298,  int_size-1, -frac_size), to_sfixed(1.475,  int_size-1, -frac_size), 
        to_sfixed(-0.054,  int_size-1, -frac_size), to_sfixed(1.381,  int_size-1, -frac_size), 
        to_sfixed(-0.244,  int_size-1, -frac_size), to_sfixed(1.402,  int_size-1, -frac_size),
        to_sfixed(1.219,  int_size-1, -frac_size), to_sfixed(0.62,  int_size-1, -frac_size),
        to_sfixed(0.632,  int_size-1, -frac_size), to_sfixed(0.093,  int_size-1, -frac_size),
        to_sfixed(1.64,  int_size-1, -frac_size),  to_sfixed(0.197,  int_size-1, -frac_size),
        to_sfixed(-0.873,  int_size-1, -frac_size), to_sfixed(0.744,  int_size-1, -frac_size),
        to_sfixed(0.127,  int_size-1, -frac_size), to_sfixed(-0.395,  int_size-1, -frac_size), 
        to_sfixed(0.94,  int_size-1, -frac_size), to_sfixed(-1.629,  int_size-1, -frac_size), 
        to_sfixed(1.15,  int_size-1, -frac_size), to_sfixed(0.574,  int_size-1, -frac_size), 
        to_sfixed(0.282,  int_size-1, -frac_size), to_sfixed(0.803,  int_size-1, -frac_size),
        to_sfixed(0.459,  int_size-1, -frac_size), to_sfixed(1.255,  int_size-1, -frac_size),
        to_sfixed(-0.177,  int_size-1, -frac_size), to_sfixed(-0.432,  int_size-1, -frac_size),
        to_sfixed(0.451,  int_size-1, -frac_size), to_sfixed(1.56,  int_size-1, -frac_size),
        to_sfixed(0.065,  int_size-1, -frac_size), to_sfixed(0.5,  int_size-1, -frac_size), 
        to_sfixed(0.075,  int_size-1, -frac_size), to_sfixed(1.694,  int_size-1, -frac_size), 
        to_sfixed(-0.726,  int_size-1, -frac_size), to_sfixed(-0.706,  int_size-1, -frac_size),
        to_sfixed(-0.942,  int_size-1, -frac_size), to_sfixed(-0.868,  int_size-1, -frac_size),
        to_sfixed(-0.469,  int_size-1, -frac_size), to_sfixed(0.065,  int_size-1, -frac_size),
        to_sfixed(-0.527,  int_size-1, -frac_size), to_sfixed(0.247,  int_size-1, -frac_size),
        to_sfixed(0.222,  int_size-1, -frac_size), to_sfixed(0.263,  int_size-1, -frac_size), 
        to_sfixed(0.216,  int_size-1, -frac_size), to_sfixed(-1.881,  int_size-1, -frac_size), 
        to_sfixed(0.904,  int_size-1, -frac_size), to_sfixed(-0.747,  int_size-1, -frac_size), 
        to_sfixed(-0.537,  int_size-1, -frac_size), to_sfixed(-0.635,  int_size-1, -frac_size),
        to_sfixed(-0.724,  int_size-1, -frac_size), to_sfixed(0.075,  int_size-1, -frac_size), 
        to_sfixed(1.009,  int_size-1, -frac_size), to_sfixed(-0.484,  int_size-1, -frac_size), 
        to_sfixed(1.136,  int_size-1, -frac_size), to_sfixed(0.63,  int_size-1, -frac_size), 
        to_sfixed(0.414,  int_size-1, -frac_size), to_sfixed(-0.064,  int_size-1, -frac_size));
    constant INPUTS_VEC : neuron_inputs(0 to 63) := (
        to_sfixed(-0.289,  int_size-1, -frac_size), to_sfixed(-0.461,  int_size-1, -frac_size),
        to_sfixed(-1.009,  int_size-1, -frac_size), to_sfixed(-1.651,  int_size-1, -frac_size), 
        to_sfixed(-0.114,  int_size-1, -frac_size), to_sfixed(-0.465,  int_size-1, -frac_size), 
        to_sfixed(-0.559,  int_size-1, -frac_size), to_sfixed(-0.192,  int_size-1, -frac_size),
        to_sfixed(-1.298,  int_size-1, -frac_size), to_sfixed(1.475,  int_size-1, -frac_size), 
        to_sfixed(-0.054,  int_size-1, -frac_size), to_sfixed(1.381,  int_size-1, -frac_size), 
        to_sfixed(-0.244,  int_size-1, -frac_size), to_sfixed(1.402,  int_size-1, -frac_size),
        to_sfixed(1.219,  int_size-1, -frac_size), to_sfixed(0.62,  int_size-1, -frac_size),
        to_sfixed(0.632,  int_size-1, -frac_size), to_sfixed(0.093,  int_size-1, -frac_size),
        to_sfixed(1.64,  int_size-1, -frac_size),  to_sfixed(0.197,  int_size-1, -frac_size),
        to_sfixed(-0.873,  int_size-1, -frac_size), to_sfixed(0.744,  int_size-1, -frac_size),
        to_sfixed(0.127,  int_size-1, -frac_size), to_sfixed(-0.395,  int_size-1, -frac_size), 
        to_sfixed(0.94,  int_size-1, -frac_size), to_sfixed(-1.629,  int_size-1, -frac_size), 
        to_sfixed(1.15,  int_size-1, -frac_size), to_sfixed(0.574,  int_size-1, -frac_size), 
        to_sfixed(0.282,  int_size-1, -frac_size), to_sfixed(0.803,  int_size-1, -frac_size),
        to_sfixed(0.459,  int_size-1, -frac_size), to_sfixed(1.255,  int_size-1, -frac_size),
        to_sfixed(-0.177,  int_size-1, -frac_size), to_sfixed(-0.432,  int_size-1, -frac_size),
        to_sfixed(0.451,  int_size-1, -frac_size), to_sfixed(1.56,  int_size-1, -frac_size),
        to_sfixed(0.065,  int_size-1, -frac_size), to_sfixed(0.5,  int_size-1, -frac_size), 
        to_sfixed(0.075,  int_size-1, -frac_size), to_sfixed(1.694,  int_size-1, -frac_size), 
        to_sfixed(-0.726,  int_size-1, -frac_size), to_sfixed(-0.706,  int_size-1, -frac_size),
        to_sfixed(-0.942,  int_size-1, -frac_size), to_sfixed(-0.868,  int_size-1, -frac_size),
        to_sfixed(-0.469,  int_size-1, -frac_size), to_sfixed(0.065,  int_size-1, -frac_size),
        to_sfixed(-0.527,  int_size-1, -frac_size), to_sfixed(0.247,  int_size-1, -frac_size),
        to_sfixed(0.222,  int_size-1, -frac_size), to_sfixed(0.263,  int_size-1, -frac_size), 
        to_sfixed(0.216,  int_size-1, -frac_size), to_sfixed(-1.881,  int_size-1, -frac_size), 
        to_sfixed(0.904,  int_size-1, -frac_size), to_sfixed(-0.747,  int_size-1, -frac_size), 
        to_sfixed(-0.537,  int_size-1, -frac_size), to_sfixed(-0.635,  int_size-1, -frac_size),
        to_sfixed(-0.724,  int_size-1, -frac_size), to_sfixed(0.075,  int_size-1, -frac_size), 
        to_sfixed(1.009,  int_size-1, -frac_size), to_sfixed(-0.484,  int_size-1, -frac_size), 
        to_sfixed(1.136,  int_size-1, -frac_size), to_sfixed(0.63,  int_size-1, -frac_size), 
        to_sfixed(0.414,  int_size-1, -frac_size), to_sfixed(-0.064,  int_size-1, -frac_size));
end package;
