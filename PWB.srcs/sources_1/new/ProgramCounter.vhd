library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
    Port (
        RESET: in std_logic;
        CLK:  in std_logic;
        Address_In: in std_logic_vector(7 downto 0):= "00000000";
        PS: in std_logic_vector(1 downto 0):= "00";
        Offset: in std_logic_vector(7 downto 0):= "00000000";
        PC: out std_logic_vector(7 downto 0)
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is

    signal counter: std_logic_vector(7 downto 0) := "00000000";

begin
    
    count_register: process (CLK, RESET)
    begin
    
        if (RESET = '1') then counter <= X"00"; -- async reset
        
        elsif (CLK'event and CLK = '1') then -- on rising edge
            
            if(PS = "01") then counter <= counter + 1;
            elsif (PS = "10") then counter <= counter + Offset;
            elsif (PS = "11") then counter <= Address_In;
            
            else counter <= counter;
            
            end if;
      
        end if;
        
    end process;
    
    PC <= counter;

end Behavioral;
