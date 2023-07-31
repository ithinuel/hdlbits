// SPDX-License-Identifier: MIT

// synthesis verilog_input_version verilog_2001
module top_module (
    input      cpu_overheated,
    output  shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output  keep_driving  ); //

    assign shut_off_computer = cpu_overheated;

    assign keep_driving = !arrived && !gas_tank_empty;

endmodule

