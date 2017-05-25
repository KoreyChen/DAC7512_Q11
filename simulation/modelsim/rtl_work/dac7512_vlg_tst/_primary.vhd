library verilog;
use verilog.vl_types.all;
entity dac7512_vlg_tst is
    generic(
        clk_set         : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clk_set : constant is 1;
end dac7512_vlg_tst;
