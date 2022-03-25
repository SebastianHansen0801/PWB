library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignExtender is
    Port (
        IR: in std_logic_vector(15 downto 0);
        Extended_8: out std_logic_vector(7 downto 0)
    );
end SignExtender;

architecture Behavioral of SignExtender is

begin
    
    Extended_8 <= IR(8) & IR(8) & IR(8) & IR(7 downto 6) & IR(2 downto 0);

end Behavioral;
