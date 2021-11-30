LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.fixed_pkg.ALL;
USE WORK.neuron_type_pkg.ALL;

ENTITY RELU IS
    PORT (
        x : IN sfixed(INT_SIZE - 1 DOWNTO -FRAC_SIZE);
        fx : OUT sfixed(INT_SIZE - 1 DOWNTO -FRAC_SIZE)
    );
END ENTITY;

ARCHITECTURE behave OF RELU IS
BEGIN
    PROCESS (x)
    BEGIN
        IF (x < 0) THEN
            fx <= to_sfixed(0.0, int_size - 1, -frac_size);
        ELSE
            fx <= x;
        END IF;
    END PROCESS;
END behave;