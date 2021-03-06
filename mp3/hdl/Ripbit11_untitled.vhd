--
-- VHDL Architecture ece411.Ripbit11.untitled
--
-- Created:
--          by - hwoods2.stdt (eelnx38.ews.illinois.edu)
--          at - 16:44:39 09/12/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY Ripbit11 IS
   PORT( 
      clk         : IN     std_logic;
      instruction : IN     LC3b_word;
      RipBit11out : OUT    std_logic
   );

-- Declarations

END Ripbit11 ;

--
ARCHITECTURE untitled OF Ripbit11 IS
BEGIN
  RipBit11out <= instruction(11);
END ARCHITECTURE untitled;

