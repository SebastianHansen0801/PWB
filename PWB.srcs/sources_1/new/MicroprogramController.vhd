----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2022 03:54:08 PM
-- Design Name: 
-- Module Name: MicroprogramController - Behavioral
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

entity MicroprogramController is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Address_In : in STD_LOGIC_VECTOR (7 downto 0);
           Address_Out : out STD_LOGIC_VECTOR (7 downto 0);
           Instruction_In : in STD_LOGIC_VECTOR (15 downto 0);
           Constant_Out : out STD_LOGIC_VECTOR (7 downto 0);
           V, C, N, Z : in STD_LOGIC;
           DX, AX, BX, FS : out STD_LOGIC_VECTOR (3 downto 0);
           MB, MD, RW, MM, MW : out STD_LOGIC);
end MicroprogramController;

architecture Behavioral of MicroprogramController is

    component InstructionDecoderController is
        Port ( RESET : in STD_LOGIC;
               CLK : in STD_LOGIC;
               IR : in STD_LOGIC_VECTOR (15 downto 0);
               V, C, N, Z : in STD_LOGIC;
               PS : out STD_LOGIC_VECTOR (1 downto 0);
               IL : out STD_LOGIC;
               DX, AX, BX, FS : out STD_LOGIC_VECTOR (3 downto 0);
               MB, MD, RW, MM, MW : out STD_LOGIC);
    end component;
    
    component InstructionRegister is 
        Port ( RESET: in std_logic;
               CLK:  in std_logic;
               Instruction_In: in std_logic_vector(15 downto 0):= "0000000000000000";
               IL: in std_logic:='0';
               IR: out std_logic_vector(15 downto 0));
    end component;
    
    component ProgramCounter is
        Port ( RESET: in std_logic;
               CLK:  in std_logic;
               Address_In: in std_logic_vector(7 downto 0):= "00000000";
               PS: in std_logic_vector(1 downto 0):= "00";
               Offset: in std_logic_vector(7 downto 0):= "00000000";
               PC: out std_logic_vector(7 downto 0));
   end component;
   
   component SignExtender is
        Port ( IR: in std_logic_vector(15 downto 0);
               Extended_8: out std_logic_vector(7 downto 0)); 
   end component;
   
   component ZeroFiller is
        Port ( IR: in std_logic_vector(15 downto 0);
               ZeroFilled_8: out std_logic_vector(7 downto 0));
   end component;
   
   signal PS_int: STD_LOGIC_VECTOR(1 downto 0);
   signal IR_int: STD_LOGIC_VECTOR(15 downto 0);
   signal Offset_int: STD_LOGIC_VECTOR(7 downto 0);
   signal IL_int: STD_LOGIC;

begin

    U0: ProgramCounter port map (RESET => RESET, CLK => CLK, Address_In => Address_In, PC => Address_Out, PS => PS_int, Offset => Offset_int);
    U1: InstructionRegister port map (RESET => RESET, CLK => CLK, IL => IL_int, Instruction_In => Instruction_In, IR => IR_int);
    U2: InstructionDecoderController port map(RESET => RESET, CLK => CLK, V => V, C => C, N => N, Z => Z, IR => IR_int, PS => PS_int, IL => IL_int,
                                              DX => DX, AX => AX, BX => BX, MB => MB, FS => FS, MD => MD, RW => RW, MM => MM, MW => MW);
    U4: SignExtender port map (IR => IR_int, Extended_8 => Offset_int);
    U5: ZeroFiller port map (IR => IR_int, ZeroFilled_8 => Constant_Out);

end Behavioral;
