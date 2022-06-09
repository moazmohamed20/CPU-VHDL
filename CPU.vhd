----------------------------------------------------------------------------------
-- Engineer: Moaz Mohamed
--
-- Create Date:     06/09/2022
-- Module Name:    CPU - CPUArch
-- Project Name:   CPU
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY CPU IS
    PORT (
        clock, reset, ready : IN STD_LOGIC;
        addr : OUT bit16;
        rw, vma : OUT STD_LOGIC;
        data : INOUT bit16
    );
END CPU;

ARCHITECTURE CpuArch OF CPU IS

    COMPONENT alu
        PORT (
            a, b : IN bit16;
            sel : IN t_alu;
            c : OUT bit16
        );
    END COMPONENT;

    COMPONENT comp
        PORT (
            a, b : IN bit16;
            sel : IN t_comp;
            compout : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT shift
        PORT (
            a : IN bit16;
            sel : IN t_shift;
            y : OUT bit16
        );
    END COMPONENT;

    COMPONENT reg
        PORT (
            a : IN bit16;
            clk : IN STD_LOGIC;
            q : OUT bit16
        );
    END COMPONENT;

    COMPONENT trireg
        PORT (
            a : IN bit16;
            en : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            q : OUT bit16
        );
    END COMPONENT;

    COMPONENT regarray
        PORT (
            data : IN bit16;
            sel : IN t_reg;
            en : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            q : OUT bit16
        );
    END COMPONENT;

    COMPONENT control
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            instrReg : IN bit16;
            compout : IN STD_LOGIC;
            ready : IN STD_LOGIC;
            progCntrWr : OUT STD_LOGIC;
            progCntrRd : OUT STD_LOGIC;
            addrRegWr : OUT STD_LOGIC;
            outRegWr : OUT STD_LOGIC;
            outRegRd : OUT STD_LOGIC;
            shiftSel : OUT t_shift;
            aluSel : OUT t_alu;
            compSel : OUT t_comp;
            opRegRd : OUT STD_LOGIC;
            opRegWr : OUT STD_LOGIC;
            instrWr : OUT STD_LOGIC;
            regSel : OUT t_reg;
            regRd : OUT STD_LOGIC;
            regWr : OUT STD_LOGIC;
            rw : OUT STD_LOGIC;
            vma : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL regSel : t_reg;
    SIGNAL aluSel : t_alu;
    SIGNAL compSel : t_comp;
    SIGNAL shiftSel : t_shift;
    SIGNAL opData, aluOut, shiftOut, instrregOut : bit16;
    SIGNAL regRd, regWr, opRegRd, opRegWr, outRegRd, outRegWr, addrRegWr, instrRegWr, progCntrRd, progCntrWr, compOut : STD_LOGIC;
BEGIN

    alUnit : alu PORT MAP(data, opData, aluSel, aluOut);
    shiftUnit : shift PORT MAP(aluOut, shiftSel, shiftOut);
    compUnit : comp PORT MAP(opData, data, compSel, compOut);
    controlUnit : control PORT MAP(clock, reset, instrRegOut, compOut, ready, progCntrWr, progCntrRd, addrRegWr, outRegWr, outRegRd, shiftSel, aluSel, compSel, opRegRd, opRegWr, instrRegWr, regSel, regRd, regWr, rw, vma);

    addrReg : reg PORT MAP(data, addrRegWr, addr);
    instrReg : reg PORT MAP(data, instrRegWr, instrRegOut);
    opRg : trireg PORT MAP(data, opRegRd, opRegWr, opData);
    outReg : trireg PORT MAP(shiftOut, outRegRd, outRegWr, data);
    progCntr : trireg PORT MAP(data, progCntrRd, progCntrWr, data);
    registersArray : regarray PORT MAP(data, regSel, regRd, regWr, data);
END CpuArch;