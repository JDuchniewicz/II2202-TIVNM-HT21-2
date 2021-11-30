LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE work.neuron_type_pkg.ALL;
USE work.ALL;

ENTITY artificial_neuron IS
    PORT (
        CLK, RST : IN STD_LOGIC;
        Y : OUT fixed_point);
END artificial_neuron;

ARCHITECTURE behave OF artificial_neuron IS

    CONSTANT N_INPUTS : NATURAL := 64;

    COMPONENT neuron
        GENERIC (N : NATURAL);
        PORT (
            CLK, RST : IN STD_LOGIC;
            Q : OUT fixed_point);
    END COMPONENT;

    COMPONENT relu IS
        PORT (
            x : IN fixed_point;
            fx : OUT fixed_point);
    END COMPONENT;
    FOR N0 : neuron USE ENTITY work.neuron(semi);

    SIGNAL neuron_out : fixed_point;

BEGIN

    N0 : neuron
    GENERIC MAP(N => N_INPUTS)
    PORT MAP(
        CLK => CLK,
        RST => RST,
        Q => neuron_out);

    S0 : relu
    PORT MAP(
        x => neuron_out,
        fx => y);

END behave;