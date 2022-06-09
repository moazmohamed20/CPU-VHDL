LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE cpu_lib IS

    SUBTYPE bit16 IS STD_LOGIC_VECTOR(15 DOWNTO 0);
    SUBTYPE t_reg IS STD_LOGIC_VECTOR(2 DOWNTO 0);

    TYPE t_alu IS (alupass, andOp, orOp, xorOp, notOp, plus, alusub, inc, dec, zero);
    TYPE t_comp IS (eq, neq, gt, gte, lt, lte);
    TYPE t_shift IS (shftpass, shl, shr, rotl, rotr);
    TYPE state IS (
        reset1, reset2, reset3, reset4, reset5, reset6,
        execute,
        load2, load3, load4,
        store2, store3, store4,
        move2, move3, move4,
        loadI2, loadI3, loadI4, loadI5, loadI6,
        braI2, braI3, braI4, braI5, braI6,
        bgtI2, bgtI3, bgtI4, bgtI5, bgtI6, bgtI7, bgtI8, bgtI9, bgtI10,
        inc2, inc3, inc4,
        loadPc, loadPc2, loadPc3, loadPc4,
        incPc, incPc1, incPc2, incPc3, incPc4, incPc5, incPc6
    );

END cpu_lib;

PACKAGE BODY cpu_lib IS
END cpu_lib;