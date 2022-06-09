LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE cpu_lib IS

    SUBTYPE bit16 IS STD_LOGIC_VECTOR(15 DOWNTO 0);
    SUBTYPE t_reg IS STD_LOGIC_VECTOR(2 DOWNTO 0);

    TYPE t_alu IS (alupass, andOp, orOp, xorOp, notOp, plus, alusub, inc, dec, zero);
    TYPE t_comp IS (eq, neq, gt, gte, lt, lte);
    TYPE t_shift IS (shftpass, shl, shr, rotl, rotr);

END cpu_lib;

PACKAGE BODY cpu_lib IS
END cpu_lib;