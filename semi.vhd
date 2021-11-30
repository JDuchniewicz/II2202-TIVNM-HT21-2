-- This architecture uses only two MACs 
ARCHITECTURE semi OF neuron IS
    COMPONENT MAC
        GENERIC (
            INT_SIZE : NATURAL;
            FRAC_SIZE : NATURAL);
        PORT (
            A, B : IN sfixed(INT_SIZE - 1 DOWNTO -FRAC_SIZE);
            C : IN sfixed(INT_SIZE - 1 DOWNTO -FRAC_SIZE);
            Q : OUT sfixed(INT_SIZE - 1 DOWNTO -FRAC_SIZE));
    END COMPONENT;

    SIGNAL input_register1, input_register2 : fixed_point;
    SIGNAL weight_register1, weight_register2 : fixed_point;
    SIGNAL accumilator1, accumilator2 : fixed_point;
    SIGNAL result1, result2 : fixed_point;

    SIGNAL counter1 : INTEGER := 0;
    SIGNAL counter2 : INTEGER := N/2;
    SIGNAL ready : STD_LOGIC := '0';

BEGIN
    Q <= result1(int_size - 1 DOWNTO -frac_size);

    S1 : MAC
    GENERIC MAP(
        INT_SIZE => int_size,
        FRAC_SIZE => frac_size)
    PORT MAP(
        input_register1,
        weight_register1,
        accumilator1,
        result1
    );

    S2 : MAC
    GENERIC MAP(
        INT_SIZE => int_size,
        FRAC_SIZE => frac_size)
    PORT MAP(
        input_register2,
        weight_register2,
        accumilator2,
        result2
    );

    PROCESS (clk, rst, counter1, ready)
    BEGIN
        IF rst = '1' THEN
            ready <= '0';
        ELSIF counter1 = N/2 - 1 THEN
            ready <= '1';
        ELSE
            ready <= '0';
        END IF;
    END PROCESS;

    PROCESS (clk, rst, counter1)
    BEGIN
        IF rst = '1' THEN
            counter1 <= 0;
            counter2 <= N/2;
        ELSIF falling_edge(clk) THEN
            counter1 <= counter1 + 1;
            counter2 <= counter2 + 1;
            IF counter1 = N/2 - 1 THEN
                counter1 <= 0;
                counter2 <= N/2;
            END IF;
        END IF;
    END PROCESS;

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            accumilator1 <= bval; -- here we are adding the bias 
            input_register1 <= INPUTS_VEC (0);
            weight_register1 <= weights (0);
        ELSIF rising_edge(clk) THEN
            IF (ready <= '0') THEN
                accumilator1 <= result1;
                input_register1 <= INPUTS_VEC (counter1);
                weight_register1 <= weights (counter1);
            ELSE
                input_register1 <= accumilator2(int_size - 1 DOWNTO -frac_size);
                weight_register1 <= to_sfixed(1.0, int_size - 1, -frac_size);
            END IF;
        END IF;
    END PROCESS;

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            accumilator2 <= to_sfixed(0.0, int_size - 1, -frac_size);
            input_register2 <= INPUTS_VEC(N/2);
            weight_register2 <= weights(N/2);
        ELSIF rising_edge(clk) THEN
            accumilator2 <= result2;
            input_register2 <= INPUTS_VEC(counter2);
            weight_register2 <= weights(counter2);
        END IF;
    END PROCESS;

END semi;