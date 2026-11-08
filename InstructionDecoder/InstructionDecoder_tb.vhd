library ieee;
use ieee.std_logic_1164.all;

entity InstructionDecoder_tb is
end entity;

architecture test of InstructionDecoder_tb is

    signal write_en             : bit := '0';
    signal illegal_instruction  : bit := '0';

    signal readaddr1    : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal readaddr2   : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal write_addr   : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');

    signal alu_op       : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal instruction  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');

begin

    dut : entity work.InstructionDecoder
        port map (
            write_en            => write_en,
            illegal_instruction => illegal_instruction,
            readaddr1           => readaddr1,
            readaddr2           => readaddr2,
            write_addr          => write_addr,
            alu_op              => alu_op,
            instruction         => instruction
            );

    process
    begin

    -- ADD x5, x3, x4

    instruction <=
        "0000000" &  -- funct7
        "00100"   &  -- second source register (x4)
        "00011"   &  -- first source register (x3)
        "000"     &  -- funct3
        "00101"   &  -- destination register (x5)
        "0110011";   -- opcode

    wait for 10 ns;

    ASSERT readaddr1 = "00011"
        report("Incorrect readaddr1")
        SEVERITY(error);


    -- SUB x5, x3, x4

    instruction <=
        "0100000" &  -- funct7
        "00100"   &  -- second source register
        "00011"   &  -- first source register
        "000"     &  -- funct3
        "00101"   &  -- destination register
        "0110011";   -- opcode

    wait for 10 ns;

    ASSERT alu_op = "0001"
        REPORT("Incorrect SUB operation")
        SEVERITY(error);
        

    -- Shift Left logical x5, x3, x4

    instruction <=
        "0000000" &  -- funct7
        "00100"   &  -- second source register
        "00011"   &  -- first source register
        "001"     &  -- funct3
        "00101"   &  -- destination register
        "0110011";   -- opcode

    wait for 10 ns;

    wait;
    end process;
end architecture;