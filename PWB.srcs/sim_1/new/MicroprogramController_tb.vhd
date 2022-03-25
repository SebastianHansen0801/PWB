-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MicroprogramController_tb is
end;

architecture bench of MicroprogramController_tb is

  component MicroprogramController
      Port ( RESET : in STD_LOGIC;
             CLK : in STD_LOGIC;
             Address_In : in STD_LOGIC_VECTOR (7 downto 0);
             Address_Out : out STD_LOGIC_VECTOR (7 downto 0);
             Instruction_In : in STD_LOGIC_VECTOR (15 downto 0);
             Constant_Out : out STD_LOGIC_VECTOR (7 downto 0);
             V, C, N, Z : in STD_LOGIC;
             DX, AX, BX, FS : out STD_LOGIC_VECTOR (3 downto 0);
             MB, MD, RW, MM, MW : out STD_LOGIC);
  end component;

  signal RESET: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal Address_In: STD_LOGIC_VECTOR (7 downto 0);
  signal Address_Out: STD_LOGIC_VECTOR (7 downto 0);
  signal Instruction_In: STD_LOGIC_VECTOR (15 downto 0);
  signal Constant_Out: STD_LOGIC_VECTOR (7 downto 0);
  signal V, C, N, Z: STD_LOGIC;
  signal DX, AX, BX, FS: STD_LOGIC_VECTOR (3 downto 0);
  signal MB, MD, RW, MM, MW: STD_LOGIC;
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: MicroprogramController port map ( RESET          => RESET,
                                         CLK            => CLK,
                                         Address_In     => Address_In,
                                         Address_Out    => Address_Out,
                                         Instruction_In => Instruction_In,
                                         Constant_Out   => Constant_Out,
                                         V              => V,
                                         C              => C,
                                         N              => N,
                                         Z              => Z,
                                         DX             => DX,
                                         AX             => AX,
                                         BX             => BX,
                                         FS             => FS,
                                         MB             => MB,
                                         MD             => MD,
                                         RW             => RW,
                                         MM             => MM,
                                         MW             => MW );

  stimulus: process
  begin
  
    -- Put initialisation code here
    V <= '0';
    C <= '0';
    N <= '0';
    Z <= '0';
    Instruction_In <= "0000000000000000";
    Address_In <= "01010101";


    RESET <= '1';
    wait for 5 ns;
    RESET <= '0';
    wait for 5 ns;
    
    -- Put test bench stimulus code here
    wait for clock_period*5;
    Instruction_In <= "0001101100010001";
    wait for clock_period*5;
    Z <= '1';
    wait for clock_period*2;
    Instruction_In <= "0000000000000000";
    Z <= '1';
    
    stop_the_clock <= true;
    wait;
  end process;
  
  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


end;