library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionRegister is
    Port (
        RESET: in std_logic;
        CLK:  in std_logic;
        Instruction_In: in std_logic_vector(15 downto 0):= "0000000000000000";
        IL: in std_logic:='0';
        IR: out std_logic_vector(15 downto 0)
    );
end InstructionRegister;

architecture Behavioral of InstructionRegister is

    signal instruction_val: std_logic_vector(15 downto 0);

begin

    instruction_load: process (CLK, RESET)
    begin
    
        if (RESET = '1') then instruction_val <= X"0000"; -- async reset
        
        elsif (CLK'event and CLK = '1') then -- on rising edge
            
            if(IL = '1') then 
                instruction_val <= Instruction_In; -- load instruction to signal
            end if;
            
            else instruction_val <= instruction_val;
      
        end if;
        
    end process;
    
    IR <= instruction_val; -- load signal to IR
    
end Behavioral;
