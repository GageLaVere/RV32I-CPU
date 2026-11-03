LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RegisterFile_tb IS
END ENTITY;

ARCHITECTURE test OF RegisterFile_tb IS

    signal clk : bit := '0';

    signal read_addr1 : std_logic_vector(4 downto 0) := (others => '0');
    signal read_addr2 : std_logic_vector(4 downto 0) := (others => '0');

    signal read_data1 : std_logic_vector(31 downto 0);
    signal read_data2 : std_logic_vector(31 downto 0);

    signal write_addr : std_logic_vector(4 downto 0) := (others => '0');
    signal write_data : std_logic_vector(31 downto 0) := (others => '0');
    signal write_en   : bit := '0';

BEGIN

    --clock generator for tb only
    clk <= not clk after 5 ns;

    DUT : ENTITY work.RegisterFile
        PORT MAP (
            clk        => clk,
            read_addr1 => read_addr1,
            read_addr2 => read_addr2,
            read_data1 => read_data1,
            read_data2 => read_data2,
            write_addr => write_addr,
            write_data => write_data,
            write_en   => write_en
        );


    PROCESS
    BEGIN

        -------write/read1 ---------------------
        write_en <= '1';
        write_data <= x"FEDCBA98";
        write_addr <= "00101";

        wait until clk = '1';

        write_en <= '0';
        read_addr1 <= "00101";

        wait for 1 ns;

        assert (read_data1 = x"FEDCBA98")
            report("Write/Read 1 did not work!")
            severity (failure);

        wait for 5 ns;

        ----------------test x0 ----------------------------
        write_data <= x"FFFFFFFF";
        write_addr <= "00000";
        write_en <= '1';

        wait until clk = '1';

        read_addr2 <= "00000";

        wait for 1 ns;

        assert (read_data2 = x"00000000")
            report("x0 is not 0!")
            severity(failure);

        write_en <= '0';

        wait for 5 ns;


       ----------------test disable ---------------------

        write_addr <= "00101";
        write_data <= x"87654321";
        read_addr2 <= "00101";

        wait until clk = '1';

        wait for 1 ns;

        assert read_data2 = x"FEDCBA98"
            report("Wrote with enable 0!")
            severity(failure);

        wait for 5 ns;

        ----------------test write on falling edge-------------

        wait until clk = '1';
        wait for 1 ns;

        write_data <= x"01010101";
        write_addr <= "00101";
        write_en <= '1';

        wait until clk = '0';
        wait for 1 ns;

        assert read_data1 = x"FEDCBA98"
            report("write is asynch!")
            severity(failure);

        wait until clk = '1';
        wait for 1 ns;

        assert read_data1 = x"01010101"
            report("write on rising edge did not work!")
            severity(failure);

        write_en <= '0';

        WAIT for 1 ns;
        std.env.finish;
    END PROCESS;

END ARCHITECTURE;