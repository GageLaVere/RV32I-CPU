LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY InstructionDecoder IS
    PORT (

        readaddr1    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        readaddr2    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        write_addr   : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        write_en            : OUT BIT;
        illegal_instruction : OUT BIT;

        alu_op       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        instruction  : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END InstructionDecoder;

ARCHITECTURE decoder OF InstructionDecoder IS

BEGIN

    process(instruction)
    begin

        readaddr1 <= (instruction(19 DOWNTO 15));

        readaddr2 <= (instruction(24 DOWNTO 20));

        write_addr <= (instruction(11 DOWNTO 7));

        alu_op <= "0000";

        write_en <= '0';

        --default to illegal
        illegal_instruction <= '1';

        CASE(instruction(6 DOWNTO 0)) IS

            --R type arithmetic
            WHEN "0110011" =>

                CASE(instruction(31 downto 25)) is

                    WHEN "0000000" =>

                        CASE(instruction(14 downto 12)) is
                            
                            --ADD
                            WHEN "000" => 
                                alu_op <= "0000";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --shift left logic
                            WHEN "001" => 
                                alu_op <= "0101";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --set less than
                            WHEN "010" => 
                                alu_op <= "1000";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --set less than unsigned
                            WHEN "011" => 
                                alu_op <= "1001";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --xor
                            WHEN "100" => 
                                alu_op <= "0100";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --shift right logical
                            WHEN "101" => 
                                alu_op <= "0110";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --or
                            WHEN "110" => 
                                alu_op <= "0011";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --AND
                            WHEN "111" =>
                                alu_op <= "0010";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            WHEN others => NULL;

                        END case;

                    WHEN "0100000" =>

                        CASE(instruction(14 downto 12)) is

                            --subract
                            WHEN "000" =>
                                alu_op <= "0001";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            --shift right arithmetic
                            WHEN "101" =>
                                alu_op <= "0111";
                                write_en <= '1';
                                illegal_instruction <= '0';

                            WHEN others => NULL;

                        END case;

                    WHEN others => NULL;

                END case;

            -- I type arithmetic
            WHEN "0010011" =>
                NULL;
            -- read instruction
            WHEN "0000011" =>
                NULL;
            -- write instruction
            WHEN "0100011" =>
                NULL;
            -- load upper immediate
            WHEN "0110111" =>
                NULL;
            -- conditional branches
            WHEN "1100011" =>
                NULL;
            WHEN others => NULL;

        END case;

    end process;

END decoder;
