library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_pedestrian_traffic_light is
end tb_pedestrian_traffic_light;

architecture Behavioral of tb_pedestrian_traffic_light is

    component pedestrian_traffic_light
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
    end component;

    signal clk_tb        : STD_LOGIC := '0';
    signal reset_tb      : STD_LOGIC := '0';
    signal button_tb     : STD_LOGIC := '0';

    signal car_red_tb    : STD_LOGIC;
    signal car_yellow_tb : STD_LOGIC;
    signal car_green_tb  : STD_LOGIC;

    signal ped_red_tb    : STD_LOGIC;
    signal ped_green_tb  : STD_LOGIC;

begin

    UUT: pedestrian_traffic_light
        port map (
            clk        => clk_tb,
            reset      => reset_tb,
            button     => button_tb,

            car_red    => car_red_tb,
            car_yellow => car_yellow_tb,
            car_green  => car_green_tb,

            ped_red    => ped_red_tb,
            ped_green  => ped_green_tb
        );

    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stimulus: process
    begin
        reset_tb <= '1';
        wait for 20 ns;

        reset_tb <= '0';
        wait for 30 ns;

        button_tb <= '1';
        wait for 10 ns;

        button_tb <= '0';
        wait for 150 ns;

        button_tb <= '1';
        wait for 10 ns;

        button_tb <= '0';
        wait for 150 ns;

        wait;
    end process;

end Behavioral;