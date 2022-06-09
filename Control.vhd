LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.cpu_lib.ALL;

ENTITY Control IS
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        instrReg : IN bit16;
        compout : IN STD_LOGIC;
        ready : IN STD_LOGIC;
        progCntrWr : OUT STD_LOGIC;
        progCntrRd : OUT STD_LOGIC;
        addrRegWr : OUT STD_LOGIC;
        addrRegRd : OUT STD_LOGIC;
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
END Control;

ARCHITECTURE Behavioral OF Control IS
    SIGNAL current_state, next_state : state;
BEGIN

    PROCESS
    BEGIN
        progCntrWr <= '0';
        progCntrRd <= '0';
        addrRegWr <= '0';
        outRegWr <= '0';
        outRegRd <= '0';
        shiftSel <= shftpass;
        aluSel <= alupass;
        compSel <= eq;
        opRegRd <= '0';
        opRegWr <= '0';
        instrWr <= '0';
        regSel <= "000";
        regRd <= '0';
        regWr <= '0';
        rw <= '0';
        vma <= '0';

        CASE current_state IS
            WHEN reset1 =>
                aluSel <= zero;
                shiftSel <= shftpass;
                next_state <= reset2;
            WHEN reset2 =>
                aluSel <= zero;
                shiftSel <= shftpass;
                outRegWr <= '1';
                next_state <= reset3;
            WHEN reset3 =>
                outRegRd <= '1';
                next_state <= reset4;
            WHEN reset4 =>
                outRegRd <= '1';
                progCntrWr <= '1';
                addrRegWr <= '1';
                next_state <= reset5;
            WHEN reset5 =>
                vma <= '1';
                rw <= '0';
                next_state <= reset6;
            WHEN reset6 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    instrWr <= '1';
                    next_state <= execute;
                ELSE
                    next_state <= reset6;
                END IF;

            WHEN execute =>
                CASE instrReg(15 DOWNTO 11) IS
                    WHEN "00000" => --- nop
                        next_state <= incPc;
                    WHEN "00001" => --- load
                        regSel <= instrReg(5 DOWNTO 3);
                        regRd <= '1';
                        next_state <= load2;
                    WHEN "00010" => --- store
                        regSel <= instrReg(2 DOWNTO 0);
                        regRd <= '1';
                        next_state <= store2;
                    WHEN "00011" => ----- move
                        regSel <= instrReg(5 DOWNTO 3);
                        regRd <= '1';
                        aluSel <= alupass;
                        shiftSel <= shftpass;
                        next_state <= move2;
                    WHEN "00100" => ---- loadI
                        progcntrRd <= '1';
                        alusel <= inc;
                        shiftsel <= shftpass;
                        next_state <= loadI2;
                    WHEN "00101" => ---- BranchImm
                        progcntrRd <= '1';
                        alusel <= inc;
                        shiftsel <= shftpass;
                        next_state <= braI2;
                    WHEN "00110" => ---- BranchGTImm
                        regSel <= instrReg(5 DOWNTO 3);
                        regRd <= '1';
                        next_state <= bgtI2;
                    WHEN "00111" => ------- inc
                        regSel <= instrReg(2 DOWNTO 0);
                        regRd <= '1';
                        alusel <= inc;
                        shiftsel <= shftpass;
                        next_state <= inc2;
                    WHEN OTHERS =>
                        next_state <= incPc;
                END CASE;

            WHEN load2 =>
                regSel <= instrReg(5 DOWNTO 3);
                regRd <= '1';
                addrregWr <= '1';
                next_state <= load3;
            WHEN load3 =>
                vma <= '1';
                rw <= '0';
                next_state <= load4;
            WHEN load4 =>
                vma <= '1';
                rw <= '0';
                regSel <= instrReg(2 DOWNTO 0);
                regWr <= '1';
                next_state <= incPc;

            WHEN store2 =>
                regSel <= instrReg(2 DOWNTO 0);
                regRd <= '1';
                addrregWr <= '1';
                next_state <= store3;
            WHEN store3 =>
                regSel <= instrReg(5 DOWNTO 3);
                regRd <= '1';
                next_state <= store4;
            WHEN store4 =>
                regSel <= instrReg(5 DOWNTO 3);
                regRd <= '1';
                vma <= '1';
                rw <= '1';
                next_state <= incPc;

            WHEN move2 =>
                regSel <= instrReg(5 DOWNTO 3);
                regRd <= '1';
                aluSel <= alupass;
                shiftsel <= shftpass;
                outRegWr <= '1';
                next_state <= move3;
            WHEN move3 =>
                outRegRd <= '1';
                next_state <= move4;
            WHEN move4 =>
                outRegRd <= '1';
                regSel <= instrReg(2 DOWNTO 0);
                regWr <= '1';
                next_state <= incPc;

            WHEN loadI2 =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                outregWr <= '1';
                next_state <= loadI3;
            WHEN loadI3 =>
                outregRd <= '1';
                next_state <= loadI4;
            WHEN loadI4 =>
                outregRd <= '1';
                progcntrWr <= '1';
                addrregWr <= '1';
                next_state <= loadI5;
            WHEN loadI5 =>
                vma <= '1';
                rw <= '0';
                next_state <= loadI6;
            WHEN loadI6 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    regSel <= instrReg(2 DOWNTO 0);
                    regWr <= '1';
                    next_state <= incPc;
                ELSE
                    next_state <= loadI6;
                END IF;

            WHEN braI2 =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                outregWr <= '1';
                next_state <= braI3;
            WHEN braI3 =>
                outregRd <= '1';
                next_state <= braI4;
            WHEN braI4 =>
                outregRd <= '1';
                progcntrWr <= '1';
                addrregWr <= '1';
                next_state <= braI5;
            WHEN braI5 =>
                vma <= '1';
                rw <= '0';
                next_state <= braI6;
            WHEN braI6 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    progcntrWr <= '1';
                    next_state <= loadPc;
                ELSE
                    next_state <= braI6;
                END IF;

            WHEN bgtI2 =>
                regSel <= instrReg(5 DOWNTO 3);
                regRd <= '1';
                opRegWr <= '1';
                next_state <= bgtI3;
            WHEN bgtI3 =>
                opRegRd <= '1';
                regSel <= instrReg(2 DOWNTO 0);
                regRd <= '1';
                compsel <= gt;
                next_state <= bgtI4;
            WHEN bgtI4 =>
                opRegRd <= '1';
                regSel <= instrReg(2 DOWNTO 0);
                regRd <= '1';
                compsel <= gt;
                IF compout = '1' THEN
                    next_state <= bgtI5;
                ELSE
                    next_state <= incPc;
                END IF;
            WHEN bgtI5 =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftSel <= shftpass;
                next_state <= bgtI6;
            WHEN bgtI6 =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                outregWr <= '1';
                next_state <= bgtI7;
            WHEN bgtI7 =>
                outregRd <= '1';
                next_state <= bgtI8;
            WHEN bgtI8 =>
                outregRd <= '1';
                progcntrWr <= '1';
                addrregWr <= '1';
                next_state <= bgtI9;
            WHEN bgtI9 =>
                vma <= '1';
                rw <= '0';
                next_state <= bgtI10;
            WHEN bgtI10 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    progcntrWr <= '1';
                    next_state <= loadPc;
                ELSE
                    next_state <= bgtI10;
                END IF;

            WHEN inc2 =>
                regSel <= instrReg(2 DOWNTO 0);
                regRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                outregWr <= '1';
                next_state <= inc3;
            WHEN inc3 =>
                outregRd <= '1';
                next_state <= inc4;
            WHEN inc4 =>
                outregRd <= '1';
                regsel <= instrReg(2 DOWNTO 0);
                regWr <= '1';
                next_state <= incPc;

            WHEN loadPc =>
                progcntrRd <= '1';
                next_state <= loadPc2;
            WHEN loadPc2 =>
                progcntrRd <= '1';
                addrRegWr <= '1';
                next_state <= loadPc3;
            WHEN loadPc3 =>
                vma <= '1';
                rw <= '0';
                next_state <= loadPc4;
            WHEN loadPc4 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    instrWr <= '1';
                    next_state <= execute;
                ELSE
                    next_state <= loadPc4;
                END IF;

            WHEN incPc =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                next_state <= incPc2;
            WHEN incPc2 =>
                progcntrRd <= '1';
                alusel <= inc;
                shiftsel <= shftpass;
                outregWr <= '1';
                next_state <= incPc3;
            WHEN incPc3 =>
                outregRd <= '1';
                next_state <= incPc4;
            WHEN incPc4 =>
                outregRd <= '1';
                progcntrWr <= '1';
                addrregWr <= '1';
                next_state <= incPc5;
            WHEN incPc5 =>
                vma <= '1';
                rw <= '0';
                next_state <= incPc6;
            WHEN incPc6 =>
                vma <= '1';
                rw <= '0';
                IF ready = '1' THEN
                    instrWr <= '1';
                    next_state <= execute;
                ELSE
                    next_state <= incPc6;
                END IF;

            WHEN OTHERS =>
                next_state <= incPc;
        END CASE;
    END PROCESS;

    PROCESS
    BEGIN
        IF reset = '1' THEN
            current_state <= reset1;
        ELSIF rising_edge(clock) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

END Behavioral;