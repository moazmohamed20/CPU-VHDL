LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY Comp IS
    PORT (
        a, b : IN bit16;
        sel : IN t_comp;
        compout : OUT STD_LOGIC
    );
END Comp;

ARCHITECTURE CompArch OF Comp IS
BEGIN

    -- The comparator consists of a large case statement where each branch of the case statement contains an IF.
    -- If the condition tested is true, a '1' value is assigned; otherwise, a '0' is assigned.
    PROCESS
    BEGIN
        CASE sel IS
                -- Is (a) Equal (b) ?
            WHEN eq =>
                IF a = b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

                -- Is (a) Not Equal (b) ?
            WHEN neq =>
                IF a /= b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

                -- Is (a) Greater Than (b) ?
            WHEN gt =>
                IF a > b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

                -- Is (a) Greater Than or Equal (b) ? 
            WHEN gte =>
                IF a >= b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

                -- Is (a) Less Than (b) ?
            WHEN lt =>
                IF a < b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

                -- Is (a) Less Than or Equal (b) ?
            WHEN lte =>
                IF a <= b THEN
                    compout <= '1';
                ELSE
                    compout <= '0';
                END IF;

            WHEN OTHERS => compout <= '0';
        END CASE;
    END PROCESS;

END CompArch;