architecture parallel OF neuron IS
    component MAC
        generic(INT_SIZE: natural;
                FRAC_SIZE: natural);
        port(A, B : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
            C    : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
            Q    : OUT sfixed(INT_SIZE-1 downto -FRAC_SIZE));
    end component;
    SIGNAL RESULT : neuron_inputs(0 TO N-1);
    SIGNAL FINAL_RESULT : fixed_point;

BEGIN

    Q <= FINAL_RESULT;
    PROCESS (CLK, RST)
    BEGIN
        IF RST = '1' THEN
            FINAL_RESULT <= to_sfixed(0.0, int_size-1, -frac_size);
        ELSIF RISING_EDGE(CLK) THEN
            FINAL_RESULT <= RESULT(N - 1);
        END IF;
    END PROCESS;

    G1 : FOR I IN 0 TO N - 1 GENERATE
        G2 : IF I = 0 GENERATE
            M1 : MAC GENERIC MAP (
                INT_SIZE => int_size,
                FRAC_SIZE => frac_size)
            PORT MAP(
                INPUTS_VEC(I),
                weights(I),
                bval,
                RESULT(I));
        END GENERATE;
        G3 : IF I > 0 GENERATE
            M2 : MAC GENERIC MAP (
                INT_SIZE => int_size,
                FRAC_SIZE => frac_size)
            PORT MAP(
                INPUTS_VEC(I),
                weights(I),
                RESULT(I - 1),
                RESULT(I));
        END GENERATE;
    END GENERATE;

    END parallel;