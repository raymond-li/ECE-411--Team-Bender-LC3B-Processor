-- VHDL Entity ece411.Cache_Datapath.interface
--
-- Created:
--          by - jconroy2.stdt (eelnx39.ews.illinois.edu)
--          at - 20:57:47 10/18/10
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;
USE ieee.NUMERIC_STD.all;

ENTITY Cache_Datapath IS
   PORT( 
      ADDRESS      : IN     LC3b_word;
      DATAOUT      : IN     LC3b_word;
      MREAD_L      : IN     std_logic;
      MWRITEH_L    : IN     std_logic;
      MWRITEL_L    : IN     std_logic;
      clk          : IN     std_logic;
      in_idlehit   : IN     std_logic;
      in_load      : IN     std_logic;
      in_writeback : IN     std_logic;
      pmdatain     : IN     lc3b_oword;
      pmresp_h     : IN     std_logic;
      reset_l      : IN     std_logic;
      DATAIN       : OUT    LC3b_word;
      MRESP_H      : OUT    std_logic;
      dirty        : OUT    std_logic;
      miss         : OUT    std_logic;
      pmaddress    : OUT    lc3b_word;
      pmdataout    : OUT    lc3b_oword
   );

-- Declarations

END Cache_Datapath ;

--
-- VHDL Architecture ece411.Cache_Datapath.struct
--
-- Created:
--          by - jconroy2.stdt (eelnx39.ews.illinois.edu)
--          at - 20:57:47 10/18/10
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

LIBRARY ece411;

ARCHITECTURE struct OF Cache_Datapath IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ADDRTAG         : lc3b_tag;
   SIGNAL ADDRindex       : LC3B_cacheindex;
   SIGNAL ADDRoffset      : LC3B_cacheoffset;
   SIGNAL HitGate         : std_logic;
   SIGNAL LRUout          : std_logic;
   SIGNAL OneSig          : std_logic;
   SIGNAL TAG_COMP0       : std_logic;
   SIGNAL TAG_COMP1       : std_logic;
   SIGNAL Valid0          : std_logic;
   SIGNAL Valid1          : std_logic;
   SIGNAL WAY0Write       : std_logic;
   SIGNAL WAY0WriteANDout : std_logic;
   SIGNAL WAY1Write       : std_logic;
   SIGNAL WAY1WriteANDout : std_logic;
   SIGNAL WAYTAG0         : lc3b_tag;
   SIGNAL WAYTAG1         : lc3b_tag;
   SIGNAL WAY_DATA        : lc3b_oword;
   SIGNAL WAY_DATA0       : LC3b_oword;
   SIGNAL WAY_DATA1       : LC3b_oword;
   SIGNAL WAY_DATAIN      : LC3b_oword;
   SIGNAL WAYout1         : LC3B_Word;
   SIGNAL WAYout2         : LC3B_Word;
   SIGNAL WAYout3         : LC3B_Word;
   SIGNAL WAYout4         : LC3B_Word;
   SIGNAL WAYout5         : LC3B_Word;
   SIGNAL WAYout6         : LC3B_Word;
   SIGNAL WAYout7         : LC3B_Word;
   SIGNAL WAYout8         : LC3B_Word;
   SIGNAL WBADDR          : LC3B_Word;
   SIGNAL WCDATA          : LC3B_oword;
   SIGNAL WriteAccess     : std_logic;
   SIGNAL WriteAccess0    : std_logic;
   SIGNAL WriteAccess1    : std_logic;
   SIGNAL ZeroSig         : std_logic;
   SIGNAL aACCESS         : std_logic;
   SIGNAL d2in_load       : std_logic;
   SIGNAL dirty0          : std_logic;
   SIGNAL dirty0In        : std_logic;
   SIGNAL dirty1          : std_logic;
   SIGNAL dirty1In        : std_logic;
   SIGNAL evictTAG        : LC3B_TAG;
   SIGNAL hit             : std_logic;
   SIGNAL n_LRUout        : std_logic;
   SIGNAL n_in_load       : std_logic;
   SIGNAL prehit0         : std_logic;
   SIGNAL prehit1         : std_logic;
   SIGNAL protohit        : std_logic;
   SIGNAL protomiss       : std_logic;


   -- Component Declarations
   COMPONENT ADDR_COMB
   PORT (
      ADDRindex : IN     LC3B_cacheindex ;
      clk       : IN     std_logic ;
      evictTAG  : IN     LC3B_TAG ;
      WBADDR    : OUT    LC3B_Word 
   );
   END COMPONENT;
   COMPONENT ADDR_SPLITTER
   PORT (
      ADDRESS    : IN     LC3b_word ;
      clk        : IN     std_logic ;
      ADDRTAG    : OUT    lc3b_tag ;
      ADDRindex  : OUT    LC3B_cacheindex ;
      ADDRoffset : OUT    LC3B_cacheoffset 
   );
   END COMPONENT;
   COMPONENT HitGateGenerator
   PORT (
      clk     : IN     std_logic ;
      HitGate : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_AND
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_AND4
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      C : IN     std_logic ;
      D : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_NAND
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_NAND4
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      C : IN     std_logic ;
      D : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_NOT
   PORT (
      A : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LC3_OR
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT LRU
   PORT (
      ADDRindex  : IN     LC3B_cacheindex ;
      RESET_L    : IN     std_logic ;
      LRUWrite   : IN     std_logic ;
      LRU_DATAIN : IN     std_logic ;
      clk        : IN     std_logic ;
      LRUout     : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT Mux2
   PORT (
      A   : IN     std_logic ;
      B   : IN     std_logic ;
      Sel : IN     std_logic ;
      F   : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT OWordMux2
   PORT (
      A   : IN     lc3b_oword ;
      B   : IN     lc3b_oword ;
      Sel : IN     std_logic ;
      F   : OUT    lc3b_oword 
   );
   END COMPONENT;
   COMPONENT One
   PORT (
      clk    : IN     std_logic ;
      OneSig : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT TAGMux2
   PORT (
      A   : IN     LC3B_TAG ;
      B   : IN     LC3B_TAG ;
      Sel : IN     std_logic ;
      F   : OUT    LC3B_TAG 
   );
   END COMPONENT;
   COMPONENT TAG_Comparator
   PORT (
      ADDRTAG  : IN     lc3b_tag ;
      WAYTAG   : IN     lc3b_tag ;
      TAG_COMP : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT WAY
   PORT (
      ADDRTAG      : IN     lc3b_tag ;
      ADDRindex    : IN     lc3b_cacheindex ;
      RESET_L      : IN     std_logic ;
      WAY_DATAIN   : IN     LC3b_oword ;
      WAY_dirtyIn  : IN     std_logic ;
      WAY_validIn  : IN     std_logic ;
      WAY_write    : IN     std_logic ;
      clk          : IN     std_logic ;
      WAY_DATA     : OUT    LC3b_oword ;
      WAY_TAG      : OUT    lc3b_TAG ;
      WAY_dirtyOut : OUT    std_logic ;
      WAY_valid    : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT WordMux2
   PORT (
      A   : IN     LC3b_word ;
      B   : IN     LC3b_word ;
      Sel : IN     std_logic ;
      F   : OUT    LC3b_word 
   );
   END COMPONENT;
   COMPONENT WordMux8
   PORT (
      A   : IN     LC3B_Word ;
      B   : IN     LC3B_Word ;
      C   : IN     LC3B_Word ;
      D   : IN     LC3B_Word ;
      E   : IN     LC3B_Word ;
      F   : IN     LC3B_Word ;
      G   : IN     LC3B_Word ;
      H   : IN     LC3B_Word ;
      Sel : IN     LC3B_CacheOffset ;
      Y   : OUT    LC3B_Word 
   );
   END COMPONENT;
   COMPONENT WriteCombiner
   PORT (
      ADDRoffset : IN     LC3B_cacheoffset ;
      DATAOUT    : IN     LC3b_word ;
      MWRITEH_L  : IN     std_logic ;
      MWRITEL_L  : IN     std_logic ;
      WAY_DATA   : IN     lc3b_oword ;
      clk        : IN     std_logic ;
      WCDATA     : OUT    LC3B_oword 
   );
   END COMPONENT;
   COMPONENT Zero
   PORT (
      clk     : IN     std_logic ;
      ZeroSig : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT delay1
   PORT (
      A   : IN     std_logic ;
      clk : IN     std_logic ;
      dA  : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT oWordSplit
   PORT (
      clk            : IN     std_logic;
      oWordSplitIn   : IN     lc3b_oword;
      oWordSplitout1 : OUT    LC3B_Word;
      oWordSplitout2 : OUT    LC3B_Word;
      oWordSplitout3 : OUT    LC3B_Word;
      oWordSplitout4 : OUT    LC3B_Word;
      oWordSplitout5 : OUT    LC3B_Word;
      oWordSplitout6 : OUT    LC3B_Word;
      oWordSplitout7 : OUT    LC3B_Word;
      oWordSplitout8 : OUT    LC3B_Word
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : ADDR_COMB USE ENTITY ece411.ADDR_COMB;
   FOR ALL : ADDR_SPLITTER USE ENTITY ece411.ADDR_SPLITTER;
   FOR ALL : HitGateGenerator USE ENTITY ece411.HitGateGenerator;
   FOR ALL : LC3_AND USE ENTITY ece411.LC3_AND;
   FOR ALL : LC3_AND4 USE ENTITY ece411.LC3_AND4;
   FOR ALL : LC3_NAND USE ENTITY ece411.LC3_NAND;
   FOR ALL : LC3_NAND4 USE ENTITY ece411.LC3_NAND4;
   FOR ALL : LC3_NOT USE ENTITY ece411.LC3_NOT;
   FOR ALL : LC3_OR USE ENTITY ece411.LC3_OR;
   FOR ALL : LRU USE ENTITY ece411.LRU;
   FOR ALL : Mux2 USE ENTITY ece411.Mux2;
   FOR ALL : OWordMux2 USE ENTITY ece411.OWordMux2;
   FOR ALL : One USE ENTITY ece411.One;
   FOR ALL : TAGMux2 USE ENTITY ece411.TAGMux2;
   FOR ALL : TAG_Comparator USE ENTITY ece411.TAG_Comparator;
   FOR ALL : WAY USE ENTITY ece411.WAY;
   FOR ALL : WordMux2 USE ENTITY ece411.WordMux2;
   FOR ALL : WordMux8 USE ENTITY ece411.WordMux8;
   FOR ALL : WriteCombiner USE ENTITY ece411.WriteCombiner;
   FOR ALL : Zero USE ENTITY ece411.Zero;
   FOR ALL : delay1 USE ENTITY ece411.delay1;
   FOR ALL : oWordSplit USE ENTITY ece411.oWordSplit;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   -- MRESP_H = hit
   MRESP_H <= hit;


   -- Instance port mappings.
   aADDR_COMB : ADDR_COMB
      PORT MAP (
         ADDRindex => ADDRindex,
         clk       => clk,
         evictTAG  => evictTAG,
         WBADDR    => WBADDR
      );
   aADDR_SPLITTER : ADDR_SPLITTER
      PORT MAP (
         ADDRESS    => ADDRESS,
         clk        => clk,
         ADDRTAG    => ADDRTAG,
         ADDRindex  => ADDRindex,
         ADDRoffset => ADDRoffset
      );
   HitGateGen : HitGateGenerator
      PORT MAP (
         clk     => clk,
         HitGate => HitGate
      );
   prehitand0 : LC3_AND
      PORT MAP (
         A => TAG_COMP0,
         B => Valid0,
         F => prehit0
      );
   prehitand1 : LC3_AND
      PORT MAP (
         A => TAG_COMP1,
         B => Valid1,
         F => prehit1
      );
   WAY0WriteAND : LC3_AND4
      PORT MAP (
         A => pmresp_h,
         B => n_LRUout,
         C => HitGate,
         D => in_load,
         F => WAY0WriteANDout
      );
   WAY1WriteAND : LC3_AND4
      PORT MAP (
         A => pmresp_h,
         B => LRUout,
         C => HitGate,
         D => in_load,
         F => WAY1WriteANDout
      );
   Waccess0AND : LC3_AND4
      PORT MAP (
         A => prehit0,
         B => in_idlehit,
         C => HitGate,
         D => WriteAccess,
         F => WriteAccess0
      );
   Waccess1AND : LC3_AND4
      PORT MAP (
         A => WriteAccess,
         B => HitGate,
         C => in_idlehit,
         D => prehit1,
         F => WriteAccess1
      );
   hitAND : LC3_AND4
      PORT MAP (
         A => protohit,
         B => aACCESS,
         C => HitGate,
         D => in_idlehit,
         F => hit
      );
   missAND : LC3_AND4
      PORT MAP (
         A => protomiss,
         B => aACCESS,
         C => HitGate,
         D => in_idlehit,
         F => miss
      );
   WriteAccessNAND : LC3_NAND
      PORT MAP (
         A => MWRITEL_L,
         B => MWRITEH_L,
         F => WriteAccess
      );
   AccessNAND : LC3_NAND4
      PORT MAP (
         A => MREAD_L,
         B => MWRITEH_L,
         C => MWRITEL_L,
         D => MWRITEL_L,
         F => aACCESS
      );
   WAY0WriteNOT : LC3_NOT
      PORT MAP (
         A => LRUout,
         F => n_LRUout
      );
   in_load_delay1 : LC3_NOT
      PORT MAP (
         A => in_load,
         F => n_in_load
      );
   in_load_delay2 : LC3_NOT
      PORT MAP (
         A => n_in_load,
         F => d2in_load
      );
   missNOT : LC3_NOT
      PORT MAP (
         A => protohit,
         F => protomiss
      );
   WAY0WriteOR : LC3_OR
      PORT MAP (
         A => WAY0WriteANDout,
         B => WriteAccess0,
         F => WAY0Write
      );
   WAY1WriteOR : LC3_OR
      PORT MAP (
         A => WAY1WriteANDout,
         B => WriteAccess1,
         F => WAY1Write
      );
   protohitOR : LC3_OR
      PORT MAP (
         A => prehit1,
         B => prehit0,
         F => protohit
      );
   aLRU : LRU
      PORT MAP (
         ADDRindex  => ADDRindex,
         RESET_L    => reset_l,
         LRUWrite   => hit,
         LRU_DATAIN => prehit0,
         clk        => clk,
         LRUout     => LRUout
      );
   dirtyOutMux : Mux2
      PORT MAP (
         A   => dirty0,
         B   => dirty1,
         Sel => LRUout,
         F   => dirty
      );
   WAYDATAMux : OWordMux2
      PORT MAP (
         A   => WAY_DATA0,
         B   => WAY_DATA1,
         Sel => prehit1,
         F   => WAY_DATA
      );
   WAYDATAMux1 : OWordMux2
      PORT MAP (
         A   => WAY_DATA0,
         B   => WAY_DATA1,
         Sel => LRUout,
         F   => pmdataout
      );
   WAY_DATAINMux : OWordMux2
      PORT MAP (
         A   => WCDATA,
         B   => pmdatain,
         Sel => d2in_load,
         F   => WAY_DATAIN
      );
   aOne : One
      PORT MAP (
         clk    => clk,
         OneSig => OneSig
      );
   WAYTAGMux : TAGMux2
      PORT MAP (
         A   => WAYTAG0,
         B   => WAYTAG1,
         Sel => LRUout,
         F   => evictTAG
      );
   TAG0_Comp : TAG_Comparator
      PORT MAP (
         ADDRTAG  => ADDRTAG,
         WAYTAG   => WAYTAG0,
         TAG_COMP => TAG_COMP0
      );
   TAG0_Comp1 : TAG_Comparator
      PORT MAP (
         ADDRTAG  => ADDRTAG,
         WAYTAG   => WAYTAG1,
         TAG_COMP => TAG_COMP1
      );
   WAY0 : WAY
      PORT MAP (
         ADDRTAG      => ADDRTAG,
         ADDRindex    => ADDRindex,
         RESET_L      => reset_l,
         WAY_DATAIN   => WAY_DATAIN,
         WAY_dirtyIn  => dirty0In,
         WAY_validIn  => OneSig,
         WAY_write    => WAY0Write,
         clk          => clk,
         WAY_DATA     => WAY_DATA0,
         WAY_TAG      => WAYTAG0,
         WAY_dirtyOut => dirty0,
         WAY_valid    => Valid0
      );
   WAY1 : WAY
      PORT MAP (
         ADDRTAG      => ADDRTAG,
         ADDRindex    => ADDRindex,
         RESET_L      => reset_l,
         WAY_DATAIN   => WAY_DATAIN,
         WAY_dirtyIn  => dirty1In,
         WAY_validIn  => OneSig,
         WAY_write    => WAY1Write,
         clk          => clk,
         WAY_DATA     => WAY_DATA1,
         WAY_TAG      => WAYTAG1,
         WAY_dirtyOut => dirty1,
         WAY_valid    => Valid1
      );
   PMADDRMux : WordMux2
      PORT MAP (
         A   => ADDRESS,
         B   => WBADDR,
         Sel => in_writeback,
         F   => pmaddress
      );
   WAYWordMux : WordMux8
      PORT MAP (
         A   => WAYout1,
         B   => WAYout2,
         C   => WAYout3,
         D   => WAYout4,
         E   => WAYout5,
         F   => WAYout6,
         G   => WAYout7,
         H   => WAYout8,
         Sel => ADDRoffset,
         Y   => DATAIN
      );
   aWriteCombiner : WriteCombiner
      PORT MAP (
         ADDRoffset => ADDRoffset,
         DATAOUT    => DATAOUT,
         MWRITEH_L  => MWRITEH_L,
         MWRITEL_L  => MWRITEL_L,
         WAY_DATA   => WAY_DATA,
         clk        => clk,
         WCDATA     => WCDATA
      );
   aZero : Zero
      PORT MAP (
         clk     => clk,
         ZeroSig => ZeroSig
      );
   Waccess0delay : delay1
      PORT MAP (
         A   => WriteAccess0,
         clk => clk,
         dA  => dirty0In
      );
   Waccess1delay : delay1
      PORT MAP (
         A   => WriteAccess1,
         clk => clk,
         dA  => dirty1In
      );
   WAYSplit : oWordSplit
      PORT MAP (
         clk            => clk,
         oWordSplitIn   => WAY_DATA,
         oWordSplitout1 => WAYout1,
         oWordSplitout2 => WAYout2,
         oWordSplitout3 => WAYout3,
         oWordSplitout4 => WAYout4,
         oWordSplitout5 => WAYout5,
         oWordSplitout6 => WAYout6,
         oWordSplitout7 => WAYout7,
         oWordSplitout8 => WAYout8
      );

END struct;
