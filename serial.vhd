architecture serial of neuron is
    component MAC
        generic(INT_SIZE: natural;
                FRAC_SIZE: natural);
        port(A, B : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
             C    : IN  sfixed(INT_SIZE-1 downto -FRAC_SIZE);
             Q    : OUT sfixed(INT_SIZE-1 downto -FRAC_SIZE));
    end component;

    constant weights : neuron_inputs(0 to N-1) := weights(0 to N-1);
    constant b_val : fixed_point := bval;

    signal a_in, b_in : fixed_point;
    signal c_in, q_out, f_sigmoid : fixed_point;

    signal inputs_l : neuron_inputs(0 to N-1);
    signal iter : natural := 0;
    
begin

    MAC0: MAC
          generic map(INT_SIZE => int_size,
                      FRAC_SIZE => frac_size)
          port map(A => a_in,
                   B => b_in,
                   C => c_in,
                   Q => q_out);
    
    q <= q_out;

    process (iter, rst)
    begin
        if (rst = '1') then
            a_in <= to_sfixed(0, int_size-1, -frac_size);
            b_in <= to_sfixed(0, int_size-1, -frac_size);
            c_in <= to_sfixed(0, int_size-1, -frac_size);
        else 
            a_in <= weights(N-1-(iter));
            b_in <= inputs_l(iter);
            if iter = 0 then
                c_in <= b_val;
            else
                c_in <= q_out;
            end if;
        end if;
    end process;

    process (clk, rst)
    begin
        if (rst = '1') then
            iter <= 0;
        elsif rising_edge(clk) then
            if iter = N-1 then
                iter <= 0;
            else
                iter <= iter + 1;
            end if;
        end if;
    end process;

end serial;
