LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.fixed_pkg.ALL;

USE work.neuron_type_pkg.ALL;

ENTITY test_artificial_neuron IS
END test_artificial_neuron;

ARCHITECTURE behave OF test_artificial_neuron IS

    CONSTANT INPUT_NUM : NATURAL := 64;

    COMPONENT artificial_neuron IS
        PORT (
            CLK, RST : IN STD_LOGIC;
            Y : OUT fixed_point);
    END COMPONENT;

    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL test_out : real;
    SIGNAL q_out : fixed_point;
BEGIN

    DUT : artificial_neuron
    PORT MAP(
        clk => clk,
        rst => rst,
        Y => q_out);

    test_out <= to_real(q_out);
    clk <= NOT(clk) AFTER 5 ns;
    rst <= '1' AFTER 3 ns, '0' AFTER 11 ns;

END behave;