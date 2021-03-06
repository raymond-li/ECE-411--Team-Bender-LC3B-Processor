--
-- VHDL Architecture ece411.RipBit6.untitled
--
-- Created:
--          by - hwoods2.stdt (eelnx34.ews.illinois.edu)
--          at - 19:23:54 09/10/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY RipBit5 IS
   PORT( 
      clk        : IN     std_logic;
      index6     : IN     LC3b_index6;
      RipBit4out : OUT    std_logic;
      RipBit5out : OUT    std_logic
   );

-- Declarations

END RipBit5 ;

--
ARCHITECTURE untitled OF RipBit5 IS
BEGIN
  RipBit5out <= index6(5);
  RipBit4out <= index6(4);
END ARCHITECTURE untitled;

