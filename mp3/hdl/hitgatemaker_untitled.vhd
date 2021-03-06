--
-- VHDL Architecture ece411.hitgatemaker.untitled
--
-- Created:
--          by - hwoods2.stdt (gllnx26.ews.illinois.edu)
--          at - 03:07:25 10/08/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY hitgatemaker IS
   PORT( 
      clk     : IN     std_logic;
      dclkout : IN     std_logic;
      hitgate : OUT    std_logic
   );

-- Declarations

END hitgatemaker ;

--
ARCHITECTURE untitled OF hitgatemaker IS
BEGIN
  hitgate <= (not(Clk) AND dclkout);
END ARCHITECTURE untitled;

