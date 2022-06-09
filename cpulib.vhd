LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE cpu_lib IS

    SUBTYPE bit16 IS STD_LOGIC_VECTOR(15 DOWNTO 0);

    TYPE t_alu IS (alupass, andOp, orOp, xorOp, notOp, plus, alusub, inc, dec, zero);
    TYPE t_comp IS (eq, neq, gt, gte, lt, lte);

END cpu_lib;

PACKAGE BODY cpu_lib IS
END cpu_lib;