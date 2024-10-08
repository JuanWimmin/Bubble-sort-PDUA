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

        -- PRIMER NÚMERO
        when "0000011" => data <= "00011000";  -- 0x03 MOV ACC,CTE /Para poner DPTR en 0x80
        when "0000100" => data <= "10000000";  -- 0x04 CTE (0x80)
        when "0000101" => data <= "00101000";  -- 0x05 MOV DPTR,ACC / DPTR=0x80
        when "0000110" => data <= "00011000";  -- 0x06 MOV ACC,CTE / Valor de X 
        when "0000111" => data <= "10000111";  -- 0x07 CTE (0x087) (X=-121)
        when "0001000" => data <= "00110000";  -- 0x08 MOV[DPTR],ACC /Carga el valor de X(0x09) en DPTR=0x80
        
        -- SEGUNDO NÚMERO
        when "0001001" => data <= "00011000";  -- 0x09 MOV ACC,CTE /Para poner DPTR en 0x81
        when "0001010" => data <= "10000001";  -- 0x0A CTE (0x81)
        when "0001011" => data <= "00101000";  -- 0x0B MOV DPTR,ACC / DPTR=0x81
        when "0001100" => data <= "00011000";  -- 0x0C MOV ACC,CTE / Valor de X
        when "0001101" => data <= "00000110";  -- 0x0D CTE (0x06) (X=6)
        when "0001110" => data <= "00110000";  -- 0x0E MOV[DPTR],ACC /Carga el valor de X(0xFE) en DPTR=0x81
        
        -- TERCER NÚMERO
        when "0001111" => data <= "00011000";  -- 0x0F MOV ACC,CTE /Para poner DPTR en 0x82
        when "0010000" => data <= "10000010";  -- 0x10 CTE (0x82)
        when "0010001" => data <= "00101000";  -- 0x11 MOV DPTR,ACC / DPTR=0x82
        when "0010010" => data <= "00011000";  -- 0x12 MOV ACC,CTE / Valor de X
        when "0010011" => data <= "01000101";  -- 0x13 CTE (0x45) (X=69)
        when "0010100" => data <= "00110000";  -- 0x14 MOV[DPTR],ACC /Carga el valor de X(0x05) en DPTR=0x82
        
        -- CUARTO NÚMERO
        when "0010101" => data <= "00011000";  -- 0x15 MOV ACC,CTE /Para poner DPTR en 0x83
        when "0010110" => data <= "10000011";  -- 0x16 CTE (0x83)
        when "0010111" => data <= "00101000";  -- 0x17 MOV DPTR,ACC / DPTR=0x83
        when "0011000" => data <= "00011000";  -- 0x18 MOV ACC,CTE / Valor de X 
        when "0011001" => data <= "11111111";  -- 0x19 CTE (0xFF) (X=-1)
        when "0011010" => data <= "00110000";  -- 0x1A MOV[DPTR],ACC /Carga el valor de X(0x0B) en DPTR=0x83
        
        -- QUINTO NÚMERO
        when "0011011" => data <= "00011000";  -- 0x1B MOV ACC,CTE /Para poner DPTR en 0x84
        when "0011100" => data <= "10000100";  -- 0x1C CTE (0x84)
        when "0011101" => data <= "00101000";  -- 0x1D MOV DPTR,ACC / DPTR=0x84
        when "0011110" => data <= "00011000";  -- 0x1E MOV ACC,CTE / Valor de X 
        when "0011111" => data <= "00000111";  -- 0x1F CTE (0x07) (X=7)
        when "0100000" => data <= "00110000";  -- 0x20 MOV[DPTR],ACC /Carga el valor de X(0x04) en DPTR=0x84
        
        -- SEXTO NÚMERO
        when "0100001" => data <= "00011000";  -- 0x21 MOV ACC,CTE /Para poner DPTR en 0x85
        when "0100010" => data <= "10000101";  -- 0x22 CTE (0x85)
        when "0100011" => data <= "00101000";  -- 0x23 MOV DPTR,ACC / DPTR=0x85
        when "0100100" => data <= "00011000";  -- 0x24 MOV ACC,CTE / Valor de X 
        when "0100101" => data <= "00000010";  -- 0x25 CTE (0x02) (X=2)
        when "0100110" => data <= "00110000";  -- 0x26 MOV[DPTR],ACC /Carga el valor de X(0xC0) en DPTR=0x85
        
        -- SÉPTIMO NÚMERO
        when "0100111" => data <= "00011000";  -- 0x27 MOV ACC,CTE /Para poner DPTR en 0x86
        when "0101000" => data <= "10000110";  -- 0x28 CTE (0x86)
        when "0101001" => data <= "00101000";  -- 0x29 MOV DPTR,ACC / DPTR=0x86
        when "0101010" => data <= "00011000";  -- 0x2A MOV ACC,CTE / Valor de X 
        when "0101011" => data <= "11100000";  -- 0x2B CTE (0xE0) (X=-32)
        when "0101100" => data <= "00110000";  -- 0x2C MOV[DPTR],ACC /Carga el valor de X(0x02) en DPTR=0x86
        
        -- OCTAVO NÚMERO
        when "0101101" => data <= "00011000";  -- 0x2D MOV ACC,CTE /Para poner DPTR en 0x87
        when "0101110" => data <= "10000111";  -- 0x2E CTE (0x87)
        when "0101111" => data <= "00101000";  -- 0x2F MOV DPTR,ACC / DPTR=0x87
        when "0110000" => data <= "00011000";  -- 0x30 MOV ACC,CTE / Valor de X 
        when "0110001" => data <= "00000000";  -- 0x31 CTE (0x00) (X=0)
        when "0110010" => data <= "00110000";  -- 0x32 MOV[DPTR],ACC /Carga el valor de X(0xFC) en DPTR=0x87

		  
		  --====================================================================================================
		  
		  --ORDENAMIENTO DE NUMEROA 
		
		
			-- Implementación corregida de Bubble Sort en ROM (Se inializa el contador del bucle externo)
		 when "0110011" => data <= "00011000";  -- 0x33 MOV ACC,CTE (Contador externo = 7)
		 when "0110100" => data <= "00000111";  -- 0x34 CTE (7) 
		 when "0110101" => data <= "10001000";  -- 0x35 PUSH ACC (Guardar contador externo)

		 -- Inicio del bucle externo(IBI) (Se inicia el contador del bucle interno)
		 when "0110110" => data <= "00011000";  -- IBI: 0x36 MOV ACC,CTE (DPTR = 0x80, inicio de los datos)
		 when "0110111" => data <= "10000000";  -- 0x37 CTE (0x80)
		 when "0111000" => data <= "00101000";  -- 0x38 MOV DPTR,ACC
		 when "0111001" => data <= "00011000";  -- 0x39 MOV ACC,CTE (Contador interno = 7)
		 when "0111010" => data <= "00000111";  -- 0x3A CTE (7) 
		 when "0111011" => data <= "10001000";  -- 0x3B PUSH ACC (Guardar contador interno)

		---------------Inicio del bucle interno---------------------------------
		------Verificación signos
		 when "0111100" => data <= "00100000";  -- 0x3C OUTER_LOOP: MOV ACC,[DPTR] (Saco el primer elemento al ACC)
		 when "0111101" => data <= "00010000";  -- 0x3D MOV A,ACC (Paso el primer elemento al A)
		 when "0111110" => data <= "10101000";  -- 0x3E DPTR+1 (Incremento el DPTR) **NUEVA INSTRUCCION**
		 when "0111111" => data <= "00100000";  -- 0x3F MOV ACC,[DPTR] (Saco el segundo elemento al ACC)
		 when "1000000" => data <= "10111000";  -- 0x40 COMPSIGNED (Determina si los dos elementos tienen el mismo signo)**NUEVA INSTRUCCION**
		 when "1000001" => data <= "01100000";  -- 0x41 JN COMPDIF (Si la bandera N=1, los elementos tienen signos contrarios)
		 when "1000010" => data <= "01001101";  -- 0x42 DIR (COMPDIF)(La comparación para ver que numero es mayor si tienen signos contrarios)
		------Verificación numero mayor (Si son del mismo signo)
		 when "1000011" => data <= "10110000";  -- 0x43 DPTR-1 (Me devuelvo al DPTR)  **Nueva instrucción**
		 when "1000100" => data <= "00100000";  -- 0x44 MOV ACC,[DPTR] (Cargar primer elemento)
		 when "1000101" => data <= "00010000";  -- 0x45 MOV A,ACC (Mueve el primer elemento a A para comparación)
		 when "1000110" => data <= "10101000";  -- 0x46 DPTR+1 (Incrementar DPTR) **Nueva instrucción**
		 when "1000111" => data <= "00100000";  -- 0x47 MOV ACC,[DPTR] (Cargar segundo elemento en ACC)
		 when "1001000" => data <= "10011000";  -- 0x48 CMP ACC,A (Comparar con el primer elemento con el segundo) **Nueva instrucción**
		 when "1001001" => data <= "01100000";  -- 0x49 JN SWAP (Saltar si hay que intercambiar (Si la bandera N=1))
		 when "1001010" => data <= "01010010";  -- 0x4A DIR (SWAP)
		 when "1001011" => data <= "01010000";  -- 0x4B JMP NEXT (Si no hay que intercambiar, continuar)
		 when "1001100" => data <= "01010101";  -- 0x4C DIR (NEXT)
		 
----------------------------------------------------------------------------------------------------------------------------
		  
		-- Rutina de comparación (COMPDIF) (La comparación para ver que numero es mayor si tienen signos contrarios)
		
		 when "1001101" => data <= "11000000";  -- 0x4D COMPDIF: NOT ACC (Niego el segundo elemento) **NUEVA INSTRUCCION**
		 when "1001110" => data <= "01100000";  -- 0x4E JN NEXT (Si la bandera N=1, no se cambian los numeros)
		 when "1001111" => data <= "01010101";  -- 0x4F DIR (NEXT)
		 when "1010000" => data <= "01010000";  -- 0x50 JMP SWAP (Si la bandera N=0, se cambian los numeros)
		 when "1010001" => data <= "01010010";  -- 0x51 DIR (SWAP)
		 
----------------------------------------------------------------------------------------------------------------------------

		-- Rutina de intercambio (SWAP)
		 when "1010010" => data <= "00100000";  -- 0x52 SWAP: MOV ACC,[DPTR] (DPTR+1) (Saco el elemento 2 en ACC)
		 when "1010011" => data <= "10110000";  -- 0x53 DPTR-1 (Me decuelvo al DPTR)  **Nueva instrucción**
		 when "1010100" => data <= "10100000";  -- 0x54 XCHG ACC,[DPTR] (El elemento 1 lo pone en Temp y hace el cambio de los elemento en la memoria de DPTR Y DPTR+1) **Nueva instrucción**
		 
   	-- Continuar bucle interno (NEXT)
		 when "1010101" => data <= "00011000";  -- 0x55 NEXT: MOV ACC,CTE (Cargo un -1 para hacer el decremento del contador interno)
		 when "1010110" => data <= "11111111";  -- 0x56 CTE (-1)
		 when "1010111" => data <= "00010000";  -- 0x57 MOV A,ACC (Paso el -1 a A)
		 when "1011000" => data <= "10010000";  -- 0x58 POP ACC (Saco el contador interno al ACC)
		 when "1011001" => data <= "01001000";  -- 0x59 ADD ACC,A (Decrementar contador interno)
		 when "1011010" => data <= "01011000";  -- 0x5A JZ END_INNER (Salir si contador interno = 0)
		 when "1011011" => data <= "01011111";  -- 0x5B DIR (END_INNER)
		 when "1011100" => data <= "10001000";  -- 0x5C PUSH ACC (Guardar contador interno actualizado)
		 when "1011101" => data <= "01010000";  -- 0x5D JMP INNER_LOOP (Volver al inicio del bucle interno)
		 when "1011110" => data <= "00111100";  -- 0x5E DIR (OUTER_LOOP)
		
	 --------------------Fin del bucle interno (END_INNER)---------------------------------
		 
    --------------------Actualizacion del bucle externo----------------------------------
		 
		 when "1011111" => data <= "00011000";  -- 0x5F END_INNER: MOV ACC,CTE (Cargo un -1 para hacer el decremento del contador externo)
		 when "1100000" => data <= "11111111";  -- 0x60 CTE (-1)
		 when "1100001" => data <= "00010000";  -- 0x61 MOV A, ACC (Paso el -1 a A))
		 when "1100010" => data <= "10010000";  -- 0x62 POP ACC (Recuperar contador externo)
		 when "1100011" => data <= "01001000";  -- 0x63 ADD ACC,A (Decrementar contador externo)
		 when "1100100" => data <= "01011000";  -- 0x64 JZ END_OUTER (Salir si contador externo = 0)
		 when "1100101" => data <= "01101001";  -- 0x65 DIR (END_OUTER)
		 when "1100110" => data <= "10001000";  -- 0x66 PUSH ACC (Guardar contador externo actualizado)
		 when "1100111" => data <= "01010000";  -- 0x67 JMP OUTER_LOOP (Volver al inicio del bucle interno)
		 when "1101000" => data <= "00110110";  -- 0x68 DIR (IBI)
	
 ------------------------Fin del algoritmo (END_OUTER)--------------------------------	
		 when "1101001" => data <= "01010000";  -- 0x69 END_OUTER:FIN: JMP FIN
		 when "1101010" => data <= "01101001";  -- 0x6A DIR(FIN)
		 
		 
		 when "1101011" => data <= "00000000";  -- 0x6B 
		 when "1101100" => data <= "00000000";  -- 0x6C 
		 when "1101101" => data <= "00000000";  -- 0x6D 
		 when "1101110" => data <= "00000000";  -- 0x6E 
		 when "1101111" => data <= "00000000";  -- 0x6F
				 
		 
	 when others => data <= (others => 'X');
        end case;
    else
        data <= (others => 'Z');

end if;  
end process;
end Behavioral;