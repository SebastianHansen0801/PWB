----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2022 01:48:50 PM
-- Design Name: 
-- Module Name: InstructionDecoderController - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionDecoderController is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           IR : in STD_LOGIC_VECTOR (15 downto 0);
           V, C, N, Z : in STD_LOGIC;
           PS : out STD_LOGIC_VECTOR (1 downto 0);
           IL : out STD_LOGIC;
           DX, AX, BX, FS : out STD_LOGIC_VECTOR (3 downto 0);
           MB, MD, RW, MM, MW : out STD_LOGIC);
end InstructionDecoderController;

architecture Behavioral of InstructionDecoderController is

    type StateType is (INF, EX0, EX1, EX2, EX3, EX4, RST);
    signal State, NextState: StateType;
    signal opcode: STD_LOGIC_VECTOR(6 downto 0);
    signal DX_int, AX_int, BX_int: STD_LOGIC_VECTOR(2 downto 0);
    

begin

        stateReg: process(RESET, CLK)
        begin
            if RESET = '1' then
                State <= RST;
            elsif CLK'event  and CLK = '1' then
                State <= NextState;
            end if;
        end process;
        
        stateDec: process(State, IR, N, Z)
        begin
            Case State is
                when RST =>
                    IL <= '0';
                    PS <= "00";
                    DX <= "0000"; AX <= "0000"; BX <= "0000";
                    MB <= '0';
                    Fs <= "0000";
                    MD <= '0';
                    RW <= '0';
                    MM <= '0';
                    MW <= '0';
                    
                    NextState <= INF;
                
                when INF =>
                    opcode <= IR(15 downto 9);
                    DX_int <= IR(8 downto 6);
                    AX_int <= IR(5 downto 3);
                    BX_int <= IR(2 downto 0);
                
                    IL <= '1';
                    PS <= "00";
                    DX <= '-' & DX_int; AX <= '-' & AX_int; BX <= '-' & BX_int;
                    MB <= '-';
                    Fs <= "----";
                    MD <= '-';
                    RW <= '0';
                    MM <= '1';
                    MW <= '0';
                    
                    NextState <= EX0;
                    
                when EX0 =>
                    if opcode = "0000000" then -- MOVA
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0000001" then -- INC
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0001";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0000010" then -- ADD
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "0010";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                            
                        NextState <= INF;
                    elsif opcode = "0000101" then -- SUB
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "0101";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0000110" then -- DEC
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0110";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001000" then -- OR
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "1000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001001" then -- AND
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "1001";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001010" then -- XOR
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "1010";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001011" then -- NOT
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "1011";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001100" then -- MOVB
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '-' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "1100";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0010000" then -- LD
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "----";
                        MD <= '1';
                        RW <= '1';
                        MM <= '0';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0100000" then -- ST
                        IL <= '0';
                        PS <= "01";
                        DX <= '-' & DX_int; AX <= '0' & AX_int; BX <= '0' & BX_int;
                        MB <= '0';
                        Fs <= "----";
                        MD <= '-';
                        RW <= '0';
                        MM <= '0';
                        MW <= '1';
                        
                        NextState <= INF;
                    elsif opcode = "1001100" then -- LDI
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '-' & AX_int; BX <= '-' & BX_int;
                        MB <= '1';
                        Fs <= "1100";
                        MD <= '0';
                        RW <= '1';
                        MM <= '0';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "1000010" then -- ADI
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '1';
                        Fs <= "0010";
                        MD <= '0';
                        RW <= '1';
                        MM <= '0';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "1100000" then -- BRZ
                        IL <= '0';
                        DX <= '-' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '-';
                        RW <= '0';
                        MM <= '0';
                        MW <= '0';
                       
                        if Z = '1' then PS <= "10"; else PS <= "01"; end if;
                        NextState <= INF;
                    elsif opcode = "1100001" then -- BRN
                        IL <= '0';
                        DX <= '-' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '-';
                        RW <= '0';
                        MM <= '0';
                        MW <= '0';
                       
                        if N = '1' then PS <= "10"; else PS <= "01"; end if;
                        NextState <= INF;
                    elsif opcode = "1110000" then -- JMP
                        IL <= '0';
                        PS <= "11";
                        DX <= '-' & DX_int; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '-';
                        RW <= '0';
                        MM <= '0';
                        MW <= '0';
                       
                        NextState <= INF;
                    elsif opcode = "0010001" then -- LRI
                        IL <= '0';
                        PS <= "00";
                        DX <= "1000"; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '1';
                        RW <= '1';
                        MM <= '0';
                        MW <= '0';
                       
                        NextState <= EX1;
                    elsif opcode = "0001101" then -- SRM
                        IL <= '0';
                        DX <= "1000"; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then
                            PS <= "01";
                            NextState <= INF;
                        else
                            PS <= "00";
                            NextState <= EX1;
                        end if;
                    elsif opcode = "0001110" then -- SLM
                        IL <= '0';
                        DX <= "1000"; AX <= '0' & AX_int; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then
                            PS <= "01";
                            NextState <= INF;
                        else
                            PS <= "00";
                            NextState <= EX1;
                        end if;
                    end if;
                    
                when EX1 =>
                    if opcode = "0010001" then -- LRI
                        IL <= '0';
                        PS <= "01";
                        DX <= '0' & DX_int; AX <= "1000"; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0000";
                        MD <= '1';
                        RW <= '1';
                        MM <= '0';
                        MW <= '0';
                       
                        NextState <= INF;
                    elsif opcode = "0001101" then -- SRM
                        IL <= '0';
                        DX <= "1001"; AX <= '-' & AX_int; BX <= '-' & BX_int;
                        MB <= '1';
                        Fs <= "1100";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then
                            PS <= "01";
                            NextState <= INF;
                        else
                            PS <= "00";
                            NextState <= EX2;
                        end if;
                    elsif opcode = "0001110" then -- SLM
                        IL <= '0';
                        DX <= "1001"; AX <= '-' & AX_int; BX <= '-' & BX_int;
                        MB <= '1';
                        Fs <= "1100";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then
                            PS <= "01";
                            NextState <= INF;
                        else
                            PS <= "00";
                            NextState <= EX2;
                        end if;
                    end if;
                
                when EX2 =>
                    if opcode = "0001101" then -- SRM
                        IL <= '0';
                        PS <= "00";
                        DX <= "1000"; AX <= '-' & AX_int; BX <= "1000";
                        MB <= '0';
                        FS <= "1101";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= EX3;
                    elsif opcode = "0001110" then -- SLM
                        IL <= '0';
                        PS <= "00";
                        DX <= "1000"; AX <= '-' & AX_int; BX <= "1000";
                        MB <= '0';
                        FS <= "1110";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= EX3;
                    end if;
                    
                when EX3 =>
                    if opcode = "0001101" then -- SRM
                        IL <= '0';
                        PS <= "00";
                        DX <= "1001"; AX <= "1001"; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0110";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then NextState <= EX4; else NextState <= EX2; end if;
                    elsif opcode = "0001110" then -- SLM
                        IL <= '0';
                        PS <= "00";
                        DX <= "1001"; AX <= "1001"; BX <= '-' & BX_int;
                        MB <= '-';
                        Fs <= "0110";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        if Z = '1' then NextState <= EX4; else NextState <= EX2; end if;
                    end if;

                when EX4 =>
                    if opcode = "0001101" then -- SRM
                        IL <= '0';
                        PS <= "00";
                        DX <= '0' & DX_int; AX <= "1000"; BX <= '-' & BX_int;
                        MB <= '-';
                        FS <= "0000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    elsif opcode = "0001110" then -- SLM
                        IL <= '0';
                        PS <= "00";
                        DX <= '0' & DX_int; AX <= "1000"; BX <= '-' & BX_int;
                        MB <= '-';
                        FS <= "0000";
                        MD <= '0';
                        RW <= '1';
                        MM <= '-';
                        MW <= '0';
                        
                        NextState <= INF;
                    end if;
            end case;
        end process;

end Behavioral;


