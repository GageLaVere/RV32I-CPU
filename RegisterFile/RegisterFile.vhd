
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY RegisterFile IS
    PORT (

        clk          : IN bit;

        read_addr1   : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        read_addr2   : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        read_data1   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        read_data2   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        write_addr   : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        write_data   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        write_en     : IN bit

    );

END RegisterFile;

ARCHITECTURE behavior OF RegisterFile IS

    type regarray is array(31 downto 0) of STD_LOGIC_VECTOR(31 DOWNTO 0);

    signal registers : regarray;
    

BEGIN

    read_data1 <= (others => '0') WHEN read_addr1 = "00000"
        else registers(to_integer(unsigned(read_addr1)));

    read_data2 <= (others => '0') WHEN read_addr2 = "00000"
        else registers(to_integer(unsigned(read_addr2)));

    PROCESS(clk)
        BEGIN

        IF RISING_EDGE(clk) then

            IF write_en = '1' and write_addr /= "00000" THEN
                registers(to_integer(unsigned(write_addr))) <= write_data;

            END IF;

        END IF;

    END PROCESS;

END behavior;
