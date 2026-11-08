LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY InstructionDecoder_tb IS
END ENTITY;

ARCHITECTURE test OF InstructionDecoder_tb IS

    signal write_en             : bit := '0';
    signal illegal_instruction  : bit := '0';

    signal readaddr1    : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal readaddr2   : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');
    signal write_addr   : STD_LOGIC_VECTOR(4 DOWNTO 0) := (others => '0');

    signal alu_op       : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal instruction  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');

BEGIN
    dut : ENTITY work.InstructionDecoder
        PORT map (
            write_en            => write_en,
            illegal_instruction => illegal_instruction,
            readaddr1           => readaddr1,
            readaddr2           => readaddr2,
            write_addr          => write_addr,
            alu_op              => alu_op,
            instruction         => instruction
            );

PROCESS

    PROCEDURE check_rtype(
        constant test_name   : in string;
        constant funct7      : in std_logic_vector(6 downto 0);
        constant funct3      : in std_logic_vector(2 downto 0);
        constant expected_op : in std_logic_vector(3 downto 0);
        signal instr         : out std_logic_vector(31 downto 0)
    ) IS 
    BEGIN

        instr <=
            funct7    &
            "00100"   & -- second source register
            "00011"   & -- first source register
            funct3    &
            "00101"   & -- destination register
            "0110011";

        wait for 10 ns;

        assert(alu_op = expected_op)
            report test_name & ": Incorrect ALU operation"
            severity error;

        assert readaddr1 = "00011"
            report test_name & ": Incorrect first register"
            severity error;

        assert readaddr2 = "00100"
            report test_name & ": Incorrect second register"
            severity error;

        assert write_addr = "00101"
            report test_name & ": Incorrect destination register"
            severity error;

        assert write_en = '1'
            report test_name & ": Register write disabled"
            severity error;

        assert illegal_instruction = '0'
            report test_name & ": Instruction marked illegal"
            severity error;

    END procedure;

    BEGIN

        --test R-type instructions
        check_rtype("ADD",  "0000000", "000", "0000", instruction);
        check_rtype("SUB",  "0100000", "000", "0001", instruction);
        check_rtype("AND",  "0000000", "111", "0010", instruction);
        check_rtype("OR",   "0000000", "110", "0011", instruction);
        check_rtype("XOR",  "0000000", "100", "0100", instruction);
        check_rtype("SLL",  "0000000", "001", "0101", instruction);
        check_rtype("SRL",  "0000000", "101", "0110", instruction);
        check_rtype("SRA",  "0100000", "101", "0111", instruction);
        check_rtype("SLT",  "0000000", "010", "1000", instruction);
        check_rtype("SLTU", "0000000", "011", "1001", instruction);

        --test invalid case
        instruction <=
            "0100000" & "00100" & "00011" &
            "111" & "00101" & "0110011";

        wait for 10 ns;

        assert illegal_instruction = '1'
            report("Invalid instruction accepted")
            severity(error);

        assert write_en = '0'
            report("Invalid instruction enabled register writing")
            severity(error);


        wait for 10 ns;

        wait;

    END process;

END architecture;