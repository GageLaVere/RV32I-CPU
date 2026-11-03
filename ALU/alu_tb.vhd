library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end entity;

architecture test of alu_tb is
    signal a, b, result    : std_logic_vector(31 downto 0) := (others => '0');
    signal operation       : std_logic_vector(3 downto 0)  := (others => '0');
begin

    dut : entity work.ALU
        port map (
            a => a,
            b => b,
            operation => operation,
            result => result
            );

    process
    begin

        ----------------- START ADD -------------------------
        a <= x"00000002";
        b <= x"00000001";
        operation <= "0000"; -- ADD

        wait for 5 ns;

        assert (result = x"00000003")
            report("Addition did not work!") --basic add
            severity failure;

        wait for 5 ns;

        a <= x"FFFFFFFF";

        wait for 5 ns;

        assert (result = x"00000000")
            report("Addition did not work!") --add overflow
            severity failure;

        ------------------END ADD -----------------------------



        ------------------START SUB ---------------------------
        operation <= "0001"; -- SUB
        a <= x"00000000";

        wait for 5 ns;

        assert (result = x"FFFFFFFF")
            report("Subtraction did not work!") --sub underflow
            severity failure;

        a <= x"00000003";
        b <= x"00000002";

        wait for 5 ns;

        assert (result = x"00000001")
            report("Subtraction did not work!") --basic sub
            severity failure;

        ----------------END SUB --------------------------------



        ----------------START AND ------------------------------
        a <= x"FFFFFFFF";
        operation <= "0010";

       wait for 5 ns;

        assert (result = (a AND b))
            report("AND operation did not work!") --basic AND
            severity failure;

        ----------------END AND------------------------------




        ----------------START OR------------------------------
        operation <= "0011"; -- OR

        wait for 5 ns;

        assert (result = (a OR b))
            report("OR operation did not work!") --basic OR
            severity failure;
        ----------------END OR------------------------------



        ----------------START XOR------------------------------
        operation <= "0100";

        wait for 5 ns;

        assert (result = (a XOR b))
            report("XOR operation did not work!") --basic xor
            severity failure;

        a <= x"00000001";
        b <= x"00000007";
        ----------------END XOR------------------------------




        ----------------START SLL------------------------------
        operation <= "0101";

        wait for 5 ns;

        assert result = x"00000080"
            report("Shift left logical operation did not work!")
            severity failure;

        a <= x"10000000";
        b <= x"00000007";

        ----------------END SLL------------------------------





        ----------------START SRL------------------------------
        operation <= "0110";

        wait for 5 ns;

        assert (result = x"00200000")
            report("Shift right logical operation did not work!")--shift right logical
            severity failure;
        ----------------END SRL------------------------------




        ----------------START SRA------------------------------
        operation <= "0111";
        a <= x"80000000";
        wait for 5 ns;

        assert (result = x"FF000000")
            report("Shift right arithmetic operation did not work!")--shift right arith
            severity failure;
        ----------------END SRL------------------------------




        ----------------START SLT------------------------------
        operation <= "1000";
        a <= x"00000000";
        b <= x"FFFFFFFF";

        wait for 5 ns;

        assert (result = x"00000000") --b is greater than a
            report("Signed less than operation did not work!")--b > a
            severity failure;

        a <= x"FFFFFFFF";
        b <= x"00000000";  

        wait for 5 ns;

        assert (result = x"00000001")
            report("Signed less than operation did not work!")--a > b
            severity failure;
        ----------------END SLT------------------------------




        ----------------START SLTU------------------------------
        operation <= "1001";

        a <= x"FFFFFFFF";
        b <= x"00000000";

        wait for 5 ns;

        assert (result = x"00000000")
            report("Unsigned less than operation did not work")
            severity failure;
        ----------------END SLTU------------------------------


        wait for 1 ns;
        a <= x"00000000";
        b <= x"00000000";


        wait;
    end process;
end architecture;