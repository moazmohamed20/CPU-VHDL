LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY Shift IS
    PORT (
        a : IN bit16;
        sel : IN t_shift;
        y : OUT bit16
    );
END Shift;

ARCHITECTURE ShiftArch OF Shift IS
BEGIN

    -- The architecture uses a large case statement on input (sel) to determine which of the shift or rotate operations to perform.
    -- The possible values of (sel) are determined by type (t_shift) described in package "cpu_lib" in file cpulib.vhd.
    PROCESS
    BEGIN
        CASE sel IS
                -- No Shift
            WHEN shftpass => y <= a;

                -- Shift Left
            WHEN shl => y <= a(14 DOWNTO 0) & '0';

                -- Shift Right
            WHEN shr => y <= '0' & a(15 DOWNTO 1);

                -- Rotate Left
            WHEN rotl => y <= a(14 DOWNTO 0) & a(15);

                -- Rotate Right
            WHEN rotr => y <= a(0) & a(15 DOWNTO 1);

            WHEN OTHERS => y <= a;
        END CASE;
    END PROCESS;

END ShiftArch;