library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity distancia_lab is
    port (
        reset      : in  std_logic;   --activo bajo
        sensor_lin : in  std_logic;
        distancia_0, distancia_1, distancia_2, distancia_3, distancia_4, distancia_5, distancia_6, distancia_7, distancia_8, distancia_9, distancia_10, distancia_11, distancia_12, distancia_13, distancia_14, distancia_15: out std_logic_vector(3 downto 0)
    );  --16 numeros de 4 bits (seria la distancia de cada casillero)
end entity;

architecture behavioral of distancia_lab is
    signal         axuliar, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7, dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11, dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15: std_logic_vector(3 downto 0);

    function min_vecinos(  -- función para obtener la distancia mínima de los vecinos
			seleccion: integer;
			distances_0, distances_1, distances_2, distances_3, distances_4, distances_5, distances_6, distances_7, distances_8, distances_9, distances_10, distances_11, distances_12, distances_13, distances_14, distances_15 :std_logic_vector(3 downto 0)) return unsigned is    
		  type array4x4 is array (0 to 3) of unsigned(3 downto 0);
        variable vecinos : array4x4;         -- tienen 4 vecinos cada uno
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
        for i in 0 to 15 loop
            case i is
                when 0  =>
                    auxiliar := min_vecinos(0, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_0 <= std_logic_vector("0001" + auxiliar);
                when 1  =>
                    auxiliar := min_vecinos(1, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_1 <= std_logic_vector("0001" + auxiliar);
                when 2  =>
                    auxiliar := min_vecinos(2, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_2 <= std_logic_vector("0001" + auxiliar);
                when 3  =>
                    auxiliar := min_vecinos(3, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_3 <= std_logic_vector("0001" + auxiliar);
                when 4  =>
                    auxiliar := min_vecinos(4, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_4 <= std_logic_vector("0001" + auxiliar);
                when 5  =>
                    auxiliar := min_vecinos(5, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_5 <= std_logic_vector("0001" + auxiliar);
                when 6  =>
                    auxiliar := min_vecinos(6, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_6 <= std_logic_vector("0001" + auxiliar);
                when 7  =>
                    auxiliar := min_vecinos(7, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_7 <= std_logic_vector("0001" + auxiliar);
                when 8  =>
                    auxiliar := min_vecinos(8, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_8 <= std_logic_vector("0001" + auxiliar);
                when 9  =>
                    auxiliar := min_vecinos(9, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_9 <= std_logic_vector("0001" + auxiliar);
                when 10 =>
                    auxiliar := min_vecinos(10, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_10 <= std_logic_vector("0001" + auxiliar);
                when 11 =>
                    auxiliar := min_vecinos(11, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_11 <= std_logic_vector("0001" + auxiliar);
                when 12 =>
                    auxiliar := min_vecinos(12, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_12 <= std_logic_vector("0001" + auxiliar);
                when 13 =>
                    auxiliar := min_vecinos(13, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_13 <= std_logic_vector("0001" + auxiliar);
                when 14 =>
                    auxiliar := min_vecinos(14, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_14 <= std_logic_vector("0001" + auxiliar);
                when 15 =>
                    auxiliar := min_vecinos(15, dato_distancia_0, dato_distancia_1, dato_distancia_2, dato_distancia_3, 
                                            dato_distancia_4, dato_distancia_5, dato_distancia_6, dato_distancia_7,
                                            dato_distancia_8, dato_distancia_9, dato_distancia_10, dato_distancia_11,
                                            dato_distancia_12, dato_distancia_13, dato_distancia_14, dato_distancia_15);
                    distancias_dato_15 <= std_logic_vector("0001" + auxiliar);
                when others => null; -- esto está chequeado?
            end case;
        end loop;
    end if;
end process;
	
	 end architecture;