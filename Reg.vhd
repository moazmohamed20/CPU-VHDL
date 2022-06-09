LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY Reg IS
    PORT (
        a   : IN  bit16;
        clk : IN  STD_LOGIC;
        q   : OUT bit16
    );
END Reg;

ARCHITECTURE RegArch OF Reg IS
BEGIN

    -- When a rising edge occurs on input (clk), the input (a) is copied to output (q).
    PROCESS
    BEGIN
        IF rising_edge(clk) THEN
            q <= a;
        END IF;
    END PROCESS;
	 
END RegArch;