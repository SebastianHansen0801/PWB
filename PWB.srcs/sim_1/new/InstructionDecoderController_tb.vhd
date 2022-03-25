-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity InstructionDecoderController_tb is
end;

architecture bench of InstructionDecoderController_tb is

  component InstructionDecoderController
      Port ( RESET : in STD_LOGIC;
             CLK : in STD_LOGIC;
             IR : in STD_LOGIC_VECTOR (15 downto 0);
             V, C, N, Z : in STD_LOGIC;
             PS : out STD_LOGIC_VECTOR (1 downto 0);
             IL : out STD_LOGIC;
             DX, AX, BX, FS : out STD_LOGIC_VECTOR (3 downto 0);
             MB, MD, RW, MM, MW : out STD_LOGIC);
  end component;

  signal RESET: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal IR: STD_LOGIC_VECTOR (15 downto 0);
  signal V, C, N, Z: STD_LOGIC;
  signal PS: STD_LOGIC_VECTOR (1 downto 0);
  signal IL: STD_LOGIC;
  signal DX, AX, BX, FS: STD_LOGIC_VECTOR (3 downto 0);
  signal MB, MD, RW, MM, MW: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: InstructionDecoderController port map ( RESET => RESET,
                                               CLK   => CLK,
                                               IR    => IR,
                                               V     => V,
                                               C     => C,
                                               N     => N,
                                               Z     => Z,
                                               PS    => PS,
                                               IL    => IL,
                                               DX    => DX,
                                               AX    => AX,
                                               BX    => BX,
                                               FS    => FS,
                                               MB    => MB,
                                               MD    => MD,
                                               RW    => RW,
                                               MM    => MM,
                                               MW    => MW );

  stimulus: process
  begin
  
    -- Put initialisation code here
    IR <= "0000000100010001";
    V <= '0';
    C <= '0';
    N <= '0';
    Z <= '0';

    RESET <= '1';
    wait for 5 ns;
    RESET <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here
    IR <= "0000001100010001";
    wait for clock_period*2;
    IR <= "0010001100010001";
    wait for clock_period*3;
    IR <= "0001101100010001";
    wait for clock_period*5;
    Z <= '1';
    wait for clock_period*2;

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