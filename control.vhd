library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port (
        reset      : in  std_logic;   --activo bajo
        sensor_lin : in  std_logic;
        distancias : out std_logic_vector(63 downto 0) --16 numeros de 4 bits
    );
end entity;

architecture behavioral of control is
	  type array16x4 is array (0 to 15) of unsigned(3 downto 0);
    signal distancias_dato : array16x4;

    function min_vecinos(seleccion: integer; distances: array16x4) return unsigned is    -- función para obtener la distancia mínima de los vecinos
		  type array4x4 is array (0 to 3) of unsigned(3 downto 0);
        variable vecinos : array4x4;  -- tienen 4 vecinos cada uno
		  variable vec_min :unsigned(3 downto 0);
    begin
        case seleccion is
            when 0  => vecinos := (distances(1), distances(4), "1111", "1111");
            when 1  => vecinos := (distances(0), distances(2), distances(5), "1111");
            when 2  => vecinos := (distances(1), distances(3), distances(6), "1111");
            when 3  => vecinos := (distances(2), distances(7), "1111", "1111");
            when 4  => vecinos := (distances(0), distances(5), distances(8), "1111");
            when 5  => vecinos := (distances(6), distances(9), distances(4), distances(1));
            when 6  => vecinos := (distances(7), distances(10), distances(5), distances(2));
            when 7  => vecinos := (distances(11), distances(6), distances(3), "1111");
            when 8  => vecinos := (distances(9), distances(12), distances(4), "1111");
            when 9  => vecinos := (distances(10), distances(13), distances(8), distances(5));
            when 10  => vecinos := (distances(11), distances(14), distances(9), distances(6));
            when 11  => vecinos := (distances(15), distances(10), distances(7), "1111");
            when 12  => vecinos := (distances(13), distances(8), "1111", "1111");
            when 13 => vecinos := (distances(14), distances(12), distances(9), "1111");
            when 14  => vecinos := (distances(15), distances(13), distances(10), "1111");
            when others => vecinos := ("1111", "1111", "1111", "1111");
        end case;
			vec_min := "1111";
    for i in 0 to 3 loop --- para encontrar el minimo de lo obtenidos
        if vecinos(i) < vec_min then
            vec_min := vecinos(i);
        end if;
    end loop;

    return vec_min; 
end function;


begin

process(sensor_lin, reset)
begin
     if reset = '0' then
			for i in 0 to 15 loop
              if i = 15 then
                  distancias_dato(i) <= "0000"; -- casilla final la inicializo en 0000
              else
                  distancias_dato(i) <= "1111"; -- todas las demas casillas inicializadas en 15
              end if;
   	  end loop;
      elsif rising_edge(sensor_lin) then
          for i in 0 to 14 loop ---distacias_dato(i) es un unsigned de 3 a 0 //// 
               distancias_dato(i) <= ("0001" + min_vecinos(i, distancias_dato)); --calcula la distancia de cada casilla
          end loop; 
		end if;
end process;
    distancias <= std_logic_vector(distancias_dato(0)) & std_logic_vector(distancias_dato(1)) & "00000000000000000000000000000000000000000000000000000000";--- & distancias_dato(3) & distancias_dato(4) & distancias_dato(5) & distancias_dato(6) & distancias_dato(7) & distancias_dato(8) & distancias_dato(9) & distancias_dato(10) & distancias_dato(11) & distancias_dato(12) & distancias_dato(13) & distancias_dato(14) & distancias_dato(15));
	 
	 end architecture;