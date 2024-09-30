-- ***********************************************************
-- ** PROYECTO PDUA                                         **
-- **   										                        **
-- ** Universidad de Los Andes                              **
-- ** Pontificia Universidad Javeriana                      **
-- **   										                        **
-- ** Rev 0.0 Arq Basica        Mauricio Guerrero   06/2007 **
-- ** Rev 0.1 Microprograma     Mauricio Guerrero           **
-- **         RAM doble puerto  Diego Méndez        11/2007 **
-- ** Rev 0.2 ALU bit-slice     MGH                 03/2008 **
-- ** Rev 0.3 Corrección Doc    DMCH                03/2009 **
-- ** Rev 0.4 ROM-RAM 128       DMCH                11/2009 **
-- ** Rev 0.5 PUSH-POP          DMCH                11/2009 **
-- ** Rev 0.6 Videos-Doc        DMCH                03/2021 **
-- ***********************************************************

-- ***********************************************************
-- Descripcion:                 
--               ______________________________________
--              |                ______   _____        |
--              |               | ROM  | | RAM |       |
--              |               |______| |_____|       |
--              |    _________                         |
--       CLK -->|-->|         |                        |
--     Rst_n -->|-->|  PDUA   |----------------> D_out | 
--       INT -->|-->|         |<---------------- D_in  |    
--              |   |         |----------------> Dir   |    
--              |   |         |----------------> Ctrl  |  
--              |   |_________|                        |
--              |                                      |
--              |______________________________________|  
-- ***********************************************************


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sistema is
    Port ( clk 	: in 	std_logic;
           rst_n 	: in 	std_logic;
           int 	: in 	std_logic
			  );
end sistema;

architecture Behavioral of sistema is

component pdua is
    Port ( clk 	: in 	std_logic;
           rst_n 	: in 	std_logic;
           int 	: in 	std_logic;
           iom 	: out 	std_logic;
           rw 		: out 	std_logic;
           bus_dir 	: out 	std_logic_vector(7 downto 0);
           bus_data_in : in 	std_logic_vector(7 downto 0);
			  bus_data_out : out	std_logic_vector(7 downto 0));
end component;

component ROM is
    Port ( cs,rd,iom	: in std_logic;
           dir 	: in std_logic_vector(6 downto 0);
           data 	: out std_logic_vector(7 downto 0));
end component;

component RAM is
    Port ( cs,rw,iom 	: in 	std_logic;
           dir 	: in 	std_logic_vector(6 downto 0);
           data_in 	: in 	std_logic_vector(7 downto 0);
			  data_out 	: out std_logic_vector(7 downto 0));
end component;

signal rwi,cs_ROM,cs_RAM,iom	: std_logic;
signal datai,datao,diri		: std_logic_vector(7 downto 0);

begin

PROC: pdua 	port map (clk,rst_n,int,iom,rwi,diri,datai,datao);
MROM: ROM  	port map (cs_ROM,rwi,iom,diri(6 downto 0),datai);
MRAM: RAM 	port map (cs_RAM,rwi,iom,diri(6 downto 0),datao,datai);

-- Decodificador
cs_ROM <= not diri(7); 	-- Memoria ROM mapeada en las primeras 128 posiciones (0b00000000-0b01111111) (0x00-0x7F)
cs_RAM <= diri(7); 		-- Memoria RAM mapeada en las segundas 128 posiciones (0b10000000-0b11111111) (0x80-0xFF)

end Behavioral;
