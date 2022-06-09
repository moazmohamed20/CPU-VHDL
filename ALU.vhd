LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.cpu_lib.ALL;

ENTITY ALU IS
   PORT (
      a, b : IN bit16;
      sel : IN t_alu;
      c : OUT bit16
   );
END ALU;

ARCHITECTURE ALUArch OF ALU IS
BEGIN

   -- The architecture uses a large case statement on input (sel) to determine which of the arithmetic or logical operations to perform.
   -- The possible values of (sel) are determined by type (t_alu) described in package "cpu_lib" in file cpulib.vhd.
   PROCESS
   BEGIN
      CASE sel IS
            -- c = a
         WHEN alupass => c <= a;

            -- c = a AND b
         WHEN andOp => c <= a AND b;

            -- c = a OR b
         WHEN orOp => c <= a OR b;

            -- c = a XOR b
         WHEN xorOp => c <= a XOR b;

            -- c = NOT a
         WHEN notOp => c <= NOT a;

            -- c = a + b
         WHEN plus => c <= a + b;

            -- c = a - b
         WHEN alusub => c <= a - b;

            -- c = a + 1
         WHEN inc => c <= a + "0000000000000001";

            -- c = a - 1
         WHEN dec => c <= a - "0000000000000001";

            -- c = 0
         WHEN zero => c <= "0000000000000000";

         WHEN OTHERS => c <= "0000000000000000";
      END CASE;
   END PROCESS;

END ALUArch;