library verilog;
use verilog.vl_types.all;
entity dac7512 is
    generic(
        ST_Start        : integer := 0;
        ST_Data         : integer := 1;
        ST_Stop         : integer := 2;
        TimeDivSet      : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sclk            : out    vl_logic;
        sync            : out    vl_logic;
        din             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ST_Start : constant is 1;
    attribute mti_svvh_generic_type of ST_Data : constant is 1;
    attribute mti_svvh_generic_type of ST_Stop : constant is 1;
    attribute mti_svvh_generic_type of TimeDivSet : constant is 1;
end dac7512;
