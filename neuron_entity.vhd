LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.fixed_pkg.ALL;

USE work.neuron_type_pkg.ALL;

ENTITY neuron IS
    GENERIC (N : NATURAL := 64);
    PORT (
        CLK, RST : IN STD_LOGIC;
        Q : OUT fixed_point);
END neuron;