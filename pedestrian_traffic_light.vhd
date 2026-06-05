library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pedestrian_traffic_light is
    Port (
        clk             : in  STD_LOGIC;
        reset           : in  STD_LOGIC;
        button          : in  STD_LOGIC;

        car_red         : out STD_LOGIC;
        car_yellow      : out STD_LOGIC;
        car_green       : out STD_LOGIC;

        ped_red         : out STD_LOGIC;
        ped_green       : out STD_LOGIC
    );
end pedestrian_traffic_light;

architecture Behavioral of pedestrian_traffic_light is

    type state_type is (
        S0_CAR_GREEN,
        S1_CAR_YELLOW,
        S2_PED_GREEN,
        S3_ALL_RED
    );

    signal current_state : state_type := S0_CAR_GREEN;
    signal counter       : integer := 0;

    constant YELLOW_TIME : integer := 3;
    constant PED_TIME    : integer := 5;
    constant ALLRED_TIME : integer := 2;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0_CAR_GREEN;
            counter <= 0;

        elsif rising_edge(clk) then

            case current_state is

                when S0_CAR_GREEN =>
                    counter <= 0;

                    if button = '1' then
                        current_state <= S1_CAR_YELLOW;
                    end if;

                when S1_CAR_YELLOW =>
                    if counter < YELLOW_TIME then
                        counter <= counter + 1;
                    else
                        counter <= 0;
                        current_state <= S2_PED_GREEN;
                    end if;

                when S2_PED_GREEN =>
                    if counter < PED_TIME then
                        counter <= counter + 1;
                    else
                        counter <= 0;
                        current_state <= S3_ALL_RED;
                    end if;

                when S3_ALL_RED =>
                    if counter < ALLRED_TIME then
                        counter <= counter + 1;
                    else
                        counter <= 0;
                        current_state <= S0_CAR_GREEN;
                    end if;

            end case;
        end if;
    end process;

    process(current_state)
    begin
        car_red    <= '0';
        car_yellow <= '0';
        car_green  <= '0';
        ped_red    <= '0';
        ped_green  <= '0';

        case current_state is

            when S0_CAR_GREEN =>
                car_green <= '1';
                ped_red   <= '1';

            when S1_CAR_YELLOW =>
                car_yellow <= '1';
                ped_red    <= '1';

            when S2_PED_GREEN =>
                car_red   <= '1';
                ped_green <= '1';

            when S3_ALL_RED =>
                car_red <= '1';
                ped_red <= '1';

        end case;
    end process;

end Behavioral;