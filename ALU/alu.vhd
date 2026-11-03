
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

ENTITY ALU IS
    PORT (
        operation  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        a, b       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        result     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ALU;

ARCHITECTURE unit OF ALU IS

BEGIN

    PROCESS(operation, a, b)
        BEGIN
        CASE operation IS

            --add
            WHEN "0000" =>
                result <= (a + b);

            --subtract
            WHEN "0001" =>
                result <= (a - b);

            --AND
            WHEN "0010" =>
                result <= (a AND b);

            --OR
            WHEN "0011" =>
                result <= (a OR b);

            --xor
            WHEN "0100" =>
                result <= (a XOR b);

            --shift left logical
            WHEN "0101" =>
                result <= std_logic_vector(
                    shift_left(unsigned(a), to_integer(unsigned(b(4 downto 0)))));

            --shift right logical
            WHEN "0110" =>
                result <= std_logic_vector(
                    shift_right(unsigned(a), to_integer(unsigned(b(4 downto 0)))));

            --shift right arithmetic
            WHEN "0111" =>
                result <= std_logic_vector(
                    shift_right(signed(a), to_integer(unsigned(b(4 downto 0)))));

            --signed less than (emits true/false)
            WHEN "1000" =>
                result <= x"00000001" when (signed(a) < signed(b))
                    else x"00000000";

            --unsigned less than (emits true/false)
            WHEN "1001" =>
                result <= x"00000001" when (unsigned(a) < unsigned(b))
                    else x"00000000";

            --default
            WHEN OTHERS =>
                result <= (OTHERS => '1');

        END CASE;
    END PROCESS;

END unit;
