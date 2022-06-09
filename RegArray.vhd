LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.cpu_lib.ALL;

ENTITY RegArray IS
    PORT (
        data : IN bit16;
        sel : IN t_reg;
        en : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        q : OUT bit16
    );
END RegArray;

ARCHITECTURE RegArrayArch OF RegArray IS
    -- 8 Registers, Each Of 16-Bit Word
    TYPE t_array IS ARRAY (0 TO 7) OF bit16;
    SIGNAL temp_q : bit16;
BEGIN

    -- This process contains a local variable (regData) that is used to store the (data) written to the regarray entity.
    -- When a rising edge occurs on input (clk): the location selected by input (sel) is updated with the new value.
    -- This process also writes the location to a signal called (temp_q) to pass the value to the second process. 
    PROCESS
        VARIABLE regData : t_array;
    BEGIN
        IF rising_edge(clk) THEN
            regData(conv_integer(sel)) := data;
        END IF;
        temp_q <= regData(conv_integer(sel));
    END PROCESS;

    -- This process outputs the value of (temp_q) if the (en) = '1'; otherwise, it puts out Z values.
    PROCESS
    BEGIN
        IF en = '1' THEN
            q <= temp_q AFTER 1 ns;
        ELSE
            q <= "ZZZZZZZZZZZZZZZZ";
        END IF;
    END PROCESS;

END RegArrayArch;