library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( cs, rd, iom : in std_logic;
           dir         : in std_logic_vector(6 downto 0);
           data        : out std_logic_vector(7 downto 0));
end ROM;


architecture Behavioral of ROM is
begin
process(cs, rd, dir)
begin
if cs = '1' and rd = '0' and iom = '1' then
       case dir is
       when "0000000" => data <= "01010000";  -- 0x00 JMP MAIN
       when "0000001" => data <= "00000011";  -- 0x01 MAIN (0x03)
       when "0000010" => data <= "00011000";  -- 0x02 RAI Vector de Interrupcion (apunta a la ISR)

       -- Inicializar los 8 números en RAM
		
		-- PRIMER NUMERO
       when "0000011" => data <= "00011000";  -- 0x03 MOV ACC,CTE /Para poner DPTR en 0x80
       when "0000100" => data <= "10000000";  -- 0x04 CTE (0x80)
	    when "0000101" => data <= "00101000";  -- 0x05 MOV DPTR,ACC / DPTR=0x80
	    when "0000110" => data <= "00011000";  -- 0x06 MOV ACC,CTE / Valor de X
	    when "0000111" => data <= "00001001";  -- 0x07 CTE (0x09) (X=9)
	    when "0001000" => data <= "00110000";  -- 0x08 MOV[DPTR],ACC /Carga el valor de X(0x05) en DPTR=0x80
		 
		 -- SEGUNDO NUMERO
       when "0001001" => data <= "00011000";  -- 0x09 MOV ACC,CTE /Para poner DPTR en 0x81
       when "0001010" => data <= "10000001";  -- 0x0A CTE (0x81)
	    when "0001011" => data <= "00101000";  -- 0x0B MOV DPTR,ACC / DPTR=0x81
	    when "0001100" => data <= "00011000";  -- 0x0C MOV ACC,CTE / Valor de X
	    when "0001101" => data <= "11111110";  -- 0x0D CTE (0xFE) (X=-2)
	    when "0001110" => data <= "00110000";  -- 0x0E MOV[DPTR],ACC /Carga el valor de X(0xFE) en DPTR=0x81
		 
		 -- TERCER NUMERO
       when "0001111" => data <= "00011000";  -- 0x09 MOV ACC,CTE /Para poner DPTR en 0x82
       when "0010000" => data <= "10000010";  -- 0x0A CTE (0x82)
	    when "0010001" => data <= "00101000";  -- 0x0B MOV DPTR,ACC / DPTR=0x81
	    when "0010010" => data <= "00011000";  -- 0x0C MOV ACC,CTE / Valor de X
	    when "0010011" => data <= "00000101";  -- 0x0D CTE (0x05) (X=5)
	    when "0010100" => data <= "00110000";  -- 0x0E MOV[DPTR],ACC /Carga el valor de X(0x05) en DPTR=0x82
		 
		 -- TERCER NUMERO
       when "0010101" => data <= "00011000";  -- 0x09 MOV ACC,CTE /Para poner DPTR en 0x83
       when "0010110" => data <= "10000011";  -- 0x0A CTE (0x83)
	    when "0010111" => data <= "00101000";  -- 0x0B MOV DPTR,ACC / DPTR=0x83
	    when "0011000" => data <= "00011000";  -- 0x0C MOV ACC,CTE / Valor de X
	    when "0011001" => data <= "00000101";  -- 0x0D CTE (0x05) (X=5)
	    when "0011010" => data <= "00110000";  -- 0x0E MOV[DPTR],ACC /Carga el valor de X(0x05) en DPTR=0x83
		 
		 
		 
		--ORDENAMIENTO DE NUMEROA 
		
		
			-- Implementación corregida de Bubble Sort en ROM
		when "0011011" => data <= "00011000";  -- MOV ACC,CTE (Contador externo = 7)
		when "0011100" => data <= "00000111";  -- CTE (7)
		when "0011101" => data <= "10001000";  -- PUSH ACC (Guardar contador externo)

		-- Inicio del bucle externo
		when "0011110" => data <= "00011000";  -- MOV ACC,CTE (DPTR = 0x80, inicio de los datos)
		when "0011111" => data <= "10000000";  -- CTE (0x80)
		when "0100000" => data <= "00101000";  -- MOV DPTR,ACC
		when "0100001" => data <= "00011000";  -- MOV ACC,CTE (Contador interno = 7)
		when "0100010" => data <= "00000111";  -- CTE (7)
		when "0100011" => data <= "10001000";  -- PUSH ACC (Guardar contador interno)

		-- Inicio del bucle interno
		when "0100100" => data <= "00100000";  -- MOV ACC,[DPTR] (Cargar primer elemento)
		when "0100101" => data <= "00001000";  -- MOV A,ACC (Mover a A para comparación)
		when "0100110" => data <= "00011000";  -- MOV ACC,CTE (Incrementar DPTR)
		when "0100111" => data <= "00000001";  -- CTE (1)
		when "0101000" => data <= "01001000";  -- ADD ACC,A (DPTR + 1)
		when "0101001" => data <= "00101000";  -- MOV DPTR,ACC
		when "0101010" => data <= "00100000";  -- MOV ACC,[DPTR] (Cargar segundo elemento)
		when "0101011" => data <= "10011000";  -- CMP ACC,A (Comparar con el primer elemento)
		when "0101100" => data <= "01100000";  -- JN SWAP (Saltar si hay que intercambiar)
		when "0101101" => data <= "00110000";   -- DIR (SWAP)
		when "0101110" => data <= "01010000";  -- JMP NEXT (Si no hay que intercambiar, continuar)
		when "0101111" => data <= "00110110";   -- DIR (NEXT)

		-- Rutina de intercambio (SWAP)
		when "0110000" => data <= "10100000";  -- XCHG ACC,[DPTR] (Intercambiar segundo elemento)
		when "0110001" => data <= "00011000";  -- MOV ACC,CTE (Decrementar DPTR)
		when "0110010" => data <= "11111111";  -- CTE (-1)
		when "0110011" => data <= "01001000";  -- ADD ACC,A (DPTR - 1)
		when "0110100" => data <= "00101000";  -- MOV DPTR,ACC
		when "0110101" => data <= "10100000";  -- XCHG ACC,[DPTR] (Intercambiar primer elemento)

		-- Continuar bucle interno (NEXT)
		when "0110110" => data <= "00011000";  -- MOV ACC,CTE (Incrementar DPTR para siguiente comparación)
		when "0110111" => data <= "00000001";  -- CTE (1)
		when "0111000" => data <= "01001000";  -- ADD ACC,A (DPTR + 1)
		when "0111001" => data <= "00101000";  -- MOV DPTR,ACC
		when "0111010" => data <= "10010000";  -- POP ACC (Recuperar contador interno)
		when "0111011" => data <= "00011000";  -- MOV ACC,CTE
		when "0111100" => data <= "11111111";  -- CTE (-1)
		when "0111101" => data <= "01001000";  -- ADD ACC,A (Decrementar contador interno)
		when "0111110" => data <= "01011000";  -- JZ END_INNER (Salir si contador interno = 0)
		when "0111111" => data <= "01000011";   -- DIR (END_INNER)
		when "1000000" => data <= "10001000";  -- PUSH ACC (Guardar contador interno actualizado)
		when "1000001" => data <= "01010000";  -- JMP INNER_LOOP (Volver al inicio del bucle interno)
		when "1000010" => data <= "00100100";   -- DIR (INNER_LOOP)

		-- Fin del bucle interno (END_INNER)
		when "1000011" => data <= "10010000";  -- POP ACC (Limpiar la pila)
		when "1000100" => data <= "10010000";  -- POP ACC (Recuperar contador externo)
		when "1000101" => data <= "00011000";  -- MOV ACC,CTE
		when "1000110" => data <= "11111111";  -- CTE (-1)
		when "1000111" => data <= "01001000";  -- ADD ACC,A (Decrementar contador externo)
		when "1001000" => data <= "01011000";  -- JZ END_OUTER (Salir si contador externo = 0)
		when "1001001" => data <= "01001101";   -- DIR (END_OUTER)
		when "1001010" => data <= "10001000";  -- PUSH ACC (Guardar contador externo actualizado)
		when "1001011" => data <= "01010000";  -- JMP OUTER_LOOP (Volver al inicio del bucle externo)
		when "1001100" => data <= "00011110";   -- DIR (OUTER_LOOP)

		-- Fin del algoritmo (END_OUTER)
		when "1001101" => data <= "01010000";  -- JMP FIN
		when "1001110" => data <= "01001101";   -- DIR (FIN)
				 
		 
	 when others => data <= (others => 'X');
        end case;
    else
        data <= (others => 'Z');

end if;  
end process;
end Behavioral;

