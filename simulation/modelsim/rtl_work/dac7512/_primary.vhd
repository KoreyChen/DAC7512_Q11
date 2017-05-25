library verilog;
use verilog.vl_types.all;
entity dac7512 is
    generic(
        ST_Start        : integer := 0;
        ST_Data         : integer := 1;
        ST_Stop         : integer := 2;
        TimeDivSet      : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sclk            : out    vl_logic;
        sync            : out    vl_logic;
        din             : out    vl_logic;
        data            : in     vl_logic_vector(11 downto 0)
    );
end dac7512;
