LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY TriReg IS
    PORT (
        a : IN bit16;
        en : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        q : OUT bit16
    );
END TriReg;

ARCHITECTURE TriRegArch OF TriReg IS
    SIGNAL val : bit16;
BEGIN

    -- When a rising edge occurs on input (clk), the data on input (a) is stored in the register.
    PROCESS
    BEGIN
        IF rising_edge(clk) THEN
            val <= a;
        END IF;
    END PROCESS;

    -- This process outputs the value of (val) if the (en) = '1'; otherwise, it puts out Z values.
    PROCESS (en, val)
    BEGIN
        IF en = '1' THEN
            q <= val;
        ELSE
            q <= "ZZZZZZZZZZZZZZZZ";
        END IF;
    END PROCESS;

END TriRegArch;