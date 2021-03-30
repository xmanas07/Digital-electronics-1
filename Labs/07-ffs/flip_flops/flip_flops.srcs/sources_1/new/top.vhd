----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 18:52:25
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  Port (
        CLK100MHZ   : in  std_logic;
        BTNC        : in  std_logic;
        BTNU        : in  std_logic;
        SW          : in  std_logic_vector(1 - 1 downto 0);
        LED         : out std_logic_vector(4 - 1 downto 0)
   );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

    -- Internal signals between flip-flops
    -- WRITE YOUR CODE HERE
   signal Q0_o :  std_logic;
   signal Q1_o :  std_logic;
   signal Q2_o :  std_logic;
   signal Q3_o :  std_logic;

begin

    --------------------------------------------------------------------
    -- Four instances (copies) of D type FF entity
    d_ff_0 : entity work.d_ff_rst
        port map(
            clk =>  BTNU,
            rst =>  BTNC,                     
            -- WRITE YOUR CODE HERE
            d   =>  SW(0),
            q   =>  Q0_o
        );

    d_ff_1 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d   =>  Q0_o,
            q   =>  Q1_o
        );

    -- WRITE YOUR CODE HERE
    d_ff_2 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d   =>  Q1_o,
            q   =>  Q2_o
        );
        
    d_ff_3 : entity work.d_ff_rst
        port map(
            clk   => BTNU,
            rst   => BTNC,
            -- WRITE YOUR CODE HERE
            d   =>  Q2_o,
            q   =>  Q3_o
        );
    LED(0)    <= Q0_o ;
    LED(1)    <= Q1_o ;
    LED(2)    <= Q2_o ;
    LED(3)    <= Q3_o ;
end architecture Behavioral;