//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2008 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module SEG7_s1_arbitrator (
                            // inputs:
                             SEG7_s1_readdata,
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_byteenable,
                             cpu_data_master_latency_counter,
                             cpu_data_master_read,
                             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,

                            // outputs:
                             SEG7_s1_address,
                             SEG7_s1_read,
                             SEG7_s1_readdata_from_sa,
                             SEG7_s1_reset,
                             SEG7_s1_write,
                             SEG7_s1_writedata,
                             cpu_data_master_granted_SEG7_s1,
                             cpu_data_master_qualified_request_SEG7_s1,
                             cpu_data_master_read_data_valid_SEG7_s1,
                             cpu_data_master_requests_SEG7_s1,
                             d1_SEG7_s1_end_xfer
                          )
;

  output  [  2: 0] SEG7_s1_address;
  output           SEG7_s1_read;
  output  [  7: 0] SEG7_s1_readdata_from_sa;
  output           SEG7_s1_reset;
  output           SEG7_s1_write;
  output  [  7: 0] SEG7_s1_writedata;
  output           cpu_data_master_granted_SEG7_s1;
  output           cpu_data_master_qualified_request_SEG7_s1;
  output           cpu_data_master_read_data_valid_SEG7_s1;
  output           cpu_data_master_requests_SEG7_s1;
  output           d1_SEG7_s1_end_xfer;
  input   [  7: 0] SEG7_s1_readdata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  2: 0] SEG7_s1_address;
  wire             SEG7_s1_allgrants;
  wire             SEG7_s1_allow_new_arb_cycle;
  wire             SEG7_s1_any_bursting_master_saved_grant;
  wire             SEG7_s1_any_continuerequest;
  wire             SEG7_s1_arb_counter_enable;
  reg     [  1: 0] SEG7_s1_arb_share_counter;
  wire    [  1: 0] SEG7_s1_arb_share_counter_next_value;
  wire    [  1: 0] SEG7_s1_arb_share_set_values;
  wire             SEG7_s1_beginbursttransfer_internal;
  wire             SEG7_s1_begins_xfer;
  wire             SEG7_s1_end_xfer;
  wire             SEG7_s1_firsttransfer;
  wire             SEG7_s1_grant_vector;
  wire             SEG7_s1_in_a_read_cycle;
  wire             SEG7_s1_in_a_write_cycle;
  wire             SEG7_s1_master_qreq_vector;
  wire             SEG7_s1_non_bursting_master_requests;
  wire             SEG7_s1_pretend_byte_enable;
  wire             SEG7_s1_read;
  wire    [  7: 0] SEG7_s1_readdata_from_sa;
  reg              SEG7_s1_reg_firsttransfer;
  wire             SEG7_s1_reset;
  reg              SEG7_s1_slavearbiterlockenable;
  wire             SEG7_s1_slavearbiterlockenable2;
  wire             SEG7_s1_unreg_firsttransfer;
  wire             SEG7_s1_waits_for_read;
  wire             SEG7_s1_waits_for_write;
  wire             SEG7_s1_write;
  wire    [  7: 0] SEG7_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_SEG7_s1;
  wire             cpu_data_master_qualified_request_SEG7_s1;
  wire             cpu_data_master_read_data_valid_SEG7_s1;
  wire             cpu_data_master_requests_SEG7_s1;
  wire             cpu_data_master_saved_grant_SEG7_s1;
  reg              d1_SEG7_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_SEG7_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_SEG7_s1_from_cpu_data_master;
  wire             wait_for_SEG7_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~SEG7_s1_end_xfer;
    end


  assign SEG7_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_SEG7_s1));
  //assign SEG7_s1_readdata_from_sa = SEG7_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign SEG7_s1_readdata_from_sa = SEG7_s1_readdata;

  assign cpu_data_master_requests_SEG7_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h0) & (cpu_data_master_read | cpu_data_master_write);
  //SEG7_s1_arb_share_counter set values, which is an e_mux
  assign SEG7_s1_arb_share_set_values = 1;

  //SEG7_s1_non_bursting_master_requests mux, which is an e_mux
  assign SEG7_s1_non_bursting_master_requests = cpu_data_master_requests_SEG7_s1;

  //SEG7_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign SEG7_s1_any_bursting_master_saved_grant = 0;

  //SEG7_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign SEG7_s1_arb_share_counter_next_value = SEG7_s1_firsttransfer ? (SEG7_s1_arb_share_set_values - 1) : |SEG7_s1_arb_share_counter ? (SEG7_s1_arb_share_counter - 1) : 0;

  //SEG7_s1_allgrants all slave grants, which is an e_mux
  assign SEG7_s1_allgrants = |SEG7_s1_grant_vector;

  //SEG7_s1_end_xfer assignment, which is an e_assign
  assign SEG7_s1_end_xfer = ~(SEG7_s1_waits_for_read | SEG7_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_SEG7_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_SEG7_s1 = SEG7_s1_end_xfer & (~SEG7_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //SEG7_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign SEG7_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_SEG7_s1 & SEG7_s1_allgrants) | (end_xfer_arb_share_counter_term_SEG7_s1 & ~SEG7_s1_non_bursting_master_requests);

  //SEG7_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_arb_share_counter <= 0;
      else if (SEG7_s1_arb_counter_enable)
          SEG7_s1_arb_share_counter <= SEG7_s1_arb_share_counter_next_value;
    end


  //SEG7_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_slavearbiterlockenable <= 0;
      else if ((|SEG7_s1_master_qreq_vector & end_xfer_arb_share_counter_term_SEG7_s1) | (end_xfer_arb_share_counter_term_SEG7_s1 & ~SEG7_s1_non_bursting_master_requests))
          SEG7_s1_slavearbiterlockenable <= |SEG7_s1_arb_share_counter_next_value;
    end


  //cpu/data_master SEG7/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = SEG7_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //SEG7_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign SEG7_s1_slavearbiterlockenable2 = |SEG7_s1_arb_share_counter_next_value;

  //cpu/data_master SEG7/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = SEG7_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //SEG7_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign SEG7_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_SEG7_s1 = cpu_data_master_requests_SEG7_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_SEG7_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_SEG7_s1 = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read & ~SEG7_s1_waits_for_read;

  //SEG7_s1_writedata mux, which is an e_mux
  assign SEG7_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_SEG7_s1 = cpu_data_master_qualified_request_SEG7_s1;

  //cpu/data_master saved-grant SEG7/s1, which is an e_assign
  assign cpu_data_master_saved_grant_SEG7_s1 = cpu_data_master_requests_SEG7_s1;

  //allow new arb cycle for SEG7/s1, which is an e_assign
  assign SEG7_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign SEG7_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign SEG7_s1_master_qreq_vector = 1;

  //~SEG7_s1_reset assignment, which is an e_assign
  assign SEG7_s1_reset = ~reset_n;

  //SEG7_s1_firsttransfer first transaction, which is an e_assign
  assign SEG7_s1_firsttransfer = SEG7_s1_begins_xfer ? SEG7_s1_unreg_firsttransfer : SEG7_s1_reg_firsttransfer;

  //SEG7_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign SEG7_s1_unreg_firsttransfer = ~(SEG7_s1_slavearbiterlockenable & SEG7_s1_any_continuerequest);

  //SEG7_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          SEG7_s1_reg_firsttransfer <= 1'b1;
      else if (SEG7_s1_begins_xfer)
          SEG7_s1_reg_firsttransfer <= SEG7_s1_unreg_firsttransfer;
    end


  //SEG7_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign SEG7_s1_beginbursttransfer_internal = SEG7_s1_begins_xfer;

  //SEG7_s1_read assignment, which is an e_mux
  assign SEG7_s1_read = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read;

  //SEG7_s1_write assignment, which is an e_mux
  assign SEG7_s1_write = ((cpu_data_master_granted_SEG7_s1 & cpu_data_master_write)) & SEG7_s1_pretend_byte_enable;

  assign shifted_address_to_SEG7_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //SEG7_s1_address mux, which is an e_mux
  assign SEG7_s1_address = shifted_address_to_SEG7_s1_from_cpu_data_master >> 2;

  //d1_SEG7_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_SEG7_s1_end_xfer <= 1;
      else if (1)
          d1_SEG7_s1_end_xfer <= SEG7_s1_end_xfer;
    end


  //SEG7_s1_waits_for_read in a cycle, which is an e_mux
  assign SEG7_s1_waits_for_read = SEG7_s1_in_a_read_cycle & 0;

  //SEG7_s1_in_a_read_cycle assignment, which is an e_assign
  assign SEG7_s1_in_a_read_cycle = cpu_data_master_granted_SEG7_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = SEG7_s1_in_a_read_cycle;

  //SEG7_s1_waits_for_write in a cycle, which is an e_mux
  assign SEG7_s1_waits_for_write = SEG7_s1_in_a_write_cycle & 0;

  //SEG7_s1_in_a_write_cycle assignment, which is an e_assign
  assign SEG7_s1_in_a_write_cycle = cpu_data_master_granted_SEG7_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = SEG7_s1_in_a_write_cycle;

  assign wait_for_SEG7_s1_counter = 0;
  //SEG7_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign SEG7_s1_pretend_byte_enable = (cpu_data_master_granted_SEG7_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //SEG7/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_jtag_debug_module_arbitrator (
                                          // inputs:
                                           clk,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_debugaccess,
                                           cpu_data_master_latency_counter,
                                           cpu_data_master_read,
                                           cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                           cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           cpu_instruction_master_address_to_slave,
                                           cpu_instruction_master_latency_counter,
                                           cpu_instruction_master_read,
                                           cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                           cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                           cpu_jtag_debug_module_readdata,
                                           cpu_jtag_debug_module_resetrequest,
                                           reset_n,

                                          // outputs:
                                           cpu_data_master_granted_cpu_jtag_debug_module,
                                           cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_data_master_requests_cpu_jtag_debug_module,
                                           cpu_instruction_master_granted_cpu_jtag_debug_module,
                                           cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_instruction_master_requests_cpu_jtag_debug_module,
                                           cpu_jtag_debug_module_address,
                                           cpu_jtag_debug_module_begintransfer,
                                           cpu_jtag_debug_module_byteenable,
                                           cpu_jtag_debug_module_chipselect,
                                           cpu_jtag_debug_module_debugaccess,
                                           cpu_jtag_debug_module_readdata_from_sa,
                                           cpu_jtag_debug_module_reset,
                                           cpu_jtag_debug_module_reset_n,
                                           cpu_jtag_debug_module_resetrequest_from_sa,
                                           cpu_jtag_debug_module_write,
                                           cpu_jtag_debug_module_writedata,
                                           d1_cpu_jtag_debug_module_end_xfer
                                        )
;

  output           cpu_data_master_granted_cpu_jtag_debug_module;
  output           cpu_data_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_data_master_requests_cpu_jtag_debug_module;
  output           cpu_instruction_master_granted_cpu_jtag_debug_module;
  output           cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_instruction_master_requests_cpu_jtag_debug_module;
  output  [  8: 0] cpu_jtag_debug_module_address;
  output           cpu_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_jtag_debug_module_byteenable;
  output           cpu_jtag_debug_module_chipselect;
  output           cpu_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  output           cpu_jtag_debug_module_reset;
  output           cpu_jtag_debug_module_reset_n;
  output           cpu_jtag_debug_module_resetrequest_from_sa;
  output           cpu_jtag_debug_module_write;
  output  [ 31: 0] cpu_jtag_debug_module_writedata;
  output           d1_cpu_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_debugaccess;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input   [ 31: 0] cpu_jtag_debug_module_readdata;
  input            cpu_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_saved_grant_cpu_jtag_debug_module;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_saved_grant_cpu_jtag_debug_module;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_allgrants;
  wire             cpu_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_jtag_debug_module_arb_addend;
  wire             cpu_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_jtag_debug_module_arb_winner;
  wire             cpu_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_jtag_debug_module_begins_xfer;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_jtag_debug_module_debugaccess;
  wire             cpu_jtag_debug_module_end_xfer;
  wire             cpu_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_jtag_debug_module_grant_vector;
  wire             cpu_jtag_debug_module_in_a_read_cycle;
  wire             cpu_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_jtag_debug_module_master_qreq_vector;
  wire             cpu_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  reg              cpu_jtag_debug_module_reg_firsttransfer;
  wire             cpu_jtag_debug_module_reset;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_jtag_debug_module_waits_for_read;
  wire             cpu_jtag_debug_module_waits_for_write;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  reg              d1_cpu_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
  reg              last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
  wire    [ 27: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master;
  wire             wait_for_cpu_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~cpu_jtag_debug_module_end_xfer;
    end


  assign cpu_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cpu_jtag_debug_module | cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  //assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata;

  assign cpu_data_master_requests_cpu_jtag_debug_module = ({cpu_data_master_address_to_slave[27 : 11] , 11'b0} == 28'h9604800) & (cpu_data_master_read | cpu_data_master_write);
  //cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_jtag_debug_module_arb_share_set_values = 1;

  //cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_jtag_debug_module_non_bursting_master_requests = cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module |
    cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_jtag_debug_module_arb_share_counter_next_value = cpu_jtag_debug_module_firsttransfer ? (cpu_jtag_debug_module_arb_share_set_values - 1) : |cpu_jtag_debug_module_arb_share_counter ? (cpu_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_jtag_debug_module_allgrants = |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector |
    |cpu_jtag_debug_module_grant_vector;

  //cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_jtag_debug_module_end_xfer = ~(cpu_jtag_debug_module_waits_for_read | cpu_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_jtag_debug_module = cpu_jtag_debug_module_end_xfer & (~cpu_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & cpu_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests);

  //cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_jtag_debug_module_arb_counter_enable)
          cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests))
          cpu_jtag_debug_module_slavearbiterlockenable <= |cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_data_master_continuerequest;

  //cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_jtag_debug_module_slavearbiterlockenable2 = |cpu_jtag_debug_module_arb_share_counter_next_value;

  //cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= cpu_instruction_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module & cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_jtag_debug_module_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cpu_jtag_debug_module = cpu_data_master_requests_cpu_jtag_debug_module & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_instruction_master_arbiterlock);
  //local readdatavalid cpu_data_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_data_master_read_data_valid_cpu_jtag_debug_module = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //cpu_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_jtag_debug_module_writedata = cpu_data_master_writedata;

  assign cpu_instruction_master_requests_cpu_jtag_debug_module = (({cpu_instruction_master_address_to_slave[27 : 11] , 11'b0} == 28'h9604800) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= cpu_data_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_data_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module & cpu_data_master_requests_cpu_jtag_debug_module;

  assign cpu_instruction_master_qualified_request_cpu_jtag_debug_module = cpu_instruction_master_requests_cpu_jtag_debug_module & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cpu_jtag_debug_module = cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cpu_jtag_debug_module;

  //cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[0];

  //cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[0] && cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[1] = cpu_data_master_qualified_request_cpu_jtag_debug_module;

  //cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[1];

  //cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[1] && cpu_data_master_requests_cpu_jtag_debug_module;

  //cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_double_vector = {cpu_jtag_debug_module_master_qreq_vector, cpu_jtag_debug_module_master_qreq_vector} & ({~cpu_jtag_debug_module_master_qreq_vector, ~cpu_jtag_debug_module_master_qreq_vector} + cpu_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_jtag_debug_module_arb_winner = (cpu_jtag_debug_module_allow_new_arb_cycle & | cpu_jtag_debug_module_grant_vector) ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_jtag_debug_module_allow_new_arb_cycle)
          cpu_jtag_debug_module_saved_chosen_master_vector <= |cpu_jtag_debug_module_grant_vector ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_jtag_debug_module_grant_vector = {(cpu_jtag_debug_module_chosen_master_double_vector[1] | cpu_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_jtag_debug_module_chosen_master_double_vector[0] | cpu_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_rot_left = (cpu_jtag_debug_module_arb_winner << 1) ? (cpu_jtag_debug_module_arb_winner << 1) : 1;

  //cpu/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_jtag_debug_module_grant_vector)
          cpu_jtag_debug_module_arb_addend <= cpu_jtag_debug_module_end_xfer? cpu_jtag_debug_module_chosen_master_rot_left : cpu_jtag_debug_module_grant_vector;
    end


  assign cpu_jtag_debug_module_begintransfer = cpu_jtag_debug_module_begins_xfer;
  //assign lhs ~cpu_jtag_debug_module_reset of type reset_n to cpu_jtag_debug_module_reset_n, which is an e_assign
  assign cpu_jtag_debug_module_reset = ~cpu_jtag_debug_module_reset_n;

  //cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_jtag_debug_module_reset_n = reset_n;

  //assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest;

  assign cpu_jtag_debug_module_chipselect = cpu_data_master_granted_cpu_jtag_debug_module | cpu_instruction_master_granted_cpu_jtag_debug_module;
  //cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_firsttransfer = cpu_jtag_debug_module_begins_xfer ? cpu_jtag_debug_module_unreg_firsttransfer : cpu_jtag_debug_module_reg_firsttransfer;

  //cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_unreg_firsttransfer = ~(cpu_jtag_debug_module_slavearbiterlockenable & cpu_jtag_debug_module_any_continuerequest);

  //cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_jtag_debug_module_begins_xfer)
          cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_jtag_debug_module_beginbursttransfer_internal = cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_jtag_debug_module_arbitration_holdoff_internal = cpu_jtag_debug_module_begins_xfer & cpu_jtag_debug_module_firsttransfer;

  //cpu_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_jtag_debug_module_write = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master = cpu_data_master_address_to_slave;
  //cpu_jtag_debug_module_address mux, which is an e_mux
  assign cpu_jtag_debug_module_address = (cpu_data_master_granted_cpu_jtag_debug_module)? (shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master >> 2) :
    (shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master >> 2);

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_jtag_debug_module_end_xfer <= 1;
      else if (1)
          d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end


  //cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_read = cpu_jtag_debug_module_in_a_read_cycle & cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_read_cycle = (cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read) | (cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_jtag_debug_module_in_a_read_cycle;

  //cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_write = cpu_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_write_cycle = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_jtag_debug_module_counter = 0;
  //cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_jtag_debug_module_byteenable = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_jtag_debug_module_debugaccess = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cpu_jtag_debug_module + cpu_instruction_master_granted_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cpu_jtag_debug_module + cpu_instruction_master_saved_grant_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_data_master_arbitrator (
                                    // inputs:
                                     SEG7_s1_readdata_from_sa,
                                     clk,
                                     cpu_data_master_address,
                                     cpu_data_master_byteenable_sdram_u1_s1,
                                     cpu_data_master_byteenable_sdram_u2_s1,
                                     cpu_data_master_granted_SEG7_s1,
                                     cpu_data_master_granted_cpu_jtag_debug_module,
                                     cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_granted_lcd_control_slave,
                                     cpu_data_master_granted_nios_ii_clock_0_in,
                                     cpu_data_master_granted_onchip_mem_s1,
                                     cpu_data_master_granted_pio_button_s1,
                                     cpu_data_master_granted_pio_green_led_s1,
                                     cpu_data_master_granted_pio_red_led_s1,
                                     cpu_data_master_granted_pio_switch_s1,
                                     cpu_data_master_granted_sdram_u1_s1,
                                     cpu_data_master_granted_sdram_u2_s1,
                                     cpu_data_master_granted_sysid_control_slave,
                                     cpu_data_master_granted_timer_s1,
                                     cpu_data_master_granted_timer_stamp_s1,
                                     cpu_data_master_granted_uart_s1,
                                     cpu_data_master_qualified_request_SEG7_s1,
                                     cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                     cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_qualified_request_lcd_control_slave,
                                     cpu_data_master_qualified_request_nios_ii_clock_0_in,
                                     cpu_data_master_qualified_request_onchip_mem_s1,
                                     cpu_data_master_qualified_request_pio_button_s1,
                                     cpu_data_master_qualified_request_pio_green_led_s1,
                                     cpu_data_master_qualified_request_pio_red_led_s1,
                                     cpu_data_master_qualified_request_pio_switch_s1,
                                     cpu_data_master_qualified_request_sdram_u1_s1,
                                     cpu_data_master_qualified_request_sdram_u2_s1,
                                     cpu_data_master_qualified_request_sysid_control_slave,
                                     cpu_data_master_qualified_request_timer_s1,
                                     cpu_data_master_qualified_request_timer_stamp_s1,
                                     cpu_data_master_qualified_request_uart_s1,
                                     cpu_data_master_read,
                                     cpu_data_master_read_data_valid_SEG7_s1,
                                     cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                     cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_read_data_valid_lcd_control_slave,
                                     cpu_data_master_read_data_valid_nios_ii_clock_0_in,
                                     cpu_data_master_read_data_valid_onchip_mem_s1,
                                     cpu_data_master_read_data_valid_pio_button_s1,
                                     cpu_data_master_read_data_valid_pio_green_led_s1,
                                     cpu_data_master_read_data_valid_pio_red_led_s1,
                                     cpu_data_master_read_data_valid_pio_switch_s1,
                                     cpu_data_master_read_data_valid_sdram_u1_s1,
                                     cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                     cpu_data_master_read_data_valid_sdram_u2_s1,
                                     cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                     cpu_data_master_read_data_valid_sysid_control_slave,
                                     cpu_data_master_read_data_valid_timer_s1,
                                     cpu_data_master_read_data_valid_timer_stamp_s1,
                                     cpu_data_master_read_data_valid_uart_s1,
                                     cpu_data_master_requests_SEG7_s1,
                                     cpu_data_master_requests_cpu_jtag_debug_module,
                                     cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_requests_lcd_control_slave,
                                     cpu_data_master_requests_nios_ii_clock_0_in,
                                     cpu_data_master_requests_onchip_mem_s1,
                                     cpu_data_master_requests_pio_button_s1,
                                     cpu_data_master_requests_pio_green_led_s1,
                                     cpu_data_master_requests_pio_red_led_s1,
                                     cpu_data_master_requests_pio_switch_s1,
                                     cpu_data_master_requests_sdram_u1_s1,
                                     cpu_data_master_requests_sdram_u2_s1,
                                     cpu_data_master_requests_sysid_control_slave,
                                     cpu_data_master_requests_timer_s1,
                                     cpu_data_master_requests_timer_stamp_s1,
                                     cpu_data_master_requests_uart_s1,
                                     cpu_data_master_write,
                                     cpu_data_master_writedata,
                                     cpu_jtag_debug_module_readdata_from_sa,
                                     d1_SEG7_s1_end_xfer,
                                     d1_cpu_jtag_debug_module_end_xfer,
                                     d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                     d1_lcd_control_slave_end_xfer,
                                     d1_nios_ii_clock_0_in_end_xfer,
                                     d1_onchip_mem_s1_end_xfer,
                                     d1_pio_button_s1_end_xfer,
                                     d1_pio_green_led_s1_end_xfer,
                                     d1_pio_red_led_s1_end_xfer,
                                     d1_pio_switch_s1_end_xfer,
                                     d1_sdram_u1_s1_end_xfer,
                                     d1_sdram_u2_s1_end_xfer,
                                     d1_sysid_control_slave_end_xfer,
                                     d1_timer_s1_end_xfer,
                                     d1_timer_stamp_s1_end_xfer,
                                     d1_uart_s1_end_xfer,
                                     jtag_uart_avalon_jtag_slave_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                     lcd_control_slave_readdata_from_sa,
                                     lcd_control_slave_wait_counter_eq_0,
                                     nios_ii_clock_0_in_readdata_from_sa,
                                     nios_ii_clock_0_in_waitrequest_from_sa,
                                     onchip_mem_s1_readdata_from_sa,
                                     pio_button_s1_irq_from_sa,
                                     pio_button_s1_readdata_from_sa,
                                     pio_switch_s1_readdata_from_sa,
                                     reset_n,
                                     sdram_u1_s1_readdata_from_sa,
                                     sdram_u1_s1_waitrequest_from_sa,
                                     sdram_u2_s1_readdata_from_sa,
                                     sdram_u2_s1_waitrequest_from_sa,
                                     sysid_control_slave_readdata_from_sa,
                                     timer_s1_irq_from_sa,
                                     timer_s1_readdata_from_sa,
                                     timer_stamp_s1_irq_from_sa,
                                     timer_stamp_s1_readdata_from_sa,
                                     uart_s1_irq_from_sa,
                                     uart_s1_readdata_from_sa,

                                    // outputs:
                                     cpu_data_master_address_to_slave,
                                     cpu_data_master_dbs_address,
                                     cpu_data_master_dbs_write_16,
                                     cpu_data_master_irq,
                                     cpu_data_master_latency_counter,
                                     cpu_data_master_readdata,
                                     cpu_data_master_readdatavalid,
                                     cpu_data_master_waitrequest
                                  )
;

  output  [ 27: 0] cpu_data_master_address_to_slave;
  output  [  1: 0] cpu_data_master_dbs_address;
  output  [ 15: 0] cpu_data_master_dbs_write_16;
  output  [ 31: 0] cpu_data_master_irq;
  output           cpu_data_master_latency_counter;
  output  [ 31: 0] cpu_data_master_readdata;
  output           cpu_data_master_readdatavalid;
  output           cpu_data_master_waitrequest;
  input   [  7: 0] SEG7_s1_readdata_from_sa;
  input            clk;
  input   [ 27: 0] cpu_data_master_address;
  input   [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  input   [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  input            cpu_data_master_granted_SEG7_s1;
  input            cpu_data_master_granted_cpu_jtag_debug_module;
  input            cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_granted_lcd_control_slave;
  input            cpu_data_master_granted_nios_ii_clock_0_in;
  input            cpu_data_master_granted_onchip_mem_s1;
  input            cpu_data_master_granted_pio_button_s1;
  input            cpu_data_master_granted_pio_green_led_s1;
  input            cpu_data_master_granted_pio_red_led_s1;
  input            cpu_data_master_granted_pio_switch_s1;
  input            cpu_data_master_granted_sdram_u1_s1;
  input            cpu_data_master_granted_sdram_u2_s1;
  input            cpu_data_master_granted_sysid_control_slave;
  input            cpu_data_master_granted_timer_s1;
  input            cpu_data_master_granted_timer_stamp_s1;
  input            cpu_data_master_granted_uart_s1;
  input            cpu_data_master_qualified_request_SEG7_s1;
  input            cpu_data_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_qualified_request_lcd_control_slave;
  input            cpu_data_master_qualified_request_nios_ii_clock_0_in;
  input            cpu_data_master_qualified_request_onchip_mem_s1;
  input            cpu_data_master_qualified_request_pio_button_s1;
  input            cpu_data_master_qualified_request_pio_green_led_s1;
  input            cpu_data_master_qualified_request_pio_red_led_s1;
  input            cpu_data_master_qualified_request_pio_switch_s1;
  input            cpu_data_master_qualified_request_sdram_u1_s1;
  input            cpu_data_master_qualified_request_sdram_u2_s1;
  input            cpu_data_master_qualified_request_sysid_control_slave;
  input            cpu_data_master_qualified_request_timer_s1;
  input            cpu_data_master_qualified_request_timer_stamp_s1;
  input            cpu_data_master_qualified_request_uart_s1;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_SEG7_s1;
  input            cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_read_data_valid_lcd_control_slave;
  input            cpu_data_master_read_data_valid_nios_ii_clock_0_in;
  input            cpu_data_master_read_data_valid_onchip_mem_s1;
  input            cpu_data_master_read_data_valid_pio_button_s1;
  input            cpu_data_master_read_data_valid_pio_green_led_s1;
  input            cpu_data_master_read_data_valid_pio_red_led_s1;
  input            cpu_data_master_read_data_valid_pio_switch_s1;
  input            cpu_data_master_read_data_valid_sdram_u1_s1;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_read_data_valid_sysid_control_slave;
  input            cpu_data_master_read_data_valid_timer_s1;
  input            cpu_data_master_read_data_valid_timer_stamp_s1;
  input            cpu_data_master_read_data_valid_uart_s1;
  input            cpu_data_master_requests_SEG7_s1;
  input            cpu_data_master_requests_cpu_jtag_debug_module;
  input            cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_requests_lcd_control_slave;
  input            cpu_data_master_requests_nios_ii_clock_0_in;
  input            cpu_data_master_requests_onchip_mem_s1;
  input            cpu_data_master_requests_pio_button_s1;
  input            cpu_data_master_requests_pio_green_led_s1;
  input            cpu_data_master_requests_pio_red_led_s1;
  input            cpu_data_master_requests_pio_switch_s1;
  input            cpu_data_master_requests_sdram_u1_s1;
  input            cpu_data_master_requests_sdram_u2_s1;
  input            cpu_data_master_requests_sysid_control_slave;
  input            cpu_data_master_requests_timer_s1;
  input            cpu_data_master_requests_timer_stamp_s1;
  input            cpu_data_master_requests_uart_s1;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_SEG7_s1_end_xfer;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_jtag_uart_avalon_jtag_slave_end_xfer;
  input            d1_lcd_control_slave_end_xfer;
  input            d1_nios_ii_clock_0_in_end_xfer;
  input            d1_onchip_mem_s1_end_xfer;
  input            d1_pio_button_s1_end_xfer;
  input            d1_pio_green_led_s1_end_xfer;
  input            d1_pio_red_led_s1_end_xfer;
  input            d1_pio_switch_s1_end_xfer;
  input            d1_sdram_u1_s1_end_xfer;
  input            d1_sdram_u2_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_s1_end_xfer;
  input            d1_timer_stamp_s1_end_xfer;
  input            d1_uart_s1_end_xfer;
  input            jtag_uart_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  input   [  7: 0] lcd_control_slave_readdata_from_sa;
  input            lcd_control_slave_wait_counter_eq_0;
  input   [ 15: 0] nios_ii_clock_0_in_readdata_from_sa;
  input            nios_ii_clock_0_in_waitrequest_from_sa;
  input   [ 31: 0] onchip_mem_s1_readdata_from_sa;
  input            pio_button_s1_irq_from_sa;
  input   [  3: 0] pio_button_s1_readdata_from_sa;
  input   [ 17: 0] pio_switch_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_u1_s1_readdata_from_sa;
  input            sdram_u1_s1_waitrequest_from_sa;
  input   [ 15: 0] sdram_u2_s1_readdata_from_sa;
  input            sdram_u2_s1_waitrequest_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            timer_s1_irq_from_sa;
  input   [ 15: 0] timer_s1_readdata_from_sa;
  input            timer_stamp_s1_irq_from_sa;
  input   [ 15: 0] timer_stamp_s1_readdata_from_sa;
  input            uart_s1_irq_from_sa;
  input   [ 15: 0] uart_s1_readdata_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_data_master_address_last_time;
  wire    [ 27: 0] cpu_data_master_address_to_slave;
  reg     [  1: 0] cpu_data_master_dbs_address;
  wire    [  1: 0] cpu_data_master_dbs_increment;
  reg     [  1: 0] cpu_data_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_data_master_dbs_rdv_counter_inc;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_is_granted_some_slave;
  reg              cpu_data_master_latency_counter;
  wire    [  1: 0] cpu_data_master_next_dbs_rdv_counter;
  reg              cpu_data_master_read_but_no_slave_selected;
  reg              cpu_data_master_read_last_time;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_run;
  wire             cpu_data_master_waitrequest;
  reg              cpu_data_master_write_last_time;
  reg     [ 31: 0] cpu_data_master_writedata_last_time;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_data_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_data_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_data_master_qualified_request_SEG7_s1 | ~cpu_data_master_requests_SEG7_s1) & ((~cpu_data_master_qualified_request_SEG7_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_SEG7_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_requests_cpu_jtag_debug_module) & (cpu_data_master_granted_cpu_jtag_debug_module | ~cpu_data_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~cpu_data_master_requests_jtag_uart_avalon_jtag_slave) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_requests_lcd_control_slave) & ((~cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_read | (1 & ((lcd_control_slave_wait_counter_eq_0 & ~d1_lcd_control_slave_end_xfer)) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_lcd_control_slave | ~cpu_data_master_write | (1 & ((lcd_control_slave_wait_counter_eq_0 & ~d1_lcd_control_slave_end_xfer)) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_nios_ii_clock_0_in | ~cpu_data_master_requests_nios_ii_clock_0_in) & ((~cpu_data_master_qualified_request_nios_ii_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~nios_ii_clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write))));

  //cascaded wait assignment, which is an e_assign
  assign cpu_data_master_run = r_0 & r_1 & r_2 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_data_master_qualified_request_nios_ii_clock_0_in | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~nios_ii_clock_0_in_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_onchip_mem_s1 | ~cpu_data_master_requests_onchip_mem_s1) & (cpu_data_master_granted_onchip_mem_s1 | ~cpu_data_master_qualified_request_onchip_mem_s1) & ((~cpu_data_master_qualified_request_onchip_mem_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_onchip_mem_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_requests_pio_button_s1) & ((~cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_read | (1 & ~d1_pio_button_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_button_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_pio_green_led_s1 | ~cpu_data_master_read | (1 & ~d1_pio_green_led_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_green_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_pio_red_led_s1 | ~cpu_data_master_read | (1 & ~d1_pio_red_led_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_red_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_requests_pio_switch_s1) & ((~cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_read | (1 & ~d1_pio_switch_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_switch_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write)));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_data_master_qualified_request_sdram_u1_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_u1_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_u1_s1) & (cpu_data_master_granted_sdram_u1_s1 | ~cpu_data_master_qualified_request_sdram_u1_s1) & ((~cpu_data_master_qualified_request_sdram_u1_s1 | ~cpu_data_master_read | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_u1_s1 | ~cpu_data_master_write | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sdram_u2_s1 | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_u2_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_u2_s1) & (cpu_data_master_granted_sdram_u2_s1 | ~cpu_data_master_qualified_request_sdram_u2_s1) & ((~cpu_data_master_qualified_request_sdram_u2_s1 | ~cpu_data_master_read | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_u2_s1 | ~cpu_data_master_write | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_requests_sysid_control_slave) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_read | (1 & ~d1_sysid_control_slave_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_requests_timer_s1) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_read | (1 & ~d1_timer_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_timer_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_requests_timer_stamp_s1);

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = ((~cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_read | (1 & ~d1_timer_stamp_s1_end_xfer & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_timer_stamp_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_uart_s1 | ~cpu_data_master_requests_uart_s1) & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~d1_uart_s1_end_xfer & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_uart_s1 | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~d1_uart_s1_end_xfer & (cpu_data_master_read | cpu_data_master_write))));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_data_master_address_to_slave = cpu_data_master_address[27 : 0];

  //cpu_data_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_but_no_slave_selected <= 0;
      else if (1)
          cpu_data_master_read_but_no_slave_selected <= cpu_data_master_read & cpu_data_master_run & ~cpu_data_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_data_master_is_granted_some_slave = cpu_data_master_granted_SEG7_s1 |
    cpu_data_master_granted_cpu_jtag_debug_module |
    cpu_data_master_granted_jtag_uart_avalon_jtag_slave |
    cpu_data_master_granted_lcd_control_slave |
    cpu_data_master_granted_nios_ii_clock_0_in |
    cpu_data_master_granted_onchip_mem_s1 |
    cpu_data_master_granted_pio_button_s1 |
    cpu_data_master_granted_pio_green_led_s1 |
    cpu_data_master_granted_pio_red_led_s1 |
    cpu_data_master_granted_pio_switch_s1 |
    cpu_data_master_granted_sdram_u1_s1 |
    cpu_data_master_granted_sdram_u2_s1 |
    cpu_data_master_granted_sysid_control_slave |
    cpu_data_master_granted_timer_s1 |
    cpu_data_master_granted_timer_stamp_s1 |
    cpu_data_master_granted_uart_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_data_master_readdatavalid = cpu_data_master_read_data_valid_onchip_mem_s1 |
    (cpu_data_master_read_data_valid_sdram_u1_s1 & dbs_rdv_counter_overflow) |
    (cpu_data_master_read_data_valid_sdram_u2_s1 & dbs_rdv_counter_overflow);

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_data_master_readdatavalid = cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_SEG7_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_cpu_jtag_debug_module |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_lcd_control_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_nios_ii_clock_0_in |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_button_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_green_led_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_red_led_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_pio_switch_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_sysid_control_slave |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_timer_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_timer_stamp_s1 |
    cpu_data_master_read_but_no_slave_selected |
    pre_flush_cpu_data_master_readdatavalid |
    cpu_data_master_read_data_valid_uart_s1;

  //cpu/data_master readdata mux, which is an e_mux
  assign cpu_data_master_readdata = ({32 {~(cpu_data_master_qualified_request_SEG7_s1 & cpu_data_master_read)}} | SEG7_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_cpu_jtag_debug_module & cpu_data_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave & cpu_data_master_read)}} | jtag_uart_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_lcd_control_slave & cpu_data_master_read)}} | lcd_control_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_nios_ii_clock_0_in & cpu_data_master_read)}} | nios_ii_clock_0_in_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_onchip_mem_s1}} | onchip_mem_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_pio_button_s1 & cpu_data_master_read)}} | pio_button_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_pio_switch_s1 & cpu_data_master_read)}} | pio_switch_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_read_data_valid_sdram_u1_s1}} | {sdram_u1_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_data_master_read_data_valid_sdram_u2_s1}} | {sdram_u2_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~(cpu_data_master_qualified_request_sysid_control_slave & cpu_data_master_read)}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_timer_s1 & cpu_data_master_read)}} | timer_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_timer_stamp_s1 & cpu_data_master_read)}} | timer_stamp_s1_readdata_from_sa) &
    ({32 {~(cpu_data_master_qualified_request_uart_s1 & cpu_data_master_read)}} | uart_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign cpu_data_master_waitrequest = ~cpu_data_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_latency_counter <= 0;
      else if (1)
          cpu_data_master_latency_counter <= p1_cpu_data_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_data_master_latency_counter = ((cpu_data_master_run & cpu_data_master_read))? latency_load_value :
    (cpu_data_master_latency_counter)? cpu_data_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {1 {cpu_data_master_requests_onchip_mem_s1}} & 1;

  //irq assign, which is an e_assign
  assign cpu_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    pio_button_s1_irq_from_sa,
    uart_s1_irq_from_sa,
    jtag_uart_avalon_jtag_slave_irq_from_sa,
    timer_stamp_s1_irq_from_sa,
    timer_s1_irq_from_sa};

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~0) & cpu_data_master_requests_sdram_u1_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_u1_s1)) |
    (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (((~0) & cpu_data_master_requests_sdram_u2_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_u2_s1)) |
    (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa) |
    (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa);

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = (cpu_data_master_read_data_valid_sdram_u1_s1)? sdram_u1_s1_readdata_from_sa :
    sdram_u2_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_data_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_data_master_dbs_write_16 = (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    (~(cpu_data_master_dbs_address[1]))? cpu_data_master_writedata[15 : 0] :
    (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    cpu_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_data_master_dbs_increment = (cpu_data_master_requests_sdram_u1_s1)? 2 :
    (cpu_data_master_requests_sdram_u2_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_data_master_dbs_address + cpu_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_data_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_data_master_next_dbs_rdv_counter = cpu_data_master_dbs_rdv_counter + cpu_data_master_dbs_rdv_counter_inc;

  //cpu_data_master_rdv_inc_mux, which is an e_mux
  assign cpu_data_master_dbs_rdv_counter_inc = (cpu_data_master_read_data_valid_sdram_u1_s1)? 2 :
    2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_data_master_read_data_valid_sdram_u1_s1 |
    cpu_data_master_read_data_valid_sdram_u2_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_data_master_dbs_rdv_counter <= cpu_data_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_data_master_dbs_rdv_counter[1] & ~cpu_data_master_next_dbs_rdv_counter[1];


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_data_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_address_last_time <= 0;
      else if (1)
          cpu_data_master_address_last_time <= cpu_data_master_address;
    end


  //cpu/data_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= cpu_data_master_waitrequest & (cpu_data_master_read | cpu_data_master_write);
    end


  //cpu_data_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_address != cpu_data_master_address_last_time))
        begin
          $write("%0d ns: cpu_data_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_last_time <= 0;
      else if (1)
          cpu_data_master_read_last_time <= cpu_data_master_read;
    end


  //cpu_data_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_read != cpu_data_master_read_last_time))
        begin
          $write("%0d ns: cpu_data_master_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_write_last_time <= 0;
      else if (1)
          cpu_data_master_write_last_time <= cpu_data_master_write;
    end


  //cpu_data_master_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_write != cpu_data_master_write_last_time))
        begin
          $write("%0d ns: cpu_data_master_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_data_master_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_writedata_last_time <= 0;
      else if (1)
          cpu_data_master_writedata_last_time <= cpu_data_master_writedata;
    end


  //cpu_data_master_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_data_master_writedata != cpu_data_master_writedata_last_time) & cpu_data_master_write)
        begin
          $write("%0d ns: cpu_data_master_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_instruction_master_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_instruction_master_address,
                                            cpu_instruction_master_granted_cpu_jtag_debug_module,
                                            cpu_instruction_master_granted_onchip_mem_s1,
                                            cpu_instruction_master_granted_sdram_u1_s1,
                                            cpu_instruction_master_granted_sdram_u2_s1,
                                            cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                            cpu_instruction_master_qualified_request_onchip_mem_s1,
                                            cpu_instruction_master_qualified_request_sdram_u1_s1,
                                            cpu_instruction_master_qualified_request_sdram_u2_s1,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                            cpu_instruction_master_read_data_valid_onchip_mem_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u1_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                            cpu_instruction_master_read_data_valid_sdram_u2_s1,
                                            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                            cpu_instruction_master_requests_cpu_jtag_debug_module,
                                            cpu_instruction_master_requests_onchip_mem_s1,
                                            cpu_instruction_master_requests_sdram_u1_s1,
                                            cpu_instruction_master_requests_sdram_u2_s1,
                                            cpu_jtag_debug_module_readdata_from_sa,
                                            d1_cpu_jtag_debug_module_end_xfer,
                                            d1_onchip_mem_s1_end_xfer,
                                            d1_sdram_u1_s1_end_xfer,
                                            d1_sdram_u2_s1_end_xfer,
                                            onchip_mem_s1_readdata_from_sa,
                                            reset_n,
                                            sdram_u1_s1_readdata_from_sa,
                                            sdram_u1_s1_waitrequest_from_sa,
                                            sdram_u2_s1_readdata_from_sa,
                                            sdram_u2_s1_waitrequest_from_sa,

                                           // outputs:
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_dbs_address,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_readdata,
                                            cpu_instruction_master_readdatavalid,
                                            cpu_instruction_master_waitrequest
                                         )
;

  output  [ 27: 0] cpu_instruction_master_address_to_slave;
  output  [  1: 0] cpu_instruction_master_dbs_address;
  output           cpu_instruction_master_latency_counter;
  output  [ 31: 0] cpu_instruction_master_readdata;
  output           cpu_instruction_master_readdatavalid;
  output           cpu_instruction_master_waitrequest;
  input            clk;
  input   [ 27: 0] cpu_instruction_master_address;
  input            cpu_instruction_master_granted_cpu_jtag_debug_module;
  input            cpu_instruction_master_granted_onchip_mem_s1;
  input            cpu_instruction_master_granted_sdram_u1_s1;
  input            cpu_instruction_master_granted_sdram_u2_s1;
  input            cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_instruction_master_qualified_request_onchip_mem_s1;
  input            cpu_instruction_master_qualified_request_sdram_u1_s1;
  input            cpu_instruction_master_qualified_request_sdram_u2_s1;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_instruction_master_read_data_valid_onchip_mem_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_instruction_master_requests_cpu_jtag_debug_module;
  input            cpu_instruction_master_requests_onchip_mem_s1;
  input            cpu_instruction_master_requests_sdram_u1_s1;
  input            cpu_instruction_master_requests_sdram_u2_s1;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_onchip_mem_s1_end_xfer;
  input            d1_sdram_u1_s1_end_xfer;
  input            d1_sdram_u2_s1_end_xfer;
  input   [ 31: 0] onchip_mem_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_u1_s1_readdata_from_sa;
  input            sdram_u1_s1_waitrequest_from_sa;
  input   [ 15: 0] sdram_u2_s1_readdata_from_sa;
  input            sdram_u2_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 27: 0] cpu_instruction_master_address_last_time;
  wire    [ 27: 0] cpu_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_instruction_master_dbs_address;
  wire    [  1: 0] cpu_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_instruction_master_is_granted_some_slave;
  reg              cpu_instruction_master_latency_counter;
  wire    [  1: 0] cpu_instruction_master_next_dbs_rdv_counter;
  reg              cpu_instruction_master_read_but_no_slave_selected;
  reg              cpu_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_run;
  wire             cpu_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_requests_cpu_jtag_debug_module) & (cpu_instruction_master_granted_cpu_jtag_debug_module | ~cpu_instruction_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_instruction_master_run = r_0 & r_1 & r_2;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_instruction_master_qualified_request_onchip_mem_s1 | ~cpu_instruction_master_requests_onchip_mem_s1) & (cpu_instruction_master_granted_onchip_mem_s1 | ~cpu_instruction_master_qualified_request_onchip_mem_s1) & ((~cpu_instruction_master_qualified_request_onchip_mem_s1 | ~(cpu_instruction_master_read) | (1 & (cpu_instruction_master_read))));

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_instruction_master_qualified_request_sdram_u1_s1 | ~cpu_instruction_master_requests_sdram_u1_s1) & (cpu_instruction_master_granted_sdram_u1_s1 | ~cpu_instruction_master_qualified_request_sdram_u1_s1) & ((~cpu_instruction_master_qualified_request_sdram_u1_s1 | ~cpu_instruction_master_read | (1 & ~sdram_u1_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read))) & 1 & (cpu_instruction_master_qualified_request_sdram_u2_s1 | ~cpu_instruction_master_requests_sdram_u2_s1) & (cpu_instruction_master_granted_sdram_u2_s1 | ~cpu_instruction_master_qualified_request_sdram_u2_s1) & ((~cpu_instruction_master_qualified_request_sdram_u2_s1 | ~cpu_instruction_master_read | (1 & ~sdram_u2_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_instruction_master_address_to_slave = cpu_instruction_master_address[27 : 0];

  //cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_but_no_slave_selected <= 0;
      else if (1)
          cpu_instruction_master_read_but_no_slave_selected <= cpu_instruction_master_read & cpu_instruction_master_run & ~cpu_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_instruction_master_is_granted_some_slave = cpu_instruction_master_granted_cpu_jtag_debug_module |
    cpu_instruction_master_granted_onchip_mem_s1 |
    cpu_instruction_master_granted_sdram_u1_s1 |
    cpu_instruction_master_granted_sdram_u2_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_instruction_master_readdatavalid = cpu_instruction_master_read_data_valid_onchip_mem_s1 |
    (cpu_instruction_master_read_data_valid_sdram_u1_s1 & dbs_rdv_counter_overflow) |
    (cpu_instruction_master_read_data_valid_sdram_u2_s1 & dbs_rdv_counter_overflow);

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_instruction_master_readdatavalid = cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_cpu_jtag_debug_module |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid;

  //cpu/instruction_master readdata mux, which is an e_mux
  assign cpu_instruction_master_readdata = ({32 {~(cpu_instruction_master_qualified_request_cpu_jtag_debug_module & cpu_instruction_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_onchip_mem_s1}} | onchip_mem_s1_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_u1_s1}} | {sdram_u1_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0}) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_u2_s1}} | {sdram_u2_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_instruction_master_waitrequest = ~cpu_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_latency_counter <= 0;
      else if (1)
          cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_instruction_master_latency_counter = ((cpu_instruction_master_run & cpu_instruction_master_read))? latency_load_value :
    (cpu_instruction_master_latency_counter)? cpu_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = {1 {cpu_instruction_master_requests_onchip_mem_s1}} & 1;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = (cpu_instruction_master_read_data_valid_sdram_u1_s1)? sdram_u1_s1_readdata_from_sa :
    sdram_u2_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_instruction_master_dbs_increment = (cpu_instruction_master_requests_sdram_u1_s1)? 2 :
    (cpu_instruction_master_requests_sdram_u2_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_instruction_master_dbs_address + cpu_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_instruction_master_next_dbs_rdv_counter = cpu_instruction_master_dbs_rdv_counter + cpu_instruction_master_dbs_rdv_counter_inc;

  //cpu_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_instruction_master_dbs_rdv_counter_inc = (cpu_instruction_master_read_data_valid_sdram_u1_s1)? 2 :
    2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_instruction_master_read_data_valid_sdram_u1_s1 |
    cpu_instruction_master_read_data_valid_sdram_u2_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_instruction_master_dbs_rdv_counter[1] & ~cpu_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_u1_s1_waitrequest_from_sa) |
    (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_u2_s1_waitrequest_from_sa);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_address_last_time <= 0;
      else if (1)
          cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
    end


  //cpu/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= cpu_instruction_master_waitrequest & (cpu_instruction_master_read);
    end


  //cpu_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_address != cpu_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_last_time <= 0;
      else if (1)
          cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
    end


  //cpu_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_read != cpu_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_avalon_jtag_slave_arbitrator (
                                                // inputs:
                                                 clk,
                                                 cpu_data_master_address_to_slave,
                                                 cpu_data_master_latency_counter,
                                                 cpu_data_master_read,
                                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                                 cpu_data_master_write,
                                                 cpu_data_master_writedata,
                                                 jtag_uart_avalon_jtag_slave_dataavailable,
                                                 jtag_uart_avalon_jtag_slave_irq,
                                                 jtag_uart_avalon_jtag_slave_readdata,
                                                 jtag_uart_avalon_jtag_slave_readyfordata,
                                                 jtag_uart_avalon_jtag_slave_waitrequest,
                                                 reset_n,

                                                // outputs:
                                                 cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                                 d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                                 jtag_uart_avalon_jtag_slave_address,
                                                 jtag_uart_avalon_jtag_slave_chipselect,
                                                 jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
                                                 jtag_uart_avalon_jtag_slave_irq_from_sa,
                                                 jtag_uart_avalon_jtag_slave_read_n,
                                                 jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_reset_n,
                                                 jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                                 jtag_uart_avalon_jtag_slave_write_n,
                                                 jtag_uart_avalon_jtag_slave_writedata
                                              )
;

  output           cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  output           d1_jtag_uart_avalon_jtag_slave_end_xfer;
  output           jtag_uart_avalon_jtag_slave_address;
  output           jtag_uart_avalon_jtag_slave_chipselect;
  output           jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_avalon_jtag_slave_reset_n;
  output           jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            jtag_uart_avalon_jtag_slave_dataavailable;
  input            jtag_uart_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  input            jtag_uart_avalon_jtag_slave_readyfordata;
  input            jtag_uart_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave;
  reg              d1_jtag_uart_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_allgrants;
  wire             jtag_uart_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  reg              jtag_uart_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [ 27: 0] shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master;
  wire             wait_for_jtag_uart_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~jtag_uart_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave));
  //assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata;

  assign cpu_data_master_requests_jtag_uart_avalon_jtag_slave = ({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96051e8) & (cpu_data_master_read | cpu_data_master_write);
  //assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest;

  //jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_non_bursting_master_requests = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_avalon_jtag_slave_firsttransfer ? (jtag_uart_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_avalon_jtag_slave_arb_share_counter ? (jtag_uart_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_allgrants = |jtag_uart_avalon_jtag_slave_grant_vector;

  //jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_end_xfer = ~(jtag_uart_avalon_jtag_slave_waits_for_read | jtag_uart_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave = jtag_uart_avalon_jtag_slave_end_xfer & (~jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & jtag_uart_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = jtag_uart_avalon_jtag_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read & ~jtag_uart_avalon_jtag_slave_waits_for_read;

  //jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_jtag_uart_avalon_jtag_slave = cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;

  //cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  assign cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_avalon_jtag_slave_chipselect = cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  //jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_firsttransfer = jtag_uart_avalon_jtag_slave_begins_xfer ? jtag_uart_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_avalon_jtag_slave_begins_xfer)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_read_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read);

  //~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_write_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write);

  assign shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_address = shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master >> 2;

  //d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= 1;
      else if (1)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_read = jtag_uart_avalon_jtag_slave_in_a_read_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_read_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_write = jtag_uart_avalon_jtag_slave_in_a_write_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_write_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_control_slave_arbitrator (
                                      // inputs:
                                       clk,
                                       cpu_data_master_address_to_slave,
                                       cpu_data_master_byteenable,
                                       cpu_data_master_latency_counter,
                                       cpu_data_master_read,
                                       cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                       cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                       cpu_data_master_write,
                                       cpu_data_master_writedata,
                                       lcd_control_slave_readdata,
                                       reset_n,

                                      // outputs:
                                       cpu_data_master_granted_lcd_control_slave,
                                       cpu_data_master_qualified_request_lcd_control_slave,
                                       cpu_data_master_read_data_valid_lcd_control_slave,
                                       cpu_data_master_requests_lcd_control_slave,
                                       d1_lcd_control_slave_end_xfer,
                                       lcd_control_slave_address,
                                       lcd_control_slave_begintransfer,
                                       lcd_control_slave_read,
                                       lcd_control_slave_readdata_from_sa,
                                       lcd_control_slave_wait_counter_eq_0,
                                       lcd_control_slave_write,
                                       lcd_control_slave_writedata
                                    )
;

  output           cpu_data_master_granted_lcd_control_slave;
  output           cpu_data_master_qualified_request_lcd_control_slave;
  output           cpu_data_master_read_data_valid_lcd_control_slave;
  output           cpu_data_master_requests_lcd_control_slave;
  output           d1_lcd_control_slave_end_xfer;
  output  [  1: 0] lcd_control_slave_address;
  output           lcd_control_slave_begintransfer;
  output           lcd_control_slave_read;
  output  [  7: 0] lcd_control_slave_readdata_from_sa;
  output           lcd_control_slave_wait_counter_eq_0;
  output           lcd_control_slave_write;
  output  [  7: 0] lcd_control_slave_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [  7: 0] lcd_control_slave_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_lcd_control_slave;
  wire             cpu_data_master_qualified_request_lcd_control_slave;
  wire             cpu_data_master_read_data_valid_lcd_control_slave;
  wire             cpu_data_master_requests_lcd_control_slave;
  wire             cpu_data_master_saved_grant_lcd_control_slave;
  reg              d1_lcd_control_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_lcd_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] lcd_control_slave_address;
  wire             lcd_control_slave_allgrants;
  wire             lcd_control_slave_allow_new_arb_cycle;
  wire             lcd_control_slave_any_bursting_master_saved_grant;
  wire             lcd_control_slave_any_continuerequest;
  wire             lcd_control_slave_arb_counter_enable;
  reg     [  1: 0] lcd_control_slave_arb_share_counter;
  wire    [  1: 0] lcd_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] lcd_control_slave_arb_share_set_values;
  wire             lcd_control_slave_beginbursttransfer_internal;
  wire             lcd_control_slave_begins_xfer;
  wire             lcd_control_slave_begintransfer;
  wire    [  6: 0] lcd_control_slave_counter_load_value;
  wire             lcd_control_slave_end_xfer;
  wire             lcd_control_slave_firsttransfer;
  wire             lcd_control_slave_grant_vector;
  wire             lcd_control_slave_in_a_read_cycle;
  wire             lcd_control_slave_in_a_write_cycle;
  wire             lcd_control_slave_master_qreq_vector;
  wire             lcd_control_slave_non_bursting_master_requests;
  wire             lcd_control_slave_pretend_byte_enable;
  wire             lcd_control_slave_read;
  wire    [  7: 0] lcd_control_slave_readdata_from_sa;
  reg              lcd_control_slave_reg_firsttransfer;
  reg              lcd_control_slave_slavearbiterlockenable;
  wire             lcd_control_slave_slavearbiterlockenable2;
  wire             lcd_control_slave_unreg_firsttransfer;
  reg     [  6: 0] lcd_control_slave_wait_counter;
  wire             lcd_control_slave_wait_counter_eq_0;
  wire             lcd_control_slave_waits_for_read;
  wire             lcd_control_slave_waits_for_write;
  wire             lcd_control_slave_write;
  wire    [  7: 0] lcd_control_slave_writedata;
  wire    [ 27: 0] shifted_address_to_lcd_control_slave_from_cpu_data_master;
  wire             wait_for_lcd_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~lcd_control_slave_end_xfer;
    end


  assign lcd_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_lcd_control_slave));
  //assign lcd_control_slave_readdata_from_sa = lcd_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign lcd_control_slave_readdata_from_sa = lcd_control_slave_readdata;

  assign cpu_data_master_requests_lcd_control_slave = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9605160) & (cpu_data_master_read | cpu_data_master_write);
  //lcd_control_slave_arb_share_counter set values, which is an e_mux
  assign lcd_control_slave_arb_share_set_values = 1;

  //lcd_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign lcd_control_slave_non_bursting_master_requests = cpu_data_master_requests_lcd_control_slave;

  //lcd_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign lcd_control_slave_any_bursting_master_saved_grant = 0;

  //lcd_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign lcd_control_slave_arb_share_counter_next_value = lcd_control_slave_firsttransfer ? (lcd_control_slave_arb_share_set_values - 1) : |lcd_control_slave_arb_share_counter ? (lcd_control_slave_arb_share_counter - 1) : 0;

  //lcd_control_slave_allgrants all slave grants, which is an e_mux
  assign lcd_control_slave_allgrants = |lcd_control_slave_grant_vector;

  //lcd_control_slave_end_xfer assignment, which is an e_assign
  assign lcd_control_slave_end_xfer = ~(lcd_control_slave_waits_for_read | lcd_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_lcd_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_lcd_control_slave = lcd_control_slave_end_xfer & (~lcd_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //lcd_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign lcd_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_lcd_control_slave & lcd_control_slave_allgrants) | (end_xfer_arb_share_counter_term_lcd_control_slave & ~lcd_control_slave_non_bursting_master_requests);

  //lcd_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_arb_share_counter <= 0;
      else if (lcd_control_slave_arb_counter_enable)
          lcd_control_slave_arb_share_counter <= lcd_control_slave_arb_share_counter_next_value;
    end


  //lcd_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_slavearbiterlockenable <= 0;
      else if ((|lcd_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_lcd_control_slave) | (end_xfer_arb_share_counter_term_lcd_control_slave & ~lcd_control_slave_non_bursting_master_requests))
          lcd_control_slave_slavearbiterlockenable <= |lcd_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master lcd/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = lcd_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //lcd_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign lcd_control_slave_slavearbiterlockenable2 = |lcd_control_slave_arb_share_counter_next_value;

  //cpu/data_master lcd/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = lcd_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //lcd_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign lcd_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_lcd_control_slave = cpu_data_master_requests_lcd_control_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_lcd_control_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_lcd_control_slave = cpu_data_master_granted_lcd_control_slave & cpu_data_master_read & ~lcd_control_slave_waits_for_read;

  //lcd_control_slave_writedata mux, which is an e_mux
  assign lcd_control_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_lcd_control_slave = cpu_data_master_qualified_request_lcd_control_slave;

  //cpu/data_master saved-grant lcd/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_lcd_control_slave = cpu_data_master_requests_lcd_control_slave;

  //allow new arb cycle for lcd/control_slave, which is an e_assign
  assign lcd_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign lcd_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign lcd_control_slave_master_qreq_vector = 1;

  assign lcd_control_slave_begintransfer = lcd_control_slave_begins_xfer;
  //lcd_control_slave_firsttransfer first transaction, which is an e_assign
  assign lcd_control_slave_firsttransfer = lcd_control_slave_begins_xfer ? lcd_control_slave_unreg_firsttransfer : lcd_control_slave_reg_firsttransfer;

  //lcd_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign lcd_control_slave_unreg_firsttransfer = ~(lcd_control_slave_slavearbiterlockenable & lcd_control_slave_any_continuerequest);

  //lcd_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_reg_firsttransfer <= 1'b1;
      else if (lcd_control_slave_begins_xfer)
          lcd_control_slave_reg_firsttransfer <= lcd_control_slave_unreg_firsttransfer;
    end


  //lcd_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign lcd_control_slave_beginbursttransfer_internal = lcd_control_slave_begins_xfer;

  //lcd_control_slave_read assignment, which is an e_mux
  assign lcd_control_slave_read = ((cpu_data_master_granted_lcd_control_slave & cpu_data_master_read))& ~lcd_control_slave_begins_xfer & (lcd_control_slave_wait_counter < 25);

  //lcd_control_slave_write assignment, which is an e_mux
  assign lcd_control_slave_write = ((cpu_data_master_granted_lcd_control_slave & cpu_data_master_write)) & ~lcd_control_slave_begins_xfer & (lcd_control_slave_wait_counter >= 25) & (lcd_control_slave_wait_counter < 50) & lcd_control_slave_pretend_byte_enable;

  assign shifted_address_to_lcd_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //lcd_control_slave_address mux, which is an e_mux
  assign lcd_control_slave_address = shifted_address_to_lcd_control_slave_from_cpu_data_master >> 2;

  //d1_lcd_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_lcd_control_slave_end_xfer <= 1;
      else if (1)
          d1_lcd_control_slave_end_xfer <= lcd_control_slave_end_xfer;
    end


  //lcd_control_slave_waits_for_read in a cycle, which is an e_mux
  assign lcd_control_slave_waits_for_read = lcd_control_slave_in_a_read_cycle & wait_for_lcd_control_slave_counter;

  //lcd_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign lcd_control_slave_in_a_read_cycle = cpu_data_master_granted_lcd_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = lcd_control_slave_in_a_read_cycle;

  //lcd_control_slave_waits_for_write in a cycle, which is an e_mux
  assign lcd_control_slave_waits_for_write = lcd_control_slave_in_a_write_cycle & wait_for_lcd_control_slave_counter;

  //lcd_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign lcd_control_slave_in_a_write_cycle = cpu_data_master_granted_lcd_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = lcd_control_slave_in_a_write_cycle;

  assign lcd_control_slave_wait_counter_eq_0 = lcd_control_slave_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          lcd_control_slave_wait_counter <= 0;
      else if (1)
          lcd_control_slave_wait_counter <= lcd_control_slave_counter_load_value;
    end


  assign lcd_control_slave_counter_load_value = ((lcd_control_slave_in_a_read_cycle & lcd_control_slave_begins_xfer))? 48 :
    ((lcd_control_slave_in_a_write_cycle & lcd_control_slave_begins_xfer))? 73 :
    (~lcd_control_slave_wait_counter_eq_0)? lcd_control_slave_wait_counter - 1 :
    0;

  assign wait_for_lcd_control_slave_counter = lcd_control_slave_begins_xfer | ~lcd_control_slave_wait_counter_eq_0;
  //lcd_control_slave_pretend_byte_enable byte enable port mux, which is an e_mux
  assign lcd_control_slave_pretend_byte_enable = (cpu_data_master_granted_lcd_control_slave)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //lcd/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ii_clock_0_in_arbitrator (
                                       // inputs:
                                        clk,
                                        cpu_data_master_address_to_slave,
                                        cpu_data_master_byteenable,
                                        cpu_data_master_latency_counter,
                                        cpu_data_master_read,
                                        cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                        cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                        cpu_data_master_write,
                                        cpu_data_master_writedata,
                                        nios_ii_clock_0_in_endofpacket,
                                        nios_ii_clock_0_in_readdata,
                                        nios_ii_clock_0_in_waitrequest,
                                        reset_n,

                                       // outputs:
                                        cpu_data_master_granted_nios_ii_clock_0_in,
                                        cpu_data_master_qualified_request_nios_ii_clock_0_in,
                                        cpu_data_master_read_data_valid_nios_ii_clock_0_in,
                                        cpu_data_master_requests_nios_ii_clock_0_in,
                                        d1_nios_ii_clock_0_in_end_xfer,
                                        nios_ii_clock_0_in_address,
                                        nios_ii_clock_0_in_byteenable,
                                        nios_ii_clock_0_in_endofpacket_from_sa,
                                        nios_ii_clock_0_in_nativeaddress,
                                        nios_ii_clock_0_in_read,
                                        nios_ii_clock_0_in_readdata_from_sa,
                                        nios_ii_clock_0_in_reset_n,
                                        nios_ii_clock_0_in_waitrequest_from_sa,
                                        nios_ii_clock_0_in_write,
                                        nios_ii_clock_0_in_writedata
                                     )
;

  output           cpu_data_master_granted_nios_ii_clock_0_in;
  output           cpu_data_master_qualified_request_nios_ii_clock_0_in;
  output           cpu_data_master_read_data_valid_nios_ii_clock_0_in;
  output           cpu_data_master_requests_nios_ii_clock_0_in;
  output           d1_nios_ii_clock_0_in_end_xfer;
  output  [  3: 0] nios_ii_clock_0_in_address;
  output  [  1: 0] nios_ii_clock_0_in_byteenable;
  output           nios_ii_clock_0_in_endofpacket_from_sa;
  output  [  2: 0] nios_ii_clock_0_in_nativeaddress;
  output           nios_ii_clock_0_in_read;
  output  [ 15: 0] nios_ii_clock_0_in_readdata_from_sa;
  output           nios_ii_clock_0_in_reset_n;
  output           nios_ii_clock_0_in_waitrequest_from_sa;
  output           nios_ii_clock_0_in_write;
  output  [ 15: 0] nios_ii_clock_0_in_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            nios_ii_clock_0_in_endofpacket;
  input   [ 15: 0] nios_ii_clock_0_in_readdata;
  input            nios_ii_clock_0_in_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_nios_ii_clock_0_in;
  wire             cpu_data_master_qualified_request_nios_ii_clock_0_in;
  wire             cpu_data_master_read_data_valid_nios_ii_clock_0_in;
  wire             cpu_data_master_requests_nios_ii_clock_0_in;
  wire             cpu_data_master_saved_grant_nios_ii_clock_0_in;
  reg              d1_nios_ii_clock_0_in_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_nios_ii_clock_0_in;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  3: 0] nios_ii_clock_0_in_address;
  wire             nios_ii_clock_0_in_allgrants;
  wire             nios_ii_clock_0_in_allow_new_arb_cycle;
  wire             nios_ii_clock_0_in_any_bursting_master_saved_grant;
  wire             nios_ii_clock_0_in_any_continuerequest;
  wire             nios_ii_clock_0_in_arb_counter_enable;
  reg     [  1: 0] nios_ii_clock_0_in_arb_share_counter;
  wire    [  1: 0] nios_ii_clock_0_in_arb_share_counter_next_value;
  wire    [  1: 0] nios_ii_clock_0_in_arb_share_set_values;
  wire             nios_ii_clock_0_in_beginbursttransfer_internal;
  wire             nios_ii_clock_0_in_begins_xfer;
  wire    [  1: 0] nios_ii_clock_0_in_byteenable;
  wire             nios_ii_clock_0_in_end_xfer;
  wire             nios_ii_clock_0_in_endofpacket_from_sa;
  wire             nios_ii_clock_0_in_firsttransfer;
  wire             nios_ii_clock_0_in_grant_vector;
  wire             nios_ii_clock_0_in_in_a_read_cycle;
  wire             nios_ii_clock_0_in_in_a_write_cycle;
  wire             nios_ii_clock_0_in_master_qreq_vector;
  wire    [  2: 0] nios_ii_clock_0_in_nativeaddress;
  wire             nios_ii_clock_0_in_non_bursting_master_requests;
  wire             nios_ii_clock_0_in_read;
  wire    [ 15: 0] nios_ii_clock_0_in_readdata_from_sa;
  reg              nios_ii_clock_0_in_reg_firsttransfer;
  wire             nios_ii_clock_0_in_reset_n;
  reg              nios_ii_clock_0_in_slavearbiterlockenable;
  wire             nios_ii_clock_0_in_slavearbiterlockenable2;
  wire             nios_ii_clock_0_in_unreg_firsttransfer;
  wire             nios_ii_clock_0_in_waitrequest_from_sa;
  wire             nios_ii_clock_0_in_waits_for_read;
  wire             nios_ii_clock_0_in_waits_for_write;
  wire             nios_ii_clock_0_in_write;
  wire    [ 15: 0] nios_ii_clock_0_in_writedata;
  wire    [ 27: 0] shifted_address_to_nios_ii_clock_0_in_from_cpu_data_master;
  wire             wait_for_nios_ii_clock_0_in_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~nios_ii_clock_0_in_end_xfer;
    end


  assign nios_ii_clock_0_in_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_nios_ii_clock_0_in));
  //assign nios_ii_clock_0_in_readdata_from_sa = nios_ii_clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_ii_clock_0_in_readdata_from_sa = nios_ii_clock_0_in_readdata;

  assign cpu_data_master_requests_nios_ii_clock_0_in = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96050e0) & (cpu_data_master_read | cpu_data_master_write);
  //assign nios_ii_clock_0_in_waitrequest_from_sa = nios_ii_clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_ii_clock_0_in_waitrequest_from_sa = nios_ii_clock_0_in_waitrequest;

  //nios_ii_clock_0_in_arb_share_counter set values, which is an e_mux
  assign nios_ii_clock_0_in_arb_share_set_values = 1;

  //nios_ii_clock_0_in_non_bursting_master_requests mux, which is an e_mux
  assign nios_ii_clock_0_in_non_bursting_master_requests = cpu_data_master_requests_nios_ii_clock_0_in;

  //nios_ii_clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  assign nios_ii_clock_0_in_any_bursting_master_saved_grant = 0;

  //nios_ii_clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  assign nios_ii_clock_0_in_arb_share_counter_next_value = nios_ii_clock_0_in_firsttransfer ? (nios_ii_clock_0_in_arb_share_set_values - 1) : |nios_ii_clock_0_in_arb_share_counter ? (nios_ii_clock_0_in_arb_share_counter - 1) : 0;

  //nios_ii_clock_0_in_allgrants all slave grants, which is an e_mux
  assign nios_ii_clock_0_in_allgrants = |nios_ii_clock_0_in_grant_vector;

  //nios_ii_clock_0_in_end_xfer assignment, which is an e_assign
  assign nios_ii_clock_0_in_end_xfer = ~(nios_ii_clock_0_in_waits_for_read | nios_ii_clock_0_in_waits_for_write);

  //end_xfer_arb_share_counter_term_nios_ii_clock_0_in arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_nios_ii_clock_0_in = nios_ii_clock_0_in_end_xfer & (~nios_ii_clock_0_in_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //nios_ii_clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  assign nios_ii_clock_0_in_arb_counter_enable = (end_xfer_arb_share_counter_term_nios_ii_clock_0_in & nios_ii_clock_0_in_allgrants) | (end_xfer_arb_share_counter_term_nios_ii_clock_0_in & ~nios_ii_clock_0_in_non_bursting_master_requests);

  //nios_ii_clock_0_in_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_in_arb_share_counter <= 0;
      else if (nios_ii_clock_0_in_arb_counter_enable)
          nios_ii_clock_0_in_arb_share_counter <= nios_ii_clock_0_in_arb_share_counter_next_value;
    end


  //nios_ii_clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_in_slavearbiterlockenable <= 0;
      else if ((|nios_ii_clock_0_in_master_qreq_vector & end_xfer_arb_share_counter_term_nios_ii_clock_0_in) | (end_xfer_arb_share_counter_term_nios_ii_clock_0_in & ~nios_ii_clock_0_in_non_bursting_master_requests))
          nios_ii_clock_0_in_slavearbiterlockenable <= |nios_ii_clock_0_in_arb_share_counter_next_value;
    end


  //cpu/data_master nios_ii_clock_0/in arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = nios_ii_clock_0_in_slavearbiterlockenable & cpu_data_master_continuerequest;

  //nios_ii_clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign nios_ii_clock_0_in_slavearbiterlockenable2 = |nios_ii_clock_0_in_arb_share_counter_next_value;

  //cpu/data_master nios_ii_clock_0/in arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = nios_ii_clock_0_in_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //nios_ii_clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  assign nios_ii_clock_0_in_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_nios_ii_clock_0_in = cpu_data_master_requests_nios_ii_clock_0_in & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_nios_ii_clock_0_in, which is an e_mux
  assign cpu_data_master_read_data_valid_nios_ii_clock_0_in = cpu_data_master_granted_nios_ii_clock_0_in & cpu_data_master_read & ~nios_ii_clock_0_in_waits_for_read;

  //nios_ii_clock_0_in_writedata mux, which is an e_mux
  assign nios_ii_clock_0_in_writedata = cpu_data_master_writedata;

  //assign nios_ii_clock_0_in_endofpacket_from_sa = nios_ii_clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign nios_ii_clock_0_in_endofpacket_from_sa = nios_ii_clock_0_in_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_nios_ii_clock_0_in = cpu_data_master_qualified_request_nios_ii_clock_0_in;

  //cpu/data_master saved-grant nios_ii_clock_0/in, which is an e_assign
  assign cpu_data_master_saved_grant_nios_ii_clock_0_in = cpu_data_master_requests_nios_ii_clock_0_in;

  //allow new arb cycle for nios_ii_clock_0/in, which is an e_assign
  assign nios_ii_clock_0_in_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign nios_ii_clock_0_in_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign nios_ii_clock_0_in_master_qreq_vector = 1;

  //nios_ii_clock_0_in_reset_n assignment, which is an e_assign
  assign nios_ii_clock_0_in_reset_n = reset_n;

  //nios_ii_clock_0_in_firsttransfer first transaction, which is an e_assign
  assign nios_ii_clock_0_in_firsttransfer = nios_ii_clock_0_in_begins_xfer ? nios_ii_clock_0_in_unreg_firsttransfer : nios_ii_clock_0_in_reg_firsttransfer;

  //nios_ii_clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  assign nios_ii_clock_0_in_unreg_firsttransfer = ~(nios_ii_clock_0_in_slavearbiterlockenable & nios_ii_clock_0_in_any_continuerequest);

  //nios_ii_clock_0_in_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_in_reg_firsttransfer <= 1'b1;
      else if (nios_ii_clock_0_in_begins_xfer)
          nios_ii_clock_0_in_reg_firsttransfer <= nios_ii_clock_0_in_unreg_firsttransfer;
    end


  //nios_ii_clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign nios_ii_clock_0_in_beginbursttransfer_internal = nios_ii_clock_0_in_begins_xfer;

  //nios_ii_clock_0_in_read assignment, which is an e_mux
  assign nios_ii_clock_0_in_read = cpu_data_master_granted_nios_ii_clock_0_in & cpu_data_master_read;

  //nios_ii_clock_0_in_write assignment, which is an e_mux
  assign nios_ii_clock_0_in_write = cpu_data_master_granted_nios_ii_clock_0_in & cpu_data_master_write;

  assign shifted_address_to_nios_ii_clock_0_in_from_cpu_data_master = cpu_data_master_address_to_slave;
  //nios_ii_clock_0_in_address mux, which is an e_mux
  assign nios_ii_clock_0_in_address = shifted_address_to_nios_ii_clock_0_in_from_cpu_data_master >> 2;

  //slaveid nios_ii_clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  assign nios_ii_clock_0_in_nativeaddress = cpu_data_master_address_to_slave >> 2;

  //d1_nios_ii_clock_0_in_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_nios_ii_clock_0_in_end_xfer <= 1;
      else if (1)
          d1_nios_ii_clock_0_in_end_xfer <= nios_ii_clock_0_in_end_xfer;
    end


  //nios_ii_clock_0_in_waits_for_read in a cycle, which is an e_mux
  assign nios_ii_clock_0_in_waits_for_read = nios_ii_clock_0_in_in_a_read_cycle & nios_ii_clock_0_in_waitrequest_from_sa;

  //nios_ii_clock_0_in_in_a_read_cycle assignment, which is an e_assign
  assign nios_ii_clock_0_in_in_a_read_cycle = cpu_data_master_granted_nios_ii_clock_0_in & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = nios_ii_clock_0_in_in_a_read_cycle;

  //nios_ii_clock_0_in_waits_for_write in a cycle, which is an e_mux
  assign nios_ii_clock_0_in_waits_for_write = nios_ii_clock_0_in_in_a_write_cycle & nios_ii_clock_0_in_waitrequest_from_sa;

  //nios_ii_clock_0_in_in_a_write_cycle assignment, which is an e_assign
  assign nios_ii_clock_0_in_in_a_write_cycle = cpu_data_master_granted_nios_ii_clock_0_in & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = nios_ii_clock_0_in_in_a_write_cycle;

  assign wait_for_nios_ii_clock_0_in_counter = 0;
  //nios_ii_clock_0_in_byteenable byte enable port mux, which is an e_mux
  assign nios_ii_clock_0_in_byteenable = (cpu_data_master_granted_nios_ii_clock_0_in)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_ii_clock_0/in enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ii_clock_0_out_arbitrator (
                                        // inputs:
                                         clk,
                                         d1_pll_s1_end_xfer,
                                         nios_ii_clock_0_out_address,
                                         nios_ii_clock_0_out_granted_pll_s1,
                                         nios_ii_clock_0_out_qualified_request_pll_s1,
                                         nios_ii_clock_0_out_read,
                                         nios_ii_clock_0_out_read_data_valid_pll_s1,
                                         nios_ii_clock_0_out_requests_pll_s1,
                                         nios_ii_clock_0_out_write,
                                         nios_ii_clock_0_out_writedata,
                                         pll_s1_readdata_from_sa,
                                         reset_n,

                                        // outputs:
                                         nios_ii_clock_0_out_address_to_slave,
                                         nios_ii_clock_0_out_readdata,
                                         nios_ii_clock_0_out_reset_n,
                                         nios_ii_clock_0_out_waitrequest
                                      )
;

  output  [  3: 0] nios_ii_clock_0_out_address_to_slave;
  output  [ 15: 0] nios_ii_clock_0_out_readdata;
  output           nios_ii_clock_0_out_reset_n;
  output           nios_ii_clock_0_out_waitrequest;
  input            clk;
  input            d1_pll_s1_end_xfer;
  input   [  3: 0] nios_ii_clock_0_out_address;
  input            nios_ii_clock_0_out_granted_pll_s1;
  input            nios_ii_clock_0_out_qualified_request_pll_s1;
  input            nios_ii_clock_0_out_read;
  input            nios_ii_clock_0_out_read_data_valid_pll_s1;
  input            nios_ii_clock_0_out_requests_pll_s1;
  input            nios_ii_clock_0_out_write;
  input   [ 15: 0] nios_ii_clock_0_out_writedata;
  input   [ 15: 0] pll_s1_readdata_from_sa;
  input            reset_n;

  reg              active_and_waiting_last_time;
  reg     [  3: 0] nios_ii_clock_0_out_address_last_time;
  wire    [  3: 0] nios_ii_clock_0_out_address_to_slave;
  reg              nios_ii_clock_0_out_read_last_time;
  wire    [ 15: 0] nios_ii_clock_0_out_readdata;
  wire             nios_ii_clock_0_out_reset_n;
  wire             nios_ii_clock_0_out_run;
  wire             nios_ii_clock_0_out_waitrequest;
  reg              nios_ii_clock_0_out_write_last_time;
  reg     [ 15: 0] nios_ii_clock_0_out_writedata_last_time;
  wire             r_2;
  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & ((~nios_ii_clock_0_out_qualified_request_pll_s1 | ~nios_ii_clock_0_out_read | (1 & ~d1_pll_s1_end_xfer & nios_ii_clock_0_out_read))) & ((~nios_ii_clock_0_out_qualified_request_pll_s1 | ~nios_ii_clock_0_out_write | (1 & nios_ii_clock_0_out_write)));

  //cascaded wait assignment, which is an e_assign
  assign nios_ii_clock_0_out_run = r_2;

  //optimize select-logic by passing only those address bits which matter.
  assign nios_ii_clock_0_out_address_to_slave = nios_ii_clock_0_out_address;

  //nios_ii_clock_0/out readdata mux, which is an e_mux
  assign nios_ii_clock_0_out_readdata = pll_s1_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign nios_ii_clock_0_out_waitrequest = ~nios_ii_clock_0_out_run;

  //nios_ii_clock_0_out_reset_n assignment, which is an e_assign
  assign nios_ii_clock_0_out_reset_n = reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //nios_ii_clock_0_out_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_out_address_last_time <= 0;
      else if (1)
          nios_ii_clock_0_out_address_last_time <= nios_ii_clock_0_out_address;
    end


  //nios_ii_clock_0/out waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= nios_ii_clock_0_out_waitrequest & (nios_ii_clock_0_out_read | nios_ii_clock_0_out_write);
    end


  //nios_ii_clock_0_out_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_ii_clock_0_out_address != nios_ii_clock_0_out_address_last_time))
        begin
          $write("%0d ns: nios_ii_clock_0_out_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_ii_clock_0_out_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_out_read_last_time <= 0;
      else if (1)
          nios_ii_clock_0_out_read_last_time <= nios_ii_clock_0_out_read;
    end


  //nios_ii_clock_0_out_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_ii_clock_0_out_read != nios_ii_clock_0_out_read_last_time))
        begin
          $write("%0d ns: nios_ii_clock_0_out_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_ii_clock_0_out_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_out_write_last_time <= 0;
      else if (1)
          nios_ii_clock_0_out_write_last_time <= nios_ii_clock_0_out_write;
    end


  //nios_ii_clock_0_out_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_ii_clock_0_out_write != nios_ii_clock_0_out_write_last_time))
        begin
          $write("%0d ns: nios_ii_clock_0_out_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //nios_ii_clock_0_out_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          nios_ii_clock_0_out_writedata_last_time <= 0;
      else if (1)
          nios_ii_clock_0_out_writedata_last_time <= nios_ii_clock_0_out_writedata;
    end


  //nios_ii_clock_0_out_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (nios_ii_clock_0_out_writedata != nios_ii_clock_0_out_writedata_last_time) & nios_ii_clock_0_out_write)
        begin
          $write("%0d ns: nios_ii_clock_0_out_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_mem_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_byteenable,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   cpu_instruction_master_address_to_slave,
                                   cpu_instruction_master_latency_counter,
                                   cpu_instruction_master_read,
                                   cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                   onchip_mem_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_onchip_mem_s1,
                                   cpu_data_master_qualified_request_onchip_mem_s1,
                                   cpu_data_master_read_data_valid_onchip_mem_s1,
                                   cpu_data_master_requests_onchip_mem_s1,
                                   cpu_instruction_master_granted_onchip_mem_s1,
                                   cpu_instruction_master_qualified_request_onchip_mem_s1,
                                   cpu_instruction_master_read_data_valid_onchip_mem_s1,
                                   cpu_instruction_master_requests_onchip_mem_s1,
                                   d1_onchip_mem_s1_end_xfer,
                                   onchip_mem_s1_address,
                                   onchip_mem_s1_byteenable,
                                   onchip_mem_s1_chipselect,
                                   onchip_mem_s1_clken,
                                   onchip_mem_s1_readdata_from_sa,
                                   onchip_mem_s1_write,
                                   onchip_mem_s1_writedata
                                )
;

  output           cpu_data_master_granted_onchip_mem_s1;
  output           cpu_data_master_qualified_request_onchip_mem_s1;
  output           cpu_data_master_read_data_valid_onchip_mem_s1;
  output           cpu_data_master_requests_onchip_mem_s1;
  output           cpu_instruction_master_granted_onchip_mem_s1;
  output           cpu_instruction_master_qualified_request_onchip_mem_s1;
  output           cpu_instruction_master_read_data_valid_onchip_mem_s1;
  output           cpu_instruction_master_requests_onchip_mem_s1;
  output           d1_onchip_mem_s1_end_xfer;
  output  [ 10: 0] onchip_mem_s1_address;
  output  [  3: 0] onchip_mem_s1_byteenable;
  output           onchip_mem_s1_chipselect;
  output           onchip_mem_s1_clken;
  output  [ 31: 0] onchip_mem_s1_readdata_from_sa;
  output           onchip_mem_s1_write;
  output  [ 31: 0] onchip_mem_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input   [ 31: 0] onchip_mem_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_onchip_mem_s1;
  wire             cpu_data_master_qualified_request_onchip_mem_s1;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1;
  reg              cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in;
  wire             cpu_data_master_requests_onchip_mem_s1;
  wire             cpu_data_master_saved_grant_onchip_mem_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_onchip_mem_s1;
  wire             cpu_instruction_master_qualified_request_onchip_mem_s1;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1;
  reg              cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in;
  wire             cpu_instruction_master_requests_onchip_mem_s1;
  wire             cpu_instruction_master_saved_grant_onchip_mem_s1;
  reg              d1_onchip_mem_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_mem_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_onchip_mem_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1;
  wire    [ 10: 0] onchip_mem_s1_address;
  wire             onchip_mem_s1_allgrants;
  wire             onchip_mem_s1_allow_new_arb_cycle;
  wire             onchip_mem_s1_any_bursting_master_saved_grant;
  wire             onchip_mem_s1_any_continuerequest;
  reg     [  1: 0] onchip_mem_s1_arb_addend;
  wire             onchip_mem_s1_arb_counter_enable;
  reg     [  1: 0] onchip_mem_s1_arb_share_counter;
  wire    [  1: 0] onchip_mem_s1_arb_share_counter_next_value;
  wire    [  1: 0] onchip_mem_s1_arb_share_set_values;
  wire    [  1: 0] onchip_mem_s1_arb_winner;
  wire             onchip_mem_s1_arbitration_holdoff_internal;
  wire             onchip_mem_s1_beginbursttransfer_internal;
  wire             onchip_mem_s1_begins_xfer;
  wire    [  3: 0] onchip_mem_s1_byteenable;
  wire             onchip_mem_s1_chipselect;
  wire    [  3: 0] onchip_mem_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_mem_s1_chosen_master_rot_left;
  wire             onchip_mem_s1_clken;
  wire             onchip_mem_s1_end_xfer;
  wire             onchip_mem_s1_firsttransfer;
  wire    [  1: 0] onchip_mem_s1_grant_vector;
  wire             onchip_mem_s1_in_a_read_cycle;
  wire             onchip_mem_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_mem_s1_master_qreq_vector;
  wire             onchip_mem_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_mem_s1_readdata_from_sa;
  reg              onchip_mem_s1_reg_firsttransfer;
  reg     [  1: 0] onchip_mem_s1_saved_chosen_master_vector;
  reg              onchip_mem_s1_slavearbiterlockenable;
  wire             onchip_mem_s1_slavearbiterlockenable2;
  wire             onchip_mem_s1_unreg_firsttransfer;
  wire             onchip_mem_s1_waits_for_read;
  wire             onchip_mem_s1_waits_for_write;
  wire             onchip_mem_s1_write;
  wire    [ 31: 0] onchip_mem_s1_writedata;
  wire             p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
  wire             p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
  wire    [ 27: 0] shifted_address_to_onchip_mem_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_onchip_mem_s1_from_cpu_instruction_master;
  wire             wait_for_onchip_mem_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~onchip_mem_s1_end_xfer;
    end


  assign onchip_mem_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_onchip_mem_s1 | cpu_instruction_master_qualified_request_onchip_mem_s1));
  //assign onchip_mem_s1_readdata_from_sa = onchip_mem_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_mem_s1_readdata_from_sa = onchip_mem_s1_readdata;

  assign cpu_data_master_requests_onchip_mem_s1 = ({cpu_data_master_address_to_slave[27 : 13] , 13'b0} == 28'h9602000) & (cpu_data_master_read | cpu_data_master_write);
  //onchip_mem_s1_arb_share_counter set values, which is an e_mux
  assign onchip_mem_s1_arb_share_set_values = 1;

  //onchip_mem_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_mem_s1_non_bursting_master_requests = cpu_data_master_requests_onchip_mem_s1 |
    cpu_instruction_master_requests_onchip_mem_s1 |
    cpu_data_master_requests_onchip_mem_s1 |
    cpu_instruction_master_requests_onchip_mem_s1;

  //onchip_mem_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_mem_s1_any_bursting_master_saved_grant = 0;

  //onchip_mem_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_mem_s1_arb_share_counter_next_value = onchip_mem_s1_firsttransfer ? (onchip_mem_s1_arb_share_set_values - 1) : |onchip_mem_s1_arb_share_counter ? (onchip_mem_s1_arb_share_counter - 1) : 0;

  //onchip_mem_s1_allgrants all slave grants, which is an e_mux
  assign onchip_mem_s1_allgrants = |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector |
    |onchip_mem_s1_grant_vector;

  //onchip_mem_s1_end_xfer assignment, which is an e_assign
  assign onchip_mem_s1_end_xfer = ~(onchip_mem_s1_waits_for_read | onchip_mem_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_mem_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_mem_s1 = onchip_mem_s1_end_xfer & (~onchip_mem_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_mem_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_mem_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_mem_s1 & onchip_mem_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_mem_s1 & ~onchip_mem_s1_non_bursting_master_requests);

  //onchip_mem_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_arb_share_counter <= 0;
      else if (onchip_mem_s1_arb_counter_enable)
          onchip_mem_s1_arb_share_counter <= onchip_mem_s1_arb_share_counter_next_value;
    end


  //onchip_mem_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_mem_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_mem_s1) | (end_xfer_arb_share_counter_term_onchip_mem_s1 & ~onchip_mem_s1_non_bursting_master_requests))
          onchip_mem_s1_slavearbiterlockenable <= |onchip_mem_s1_arb_share_counter_next_value;
    end


  //cpu/data_master onchip_mem/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = onchip_mem_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //onchip_mem_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_mem_s1_slavearbiterlockenable2 = |onchip_mem_s1_arb_share_counter_next_value;

  //cpu/data_master onchip_mem/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = onchip_mem_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master onchip_mem/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = onchip_mem_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master onchip_mem/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = onchip_mem_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted onchip_mem/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 <= cpu_instruction_master_saved_grant_onchip_mem_s1 ? 1 : (onchip_mem_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_onchip_mem_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_onchip_mem_s1 & cpu_instruction_master_requests_onchip_mem_s1;

  //onchip_mem_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_mem_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_onchip_mem_s1 = cpu_data_master_requests_onchip_mem_s1 & ~((cpu_data_master_read & ((1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_instruction_master_arbiterlock);
  //cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_read & ~onchip_mem_s1_waits_for_read;

  //shift register p1 cpu_data_master_read_data_valid_onchip_mem_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register = {cpu_data_master_read_data_valid_onchip_mem_s1_shift_register, cpu_data_master_read_data_valid_onchip_mem_s1_shift_register_in};

  //cpu_data_master_read_data_valid_onchip_mem_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_read_data_valid_onchip_mem_s1_shift_register <= 0;
      else if (1)
          cpu_data_master_read_data_valid_onchip_mem_s1_shift_register <= p1_cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;
    end


  //local readdatavalid cpu_data_master_read_data_valid_onchip_mem_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_onchip_mem_s1 = cpu_data_master_read_data_valid_onchip_mem_s1_shift_register;

  //onchip_mem_s1_writedata mux, which is an e_mux
  assign onchip_mem_s1_writedata = cpu_data_master_writedata;

  //mux onchip_mem_s1_clken, which is an e_mux
  assign onchip_mem_s1_clken = 1'b1;

  assign cpu_instruction_master_requests_onchip_mem_s1 = (({cpu_instruction_master_address_to_slave[27 : 13] , 13'b0} == 28'h9602000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted onchip_mem/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 <= cpu_data_master_saved_grant_onchip_mem_s1 ? 1 : (onchip_mem_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_onchip_mem_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_onchip_mem_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_onchip_mem_s1 & cpu_data_master_requests_onchip_mem_s1;

  assign cpu_instruction_master_qualified_request_onchip_mem_s1 = cpu_instruction_master_requests_onchip_mem_s1 & ~((cpu_instruction_master_read & ((1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in = cpu_instruction_master_granted_onchip_mem_s1 & cpu_instruction_master_read & ~onchip_mem_s1_waits_for_read;

  //shift register p1 cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register = {cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register, cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register_in};

  //cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register <= 0;
      else if (1)
          cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register <= p1_cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;
    end


  //local readdatavalid cpu_instruction_master_read_data_valid_onchip_mem_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_onchip_mem_s1 = cpu_instruction_master_read_data_valid_onchip_mem_s1_shift_register;

  //allow new arb cycle for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_onchip_mem_s1;

  //cpu/instruction_master grant onchip_mem/s1, which is an e_assign
  assign cpu_instruction_master_granted_onchip_mem_s1 = onchip_mem_s1_grant_vector[0];

  //cpu/instruction_master saved-grant onchip_mem/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_onchip_mem_s1 = onchip_mem_s1_arb_winner[0] && cpu_instruction_master_requests_onchip_mem_s1;

  //cpu/data_master assignment into master qualified-requests vector for onchip_mem/s1, which is an e_assign
  assign onchip_mem_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_onchip_mem_s1;

  //cpu/data_master grant onchip_mem/s1, which is an e_assign
  assign cpu_data_master_granted_onchip_mem_s1 = onchip_mem_s1_grant_vector[1];

  //cpu/data_master saved-grant onchip_mem/s1, which is an e_assign
  assign cpu_data_master_saved_grant_onchip_mem_s1 = onchip_mem_s1_arb_winner[1] && cpu_data_master_requests_onchip_mem_s1;

  //onchip_mem/s1 chosen-master double-vector, which is an e_assign
  assign onchip_mem_s1_chosen_master_double_vector = {onchip_mem_s1_master_qreq_vector, onchip_mem_s1_master_qreq_vector} & ({~onchip_mem_s1_master_qreq_vector, ~onchip_mem_s1_master_qreq_vector} + onchip_mem_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_mem_s1_arb_winner = (onchip_mem_s1_allow_new_arb_cycle & | onchip_mem_s1_grant_vector) ? onchip_mem_s1_grant_vector : onchip_mem_s1_saved_chosen_master_vector;

  //saved onchip_mem_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_saved_chosen_master_vector <= 0;
      else if (onchip_mem_s1_allow_new_arb_cycle)
          onchip_mem_s1_saved_chosen_master_vector <= |onchip_mem_s1_grant_vector ? onchip_mem_s1_grant_vector : onchip_mem_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_mem_s1_grant_vector = {(onchip_mem_s1_chosen_master_double_vector[1] | onchip_mem_s1_chosen_master_double_vector[3]),
    (onchip_mem_s1_chosen_master_double_vector[0] | onchip_mem_s1_chosen_master_double_vector[2])};

  //onchip_mem/s1 chosen master rotated left, which is an e_assign
  assign onchip_mem_s1_chosen_master_rot_left = (onchip_mem_s1_arb_winner << 1) ? (onchip_mem_s1_arb_winner << 1) : 1;

  //onchip_mem/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_arb_addend <= 1;
      else if (|onchip_mem_s1_grant_vector)
          onchip_mem_s1_arb_addend <= onchip_mem_s1_end_xfer? onchip_mem_s1_chosen_master_rot_left : onchip_mem_s1_grant_vector;
    end


  assign onchip_mem_s1_chipselect = cpu_data_master_granted_onchip_mem_s1 | cpu_instruction_master_granted_onchip_mem_s1;
  //onchip_mem_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_mem_s1_firsttransfer = onchip_mem_s1_begins_xfer ? onchip_mem_s1_unreg_firsttransfer : onchip_mem_s1_reg_firsttransfer;

  //onchip_mem_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_mem_s1_unreg_firsttransfer = ~(onchip_mem_s1_slavearbiterlockenable & onchip_mem_s1_any_continuerequest);

  //onchip_mem_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_mem_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_mem_s1_begins_xfer)
          onchip_mem_s1_reg_firsttransfer <= onchip_mem_s1_unreg_firsttransfer;
    end


  //onchip_mem_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_mem_s1_beginbursttransfer_internal = onchip_mem_s1_begins_xfer;

  //onchip_mem_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_mem_s1_arbitration_holdoff_internal = onchip_mem_s1_begins_xfer & onchip_mem_s1_firsttransfer;

  //onchip_mem_s1_write assignment, which is an e_mux
  assign onchip_mem_s1_write = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_write;

  assign shifted_address_to_onchip_mem_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //onchip_mem_s1_address mux, which is an e_mux
  assign onchip_mem_s1_address = (cpu_data_master_granted_onchip_mem_s1)? (shifted_address_to_onchip_mem_s1_from_cpu_data_master >> 2) :
    (shifted_address_to_onchip_mem_s1_from_cpu_instruction_master >> 2);

  assign shifted_address_to_onchip_mem_s1_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_onchip_mem_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_mem_s1_end_xfer <= 1;
      else if (1)
          d1_onchip_mem_s1_end_xfer <= onchip_mem_s1_end_xfer;
    end


  //onchip_mem_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_mem_s1_waits_for_read = onchip_mem_s1_in_a_read_cycle & 0;

  //onchip_mem_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_mem_s1_in_a_read_cycle = (cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_onchip_mem_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_mem_s1_in_a_read_cycle;

  //onchip_mem_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_mem_s1_waits_for_write = onchip_mem_s1_in_a_write_cycle & 0;

  //onchip_mem_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_mem_s1_in_a_write_cycle = cpu_data_master_granted_onchip_mem_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_mem_s1_in_a_write_cycle;

  assign wait_for_onchip_mem_s1_counter = 0;
  //onchip_mem_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_mem_s1_byteenable = (cpu_data_master_granted_onchip_mem_s1)? cpu_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_mem/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_onchip_mem_s1 + cpu_instruction_master_granted_onchip_mem_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_onchip_mem_s1 + cpu_instruction_master_saved_grant_onchip_mem_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_button_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   pio_button_s1_irq,
                                   pio_button_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_pio_button_s1,
                                   cpu_data_master_qualified_request_pio_button_s1,
                                   cpu_data_master_read_data_valid_pio_button_s1,
                                   cpu_data_master_requests_pio_button_s1,
                                   d1_pio_button_s1_end_xfer,
                                   pio_button_s1_address,
                                   pio_button_s1_chipselect,
                                   pio_button_s1_irq_from_sa,
                                   pio_button_s1_readdata_from_sa,
                                   pio_button_s1_reset_n,
                                   pio_button_s1_write_n,
                                   pio_button_s1_writedata
                                )
;

  output           cpu_data_master_granted_pio_button_s1;
  output           cpu_data_master_qualified_request_pio_button_s1;
  output           cpu_data_master_read_data_valid_pio_button_s1;
  output           cpu_data_master_requests_pio_button_s1;
  output           d1_pio_button_s1_end_xfer;
  output  [  1: 0] pio_button_s1_address;
  output           pio_button_s1_chipselect;
  output           pio_button_s1_irq_from_sa;
  output  [  3: 0] pio_button_s1_readdata_from_sa;
  output           pio_button_s1_reset_n;
  output           pio_button_s1_write_n;
  output  [  3: 0] pio_button_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            pio_button_s1_irq;
  input   [  3: 0] pio_button_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_button_s1;
  wire             cpu_data_master_qualified_request_pio_button_s1;
  wire             cpu_data_master_read_data_valid_pio_button_s1;
  wire             cpu_data_master_requests_pio_button_s1;
  wire             cpu_data_master_saved_grant_pio_button_s1;
  reg              d1_pio_button_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_button_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_button_s1_address;
  wire             pio_button_s1_allgrants;
  wire             pio_button_s1_allow_new_arb_cycle;
  wire             pio_button_s1_any_bursting_master_saved_grant;
  wire             pio_button_s1_any_continuerequest;
  wire             pio_button_s1_arb_counter_enable;
  reg     [  1: 0] pio_button_s1_arb_share_counter;
  wire    [  1: 0] pio_button_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_button_s1_arb_share_set_values;
  wire             pio_button_s1_beginbursttransfer_internal;
  wire             pio_button_s1_begins_xfer;
  wire             pio_button_s1_chipselect;
  wire             pio_button_s1_end_xfer;
  wire             pio_button_s1_firsttransfer;
  wire             pio_button_s1_grant_vector;
  wire             pio_button_s1_in_a_read_cycle;
  wire             pio_button_s1_in_a_write_cycle;
  wire             pio_button_s1_irq_from_sa;
  wire             pio_button_s1_master_qreq_vector;
  wire             pio_button_s1_non_bursting_master_requests;
  wire    [  3: 0] pio_button_s1_readdata_from_sa;
  reg              pio_button_s1_reg_firsttransfer;
  wire             pio_button_s1_reset_n;
  reg              pio_button_s1_slavearbiterlockenable;
  wire             pio_button_s1_slavearbiterlockenable2;
  wire             pio_button_s1_unreg_firsttransfer;
  wire             pio_button_s1_waits_for_read;
  wire             pio_button_s1_waits_for_write;
  wire             pio_button_s1_write_n;
  wire    [  3: 0] pio_button_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_button_s1_from_cpu_data_master;
  wire             wait_for_pio_button_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_button_s1_end_xfer;
    end


  assign pio_button_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_button_s1));
  //assign pio_button_s1_readdata_from_sa = pio_button_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_button_s1_readdata_from_sa = pio_button_s1_readdata;

  assign cpu_data_master_requests_pio_button_s1 = ({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9605150) & (cpu_data_master_read | cpu_data_master_write);
  //pio_button_s1_arb_share_counter set values, which is an e_mux
  assign pio_button_s1_arb_share_set_values = 1;

  //pio_button_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_button_s1_non_bursting_master_requests = cpu_data_master_requests_pio_button_s1;

  //pio_button_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_button_s1_any_bursting_master_saved_grant = 0;

  //pio_button_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_button_s1_arb_share_counter_next_value = pio_button_s1_firsttransfer ? (pio_button_s1_arb_share_set_values - 1) : |pio_button_s1_arb_share_counter ? (pio_button_s1_arb_share_counter - 1) : 0;

  //pio_button_s1_allgrants all slave grants, which is an e_mux
  assign pio_button_s1_allgrants = |pio_button_s1_grant_vector;

  //pio_button_s1_end_xfer assignment, which is an e_assign
  assign pio_button_s1_end_xfer = ~(pio_button_s1_waits_for_read | pio_button_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_button_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_button_s1 = pio_button_s1_end_xfer & (~pio_button_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_button_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_button_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_button_s1 & pio_button_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_button_s1 & ~pio_button_s1_non_bursting_master_requests);

  //pio_button_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_arb_share_counter <= 0;
      else if (pio_button_s1_arb_counter_enable)
          pio_button_s1_arb_share_counter <= pio_button_s1_arb_share_counter_next_value;
    end


  //pio_button_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_slavearbiterlockenable <= 0;
      else if ((|pio_button_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_button_s1) | (end_xfer_arb_share_counter_term_pio_button_s1 & ~pio_button_s1_non_bursting_master_requests))
          pio_button_s1_slavearbiterlockenable <= |pio_button_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_button/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_button_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_button_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_button_s1_slavearbiterlockenable2 = |pio_button_s1_arb_share_counter_next_value;

  //cpu/data_master pio_button/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_button_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_button_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_button_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_button_s1 = cpu_data_master_requests_pio_button_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_pio_button_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_button_s1 = cpu_data_master_granted_pio_button_s1 & cpu_data_master_read & ~pio_button_s1_waits_for_read;

  //pio_button_s1_writedata mux, which is an e_mux
  assign pio_button_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_button_s1 = cpu_data_master_qualified_request_pio_button_s1;

  //cpu/data_master saved-grant pio_button/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_button_s1 = cpu_data_master_requests_pio_button_s1;

  //allow new arb cycle for pio_button/s1, which is an e_assign
  assign pio_button_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_button_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_button_s1_master_qreq_vector = 1;

  //pio_button_s1_reset_n assignment, which is an e_assign
  assign pio_button_s1_reset_n = reset_n;

  assign pio_button_s1_chipselect = cpu_data_master_granted_pio_button_s1;
  //pio_button_s1_firsttransfer first transaction, which is an e_assign
  assign pio_button_s1_firsttransfer = pio_button_s1_begins_xfer ? pio_button_s1_unreg_firsttransfer : pio_button_s1_reg_firsttransfer;

  //pio_button_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_button_s1_unreg_firsttransfer = ~(pio_button_s1_slavearbiterlockenable & pio_button_s1_any_continuerequest);

  //pio_button_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_button_s1_reg_firsttransfer <= 1'b1;
      else if (pio_button_s1_begins_xfer)
          pio_button_s1_reg_firsttransfer <= pio_button_s1_unreg_firsttransfer;
    end


  //pio_button_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_button_s1_beginbursttransfer_internal = pio_button_s1_begins_xfer;

  //~pio_button_s1_write_n assignment, which is an e_mux
  assign pio_button_s1_write_n = ~(cpu_data_master_granted_pio_button_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_button_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_button_s1_address mux, which is an e_mux
  assign pio_button_s1_address = shifted_address_to_pio_button_s1_from_cpu_data_master >> 2;

  //d1_pio_button_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_button_s1_end_xfer <= 1;
      else if (1)
          d1_pio_button_s1_end_xfer <= pio_button_s1_end_xfer;
    end


  //pio_button_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_button_s1_waits_for_read = pio_button_s1_in_a_read_cycle & pio_button_s1_begins_xfer;

  //pio_button_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_button_s1_in_a_read_cycle = cpu_data_master_granted_pio_button_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_button_s1_in_a_read_cycle;

  //pio_button_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_button_s1_waits_for_write = pio_button_s1_in_a_write_cycle & 0;

  //pio_button_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_button_s1_in_a_write_cycle = cpu_data_master_granted_pio_button_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_button_s1_in_a_write_cycle;

  assign wait_for_pio_button_s1_counter = 0;
  //assign pio_button_s1_irq_from_sa = pio_button_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_button_s1_irq_from_sa = pio_button_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_button/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_green_led_s1_arbitrator (
                                     // inputs:
                                      clk,
                                      cpu_data_master_address_to_slave,
                                      cpu_data_master_latency_counter,
                                      cpu_data_master_read,
                                      cpu_data_master_write,
                                      cpu_data_master_writedata,
                                      reset_n,

                                     // outputs:
                                      cpu_data_master_granted_pio_green_led_s1,
                                      cpu_data_master_qualified_request_pio_green_led_s1,
                                      cpu_data_master_read_data_valid_pio_green_led_s1,
                                      cpu_data_master_requests_pio_green_led_s1,
                                      d1_pio_green_led_s1_end_xfer,
                                      pio_green_led_s1_address,
                                      pio_green_led_s1_chipselect,
                                      pio_green_led_s1_reset_n,
                                      pio_green_led_s1_write_n,
                                      pio_green_led_s1_writedata
                                   )
;

  output           cpu_data_master_granted_pio_green_led_s1;
  output           cpu_data_master_qualified_request_pio_green_led_s1;
  output           cpu_data_master_read_data_valid_pio_green_led_s1;
  output           cpu_data_master_requests_pio_green_led_s1;
  output           d1_pio_green_led_s1_end_xfer;
  output  [  1: 0] pio_green_led_s1_address;
  output           pio_green_led_s1_chipselect;
  output           pio_green_led_s1_reset_n;
  output           pio_green_led_s1_write_n;
  output  [  8: 0] pio_green_led_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_green_led_s1;
  wire             cpu_data_master_qualified_request_pio_green_led_s1;
  wire             cpu_data_master_read_data_valid_pio_green_led_s1;
  wire             cpu_data_master_requests_pio_green_led_s1;
  wire             cpu_data_master_saved_grant_pio_green_led_s1;
  reg              d1_pio_green_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_green_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_green_led_s1_address;
  wire             pio_green_led_s1_allgrants;
  wire             pio_green_led_s1_allow_new_arb_cycle;
  wire             pio_green_led_s1_any_bursting_master_saved_grant;
  wire             pio_green_led_s1_any_continuerequest;
  wire             pio_green_led_s1_arb_counter_enable;
  reg     [  1: 0] pio_green_led_s1_arb_share_counter;
  wire    [  1: 0] pio_green_led_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_green_led_s1_arb_share_set_values;
  wire             pio_green_led_s1_beginbursttransfer_internal;
  wire             pio_green_led_s1_begins_xfer;
  wire             pio_green_led_s1_chipselect;
  wire             pio_green_led_s1_end_xfer;
  wire             pio_green_led_s1_firsttransfer;
  wire             pio_green_led_s1_grant_vector;
  wire             pio_green_led_s1_in_a_read_cycle;
  wire             pio_green_led_s1_in_a_write_cycle;
  wire             pio_green_led_s1_master_qreq_vector;
  wire             pio_green_led_s1_non_bursting_master_requests;
  reg              pio_green_led_s1_reg_firsttransfer;
  wire             pio_green_led_s1_reset_n;
  reg              pio_green_led_s1_slavearbiterlockenable;
  wire             pio_green_led_s1_slavearbiterlockenable2;
  wire             pio_green_led_s1_unreg_firsttransfer;
  wire             pio_green_led_s1_waits_for_read;
  wire             pio_green_led_s1_waits_for_write;
  wire             pio_green_led_s1_write_n;
  wire    [  8: 0] pio_green_led_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_green_led_s1_from_cpu_data_master;
  wire             wait_for_pio_green_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_green_led_s1_end_xfer;
    end


  assign pio_green_led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_green_led_s1));
  assign cpu_data_master_requests_pio_green_led_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9605120) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //pio_green_led_s1_arb_share_counter set values, which is an e_mux
  assign pio_green_led_s1_arb_share_set_values = 1;

  //pio_green_led_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_green_led_s1_non_bursting_master_requests = cpu_data_master_requests_pio_green_led_s1;

  //pio_green_led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_green_led_s1_any_bursting_master_saved_grant = 0;

  //pio_green_led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_green_led_s1_arb_share_counter_next_value = pio_green_led_s1_firsttransfer ? (pio_green_led_s1_arb_share_set_values - 1) : |pio_green_led_s1_arb_share_counter ? (pio_green_led_s1_arb_share_counter - 1) : 0;

  //pio_green_led_s1_allgrants all slave grants, which is an e_mux
  assign pio_green_led_s1_allgrants = |pio_green_led_s1_grant_vector;

  //pio_green_led_s1_end_xfer assignment, which is an e_assign
  assign pio_green_led_s1_end_xfer = ~(pio_green_led_s1_waits_for_read | pio_green_led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_green_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_green_led_s1 = pio_green_led_s1_end_xfer & (~pio_green_led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_green_led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_green_led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_green_led_s1 & pio_green_led_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_green_led_s1 & ~pio_green_led_s1_non_bursting_master_requests);

  //pio_green_led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_arb_share_counter <= 0;
      else if (pio_green_led_s1_arb_counter_enable)
          pio_green_led_s1_arb_share_counter <= pio_green_led_s1_arb_share_counter_next_value;
    end


  //pio_green_led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_slavearbiterlockenable <= 0;
      else if ((|pio_green_led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_green_led_s1) | (end_xfer_arb_share_counter_term_pio_green_led_s1 & ~pio_green_led_s1_non_bursting_master_requests))
          pio_green_led_s1_slavearbiterlockenable <= |pio_green_led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_green_led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_green_led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_green_led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_green_led_s1_slavearbiterlockenable2 = |pio_green_led_s1_arb_share_counter_next_value;

  //cpu/data_master pio_green_led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_green_led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_green_led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_green_led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_green_led_s1 = cpu_data_master_requests_pio_green_led_s1;
  //local readdatavalid cpu_data_master_read_data_valid_pio_green_led_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_green_led_s1 = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_read & ~pio_green_led_s1_waits_for_read;

  //pio_green_led_s1_writedata mux, which is an e_mux
  assign pio_green_led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_green_led_s1 = cpu_data_master_qualified_request_pio_green_led_s1;

  //cpu/data_master saved-grant pio_green_led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_green_led_s1 = cpu_data_master_requests_pio_green_led_s1;

  //allow new arb cycle for pio_green_led/s1, which is an e_assign
  assign pio_green_led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_green_led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_green_led_s1_master_qreq_vector = 1;

  //pio_green_led_s1_reset_n assignment, which is an e_assign
  assign pio_green_led_s1_reset_n = reset_n;

  assign pio_green_led_s1_chipselect = cpu_data_master_granted_pio_green_led_s1;
  //pio_green_led_s1_firsttransfer first transaction, which is an e_assign
  assign pio_green_led_s1_firsttransfer = pio_green_led_s1_begins_xfer ? pio_green_led_s1_unreg_firsttransfer : pio_green_led_s1_reg_firsttransfer;

  //pio_green_led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_green_led_s1_unreg_firsttransfer = ~(pio_green_led_s1_slavearbiterlockenable & pio_green_led_s1_any_continuerequest);

  //pio_green_led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_green_led_s1_reg_firsttransfer <= 1'b1;
      else if (pio_green_led_s1_begins_xfer)
          pio_green_led_s1_reg_firsttransfer <= pio_green_led_s1_unreg_firsttransfer;
    end


  //pio_green_led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_green_led_s1_beginbursttransfer_internal = pio_green_led_s1_begins_xfer;

  //~pio_green_led_s1_write_n assignment, which is an e_mux
  assign pio_green_led_s1_write_n = ~(cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_green_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_green_led_s1_address mux, which is an e_mux
  assign pio_green_led_s1_address = shifted_address_to_pio_green_led_s1_from_cpu_data_master >> 2;

  //d1_pio_green_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_green_led_s1_end_xfer <= 1;
      else if (1)
          d1_pio_green_led_s1_end_xfer <= pio_green_led_s1_end_xfer;
    end


  //pio_green_led_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_green_led_s1_waits_for_read = pio_green_led_s1_in_a_read_cycle & pio_green_led_s1_begins_xfer;

  //pio_green_led_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_green_led_s1_in_a_read_cycle = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_green_led_s1_in_a_read_cycle;

  //pio_green_led_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_green_led_s1_waits_for_write = pio_green_led_s1_in_a_write_cycle & 0;

  //pio_green_led_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_green_led_s1_in_a_write_cycle = cpu_data_master_granted_pio_green_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_green_led_s1_in_a_write_cycle;

  assign wait_for_pio_green_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_green_led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_red_led_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_data_master_address_to_slave,
                                    cpu_data_master_latency_counter,
                                    cpu_data_master_read,
                                    cpu_data_master_write,
                                    cpu_data_master_writedata,
                                    reset_n,

                                   // outputs:
                                    cpu_data_master_granted_pio_red_led_s1,
                                    cpu_data_master_qualified_request_pio_red_led_s1,
                                    cpu_data_master_read_data_valid_pio_red_led_s1,
                                    cpu_data_master_requests_pio_red_led_s1,
                                    d1_pio_red_led_s1_end_xfer,
                                    pio_red_led_s1_address,
                                    pio_red_led_s1_chipselect,
                                    pio_red_led_s1_reset_n,
                                    pio_red_led_s1_write_n,
                                    pio_red_led_s1_writedata
                                 )
;

  output           cpu_data_master_granted_pio_red_led_s1;
  output           cpu_data_master_qualified_request_pio_red_led_s1;
  output           cpu_data_master_read_data_valid_pio_red_led_s1;
  output           cpu_data_master_requests_pio_red_led_s1;
  output           d1_pio_red_led_s1_end_xfer;
  output  [  1: 0] pio_red_led_s1_address;
  output           pio_red_led_s1_chipselect;
  output           pio_red_led_s1_reset_n;
  output           pio_red_led_s1_write_n;
  output  [ 17: 0] pio_red_led_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_red_led_s1;
  wire             cpu_data_master_qualified_request_pio_red_led_s1;
  wire             cpu_data_master_read_data_valid_pio_red_led_s1;
  wire             cpu_data_master_requests_pio_red_led_s1;
  wire             cpu_data_master_saved_grant_pio_red_led_s1;
  reg              d1_pio_red_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_red_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_red_led_s1_address;
  wire             pio_red_led_s1_allgrants;
  wire             pio_red_led_s1_allow_new_arb_cycle;
  wire             pio_red_led_s1_any_bursting_master_saved_grant;
  wire             pio_red_led_s1_any_continuerequest;
  wire             pio_red_led_s1_arb_counter_enable;
  reg     [  1: 0] pio_red_led_s1_arb_share_counter;
  wire    [  1: 0] pio_red_led_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_red_led_s1_arb_share_set_values;
  wire             pio_red_led_s1_beginbursttransfer_internal;
  wire             pio_red_led_s1_begins_xfer;
  wire             pio_red_led_s1_chipselect;
  wire             pio_red_led_s1_end_xfer;
  wire             pio_red_led_s1_firsttransfer;
  wire             pio_red_led_s1_grant_vector;
  wire             pio_red_led_s1_in_a_read_cycle;
  wire             pio_red_led_s1_in_a_write_cycle;
  wire             pio_red_led_s1_master_qreq_vector;
  wire             pio_red_led_s1_non_bursting_master_requests;
  reg              pio_red_led_s1_reg_firsttransfer;
  wire             pio_red_led_s1_reset_n;
  reg              pio_red_led_s1_slavearbiterlockenable;
  wire             pio_red_led_s1_slavearbiterlockenable2;
  wire             pio_red_led_s1_unreg_firsttransfer;
  wire             pio_red_led_s1_waits_for_read;
  wire             pio_red_led_s1_waits_for_write;
  wire             pio_red_led_s1_write_n;
  wire    [ 17: 0] pio_red_led_s1_writedata;
  wire    [ 27: 0] shifted_address_to_pio_red_led_s1_from_cpu_data_master;
  wire             wait_for_pio_red_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_red_led_s1_end_xfer;
    end


  assign pio_red_led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_red_led_s1));
  assign cpu_data_master_requests_pio_red_led_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9605130) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_write;
  //pio_red_led_s1_arb_share_counter set values, which is an e_mux
  assign pio_red_led_s1_arb_share_set_values = 1;

  //pio_red_led_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_red_led_s1_non_bursting_master_requests = cpu_data_master_requests_pio_red_led_s1;

  //pio_red_led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_red_led_s1_any_bursting_master_saved_grant = 0;

  //pio_red_led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_red_led_s1_arb_share_counter_next_value = pio_red_led_s1_firsttransfer ? (pio_red_led_s1_arb_share_set_values - 1) : |pio_red_led_s1_arb_share_counter ? (pio_red_led_s1_arb_share_counter - 1) : 0;

  //pio_red_led_s1_allgrants all slave grants, which is an e_mux
  assign pio_red_led_s1_allgrants = |pio_red_led_s1_grant_vector;

  //pio_red_led_s1_end_xfer assignment, which is an e_assign
  assign pio_red_led_s1_end_xfer = ~(pio_red_led_s1_waits_for_read | pio_red_led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_red_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_red_led_s1 = pio_red_led_s1_end_xfer & (~pio_red_led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_red_led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_red_led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_red_led_s1 & pio_red_led_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_red_led_s1 & ~pio_red_led_s1_non_bursting_master_requests);

  //pio_red_led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_arb_share_counter <= 0;
      else if (pio_red_led_s1_arb_counter_enable)
          pio_red_led_s1_arb_share_counter <= pio_red_led_s1_arb_share_counter_next_value;
    end


  //pio_red_led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_slavearbiterlockenable <= 0;
      else if ((|pio_red_led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_red_led_s1) | (end_xfer_arb_share_counter_term_pio_red_led_s1 & ~pio_red_led_s1_non_bursting_master_requests))
          pio_red_led_s1_slavearbiterlockenable <= |pio_red_led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_red_led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_red_led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_red_led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_red_led_s1_slavearbiterlockenable2 = |pio_red_led_s1_arb_share_counter_next_value;

  //cpu/data_master pio_red_led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_red_led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_red_led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_red_led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_red_led_s1 = cpu_data_master_requests_pio_red_led_s1;
  //local readdatavalid cpu_data_master_read_data_valid_pio_red_led_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_red_led_s1 = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_read & ~pio_red_led_s1_waits_for_read;

  //pio_red_led_s1_writedata mux, which is an e_mux
  assign pio_red_led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_red_led_s1 = cpu_data_master_qualified_request_pio_red_led_s1;

  //cpu/data_master saved-grant pio_red_led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_red_led_s1 = cpu_data_master_requests_pio_red_led_s1;

  //allow new arb cycle for pio_red_led/s1, which is an e_assign
  assign pio_red_led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_red_led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_red_led_s1_master_qreq_vector = 1;

  //pio_red_led_s1_reset_n assignment, which is an e_assign
  assign pio_red_led_s1_reset_n = reset_n;

  assign pio_red_led_s1_chipselect = cpu_data_master_granted_pio_red_led_s1;
  //pio_red_led_s1_firsttransfer first transaction, which is an e_assign
  assign pio_red_led_s1_firsttransfer = pio_red_led_s1_begins_xfer ? pio_red_led_s1_unreg_firsttransfer : pio_red_led_s1_reg_firsttransfer;

  //pio_red_led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_red_led_s1_unreg_firsttransfer = ~(pio_red_led_s1_slavearbiterlockenable & pio_red_led_s1_any_continuerequest);

  //pio_red_led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_red_led_s1_reg_firsttransfer <= 1'b1;
      else if (pio_red_led_s1_begins_xfer)
          pio_red_led_s1_reg_firsttransfer <= pio_red_led_s1_unreg_firsttransfer;
    end


  //pio_red_led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_red_led_s1_beginbursttransfer_internal = pio_red_led_s1_begins_xfer;

  //~pio_red_led_s1_write_n assignment, which is an e_mux
  assign pio_red_led_s1_write_n = ~(cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_red_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_red_led_s1_address mux, which is an e_mux
  assign pio_red_led_s1_address = shifted_address_to_pio_red_led_s1_from_cpu_data_master >> 2;

  //d1_pio_red_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_red_led_s1_end_xfer <= 1;
      else if (1)
          d1_pio_red_led_s1_end_xfer <= pio_red_led_s1_end_xfer;
    end


  //pio_red_led_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_red_led_s1_waits_for_read = pio_red_led_s1_in_a_read_cycle & pio_red_led_s1_begins_xfer;

  //pio_red_led_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_red_led_s1_in_a_read_cycle = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_red_led_s1_in_a_read_cycle;

  //pio_red_led_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_red_led_s1_waits_for_write = pio_red_led_s1_in_a_write_cycle & 0;

  //pio_red_led_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_red_led_s1_in_a_write_cycle = cpu_data_master_granted_pio_red_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_red_led_s1_in_a_write_cycle;

  assign wait_for_pio_red_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_red_led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_switch_s1_arbitrator (
                                  // inputs:
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_latency_counter,
                                   cpu_data_master_read,
                                   cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                   cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                   cpu_data_master_write,
                                   pio_switch_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   cpu_data_master_granted_pio_switch_s1,
                                   cpu_data_master_qualified_request_pio_switch_s1,
                                   cpu_data_master_read_data_valid_pio_switch_s1,
                                   cpu_data_master_requests_pio_switch_s1,
                                   d1_pio_switch_s1_end_xfer,
                                   pio_switch_s1_address,
                                   pio_switch_s1_readdata_from_sa,
                                   pio_switch_s1_reset_n
                                )
;

  output           cpu_data_master_granted_pio_switch_s1;
  output           cpu_data_master_qualified_request_pio_switch_s1;
  output           cpu_data_master_read_data_valid_pio_switch_s1;
  output           cpu_data_master_requests_pio_switch_s1;
  output           d1_pio_switch_s1_end_xfer;
  output  [  1: 0] pio_switch_s1_address;
  output  [ 17: 0] pio_switch_s1_readdata_from_sa;
  output           pio_switch_s1_reset_n;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 17: 0] pio_switch_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_switch_s1;
  wire             cpu_data_master_qualified_request_pio_switch_s1;
  wire             cpu_data_master_read_data_valid_pio_switch_s1;
  wire             cpu_data_master_requests_pio_switch_s1;
  wire             cpu_data_master_saved_grant_pio_switch_s1;
  reg              d1_pio_switch_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_switch_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_switch_s1_address;
  wire             pio_switch_s1_allgrants;
  wire             pio_switch_s1_allow_new_arb_cycle;
  wire             pio_switch_s1_any_bursting_master_saved_grant;
  wire             pio_switch_s1_any_continuerequest;
  wire             pio_switch_s1_arb_counter_enable;
  reg     [  1: 0] pio_switch_s1_arb_share_counter;
  wire    [  1: 0] pio_switch_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_switch_s1_arb_share_set_values;
  wire             pio_switch_s1_beginbursttransfer_internal;
  wire             pio_switch_s1_begins_xfer;
  wire             pio_switch_s1_end_xfer;
  wire             pio_switch_s1_firsttransfer;
  wire             pio_switch_s1_grant_vector;
  wire             pio_switch_s1_in_a_read_cycle;
  wire             pio_switch_s1_in_a_write_cycle;
  wire             pio_switch_s1_master_qreq_vector;
  wire             pio_switch_s1_non_bursting_master_requests;
  wire    [ 17: 0] pio_switch_s1_readdata_from_sa;
  reg              pio_switch_s1_reg_firsttransfer;
  wire             pio_switch_s1_reset_n;
  reg              pio_switch_s1_slavearbiterlockenable;
  wire             pio_switch_s1_slavearbiterlockenable2;
  wire             pio_switch_s1_unreg_firsttransfer;
  wire             pio_switch_s1_waits_for_read;
  wire             pio_switch_s1_waits_for_write;
  wire    [ 27: 0] shifted_address_to_pio_switch_s1_from_cpu_data_master;
  wire             wait_for_pio_switch_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pio_switch_s1_end_xfer;
    end


  assign pio_switch_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_switch_s1));
  //assign pio_switch_s1_readdata_from_sa = pio_switch_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_switch_s1_readdata_from_sa = pio_switch_s1_readdata;

  assign cpu_data_master_requests_pio_switch_s1 = (({cpu_data_master_address_to_slave[27 : 4] , 4'b0} == 28'h9605140) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //pio_switch_s1_arb_share_counter set values, which is an e_mux
  assign pio_switch_s1_arb_share_set_values = 1;

  //pio_switch_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_switch_s1_non_bursting_master_requests = cpu_data_master_requests_pio_switch_s1;

  //pio_switch_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_switch_s1_any_bursting_master_saved_grant = 0;

  //pio_switch_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_switch_s1_arb_share_counter_next_value = pio_switch_s1_firsttransfer ? (pio_switch_s1_arb_share_set_values - 1) : |pio_switch_s1_arb_share_counter ? (pio_switch_s1_arb_share_counter - 1) : 0;

  //pio_switch_s1_allgrants all slave grants, which is an e_mux
  assign pio_switch_s1_allgrants = |pio_switch_s1_grant_vector;

  //pio_switch_s1_end_xfer assignment, which is an e_assign
  assign pio_switch_s1_end_xfer = ~(pio_switch_s1_waits_for_read | pio_switch_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_switch_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_switch_s1 = pio_switch_s1_end_xfer & (~pio_switch_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_switch_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_switch_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_switch_s1 & pio_switch_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_switch_s1 & ~pio_switch_s1_non_bursting_master_requests);

  //pio_switch_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_arb_share_counter <= 0;
      else if (pio_switch_s1_arb_counter_enable)
          pio_switch_s1_arb_share_counter <= pio_switch_s1_arb_share_counter_next_value;
    end


  //pio_switch_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_slavearbiterlockenable <= 0;
      else if ((|pio_switch_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_switch_s1) | (end_xfer_arb_share_counter_term_pio_switch_s1 & ~pio_switch_s1_non_bursting_master_requests))
          pio_switch_s1_slavearbiterlockenable <= |pio_switch_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_switch/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_switch_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_switch_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_switch_s1_slavearbiterlockenable2 = |pio_switch_s1_arb_share_counter_next_value;

  //cpu/data_master pio_switch/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_switch_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_switch_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_switch_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_switch_s1 = cpu_data_master_requests_pio_switch_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_pio_switch_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_pio_switch_s1 = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_read & ~pio_switch_s1_waits_for_read;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_switch_s1 = cpu_data_master_qualified_request_pio_switch_s1;

  //cpu/data_master saved-grant pio_switch/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_switch_s1 = cpu_data_master_requests_pio_switch_s1;

  //allow new arb cycle for pio_switch/s1, which is an e_assign
  assign pio_switch_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_switch_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_switch_s1_master_qreq_vector = 1;

  //pio_switch_s1_reset_n assignment, which is an e_assign
  assign pio_switch_s1_reset_n = reset_n;

  //pio_switch_s1_firsttransfer first transaction, which is an e_assign
  assign pio_switch_s1_firsttransfer = pio_switch_s1_begins_xfer ? pio_switch_s1_unreg_firsttransfer : pio_switch_s1_reg_firsttransfer;

  //pio_switch_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_switch_s1_unreg_firsttransfer = ~(pio_switch_s1_slavearbiterlockenable & pio_switch_s1_any_continuerequest);

  //pio_switch_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_switch_s1_reg_firsttransfer <= 1'b1;
      else if (pio_switch_s1_begins_xfer)
          pio_switch_s1_reg_firsttransfer <= pio_switch_s1_unreg_firsttransfer;
    end


  //pio_switch_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_switch_s1_beginbursttransfer_internal = pio_switch_s1_begins_xfer;

  assign shifted_address_to_pio_switch_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_switch_s1_address mux, which is an e_mux
  assign pio_switch_s1_address = shifted_address_to_pio_switch_s1_from_cpu_data_master >> 2;

  //d1_pio_switch_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_switch_s1_end_xfer <= 1;
      else if (1)
          d1_pio_switch_s1_end_xfer <= pio_switch_s1_end_xfer;
    end


  //pio_switch_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_switch_s1_waits_for_read = pio_switch_s1_in_a_read_cycle & pio_switch_s1_begins_xfer;

  //pio_switch_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_switch_s1_in_a_read_cycle = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_switch_s1_in_a_read_cycle;

  //pio_switch_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_switch_s1_waits_for_write = pio_switch_s1_in_a_write_cycle & 0;

  //pio_switch_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_switch_s1_in_a_write_cycle = cpu_data_master_granted_pio_switch_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_switch_s1_in_a_write_cycle;

  assign wait_for_pio_switch_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_switch/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pll_s1_arbitrator (
                           // inputs:
                            clk,
                            nios_ii_clock_0_out_address_to_slave,
                            nios_ii_clock_0_out_nativeaddress,
                            nios_ii_clock_0_out_read,
                            nios_ii_clock_0_out_write,
                            nios_ii_clock_0_out_writedata,
                            pll_s1_readdata,
                            pll_s1_resetrequest,
                            reset_n,

                           // outputs:
                            d1_pll_s1_end_xfer,
                            nios_ii_clock_0_out_granted_pll_s1,
                            nios_ii_clock_0_out_qualified_request_pll_s1,
                            nios_ii_clock_0_out_read_data_valid_pll_s1,
                            nios_ii_clock_0_out_requests_pll_s1,
                            pll_s1_address,
                            pll_s1_chipselect,
                            pll_s1_read,
                            pll_s1_readdata_from_sa,
                            pll_s1_reset_n,
                            pll_s1_resetrequest_from_sa,
                            pll_s1_write,
                            pll_s1_writedata
                         )
;

  output           d1_pll_s1_end_xfer;
  output           nios_ii_clock_0_out_granted_pll_s1;
  output           nios_ii_clock_0_out_qualified_request_pll_s1;
  output           nios_ii_clock_0_out_read_data_valid_pll_s1;
  output           nios_ii_clock_0_out_requests_pll_s1;
  output  [  2: 0] pll_s1_address;
  output           pll_s1_chipselect;
  output           pll_s1_read;
  output  [ 15: 0] pll_s1_readdata_from_sa;
  output           pll_s1_reset_n;
  output           pll_s1_resetrequest_from_sa;
  output           pll_s1_write;
  output  [ 15: 0] pll_s1_writedata;
  input            clk;
  input   [  3: 0] nios_ii_clock_0_out_address_to_slave;
  input   [  2: 0] nios_ii_clock_0_out_nativeaddress;
  input            nios_ii_clock_0_out_read;
  input            nios_ii_clock_0_out_write;
  input   [ 15: 0] nios_ii_clock_0_out_writedata;
  input   [ 15: 0] pll_s1_readdata;
  input            pll_s1_resetrequest;
  input            reset_n;

  reg              d1_pll_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pll_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             nios_ii_clock_0_out_arbiterlock;
  wire             nios_ii_clock_0_out_arbiterlock2;
  wire             nios_ii_clock_0_out_continuerequest;
  wire             nios_ii_clock_0_out_granted_pll_s1;
  wire             nios_ii_clock_0_out_qualified_request_pll_s1;
  wire             nios_ii_clock_0_out_read_data_valid_pll_s1;
  wire             nios_ii_clock_0_out_requests_pll_s1;
  wire             nios_ii_clock_0_out_saved_grant_pll_s1;
  wire    [  2: 0] pll_s1_address;
  wire             pll_s1_allgrants;
  wire             pll_s1_allow_new_arb_cycle;
  wire             pll_s1_any_bursting_master_saved_grant;
  wire             pll_s1_any_continuerequest;
  wire             pll_s1_arb_counter_enable;
  reg              pll_s1_arb_share_counter;
  wire             pll_s1_arb_share_counter_next_value;
  wire             pll_s1_arb_share_set_values;
  wire             pll_s1_beginbursttransfer_internal;
  wire             pll_s1_begins_xfer;
  wire             pll_s1_chipselect;
  wire             pll_s1_end_xfer;
  wire             pll_s1_firsttransfer;
  wire             pll_s1_grant_vector;
  wire             pll_s1_in_a_read_cycle;
  wire             pll_s1_in_a_write_cycle;
  wire             pll_s1_master_qreq_vector;
  wire             pll_s1_non_bursting_master_requests;
  wire             pll_s1_read;
  wire    [ 15: 0] pll_s1_readdata_from_sa;
  reg              pll_s1_reg_firsttransfer;
  wire             pll_s1_reset_n;
  wire             pll_s1_resetrequest_from_sa;
  reg              pll_s1_slavearbiterlockenable;
  wire             pll_s1_slavearbiterlockenable2;
  wire             pll_s1_unreg_firsttransfer;
  wire             pll_s1_waits_for_read;
  wire             pll_s1_waits_for_write;
  wire             pll_s1_write;
  wire    [ 15: 0] pll_s1_writedata;
  wire             wait_for_pll_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~pll_s1_end_xfer;
    end


  assign pll_s1_begins_xfer = ~d1_reasons_to_wait & ((nios_ii_clock_0_out_qualified_request_pll_s1));
  //assign pll_s1_readdata_from_sa = pll_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_s1_readdata_from_sa = pll_s1_readdata;

  assign nios_ii_clock_0_out_requests_pll_s1 = (1) & (nios_ii_clock_0_out_read | nios_ii_clock_0_out_write);
  //pll_s1_arb_share_counter set values, which is an e_mux
  assign pll_s1_arb_share_set_values = 1;

  //pll_s1_non_bursting_master_requests mux, which is an e_mux
  assign pll_s1_non_bursting_master_requests = nios_ii_clock_0_out_requests_pll_s1;

  //pll_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pll_s1_any_bursting_master_saved_grant = 0;

  //pll_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pll_s1_arb_share_counter_next_value = pll_s1_firsttransfer ? (pll_s1_arb_share_set_values - 1) : |pll_s1_arb_share_counter ? (pll_s1_arb_share_counter - 1) : 0;

  //pll_s1_allgrants all slave grants, which is an e_mux
  assign pll_s1_allgrants = |pll_s1_grant_vector;

  //pll_s1_end_xfer assignment, which is an e_assign
  assign pll_s1_end_xfer = ~(pll_s1_waits_for_read | pll_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pll_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pll_s1 = pll_s1_end_xfer & (~pll_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pll_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pll_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pll_s1 & pll_s1_allgrants) | (end_xfer_arb_share_counter_term_pll_s1 & ~pll_s1_non_bursting_master_requests);

  //pll_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_arb_share_counter <= 0;
      else if (pll_s1_arb_counter_enable)
          pll_s1_arb_share_counter <= pll_s1_arb_share_counter_next_value;
    end


  //pll_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_slavearbiterlockenable <= 0;
      else if ((|pll_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pll_s1) | (end_xfer_arb_share_counter_term_pll_s1 & ~pll_s1_non_bursting_master_requests))
          pll_s1_slavearbiterlockenable <= |pll_s1_arb_share_counter_next_value;
    end


  //nios_ii_clock_0/out pll/s1 arbiterlock, which is an e_assign
  assign nios_ii_clock_0_out_arbiterlock = pll_s1_slavearbiterlockenable & nios_ii_clock_0_out_continuerequest;

  //pll_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pll_s1_slavearbiterlockenable2 = |pll_s1_arb_share_counter_next_value;

  //nios_ii_clock_0/out pll/s1 arbiterlock2, which is an e_assign
  assign nios_ii_clock_0_out_arbiterlock2 = pll_s1_slavearbiterlockenable2 & nios_ii_clock_0_out_continuerequest;

  //pll_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pll_s1_any_continuerequest = 1;

  //nios_ii_clock_0_out_continuerequest continued request, which is an e_assign
  assign nios_ii_clock_0_out_continuerequest = 1;

  assign nios_ii_clock_0_out_qualified_request_pll_s1 = nios_ii_clock_0_out_requests_pll_s1;
  //pll_s1_writedata mux, which is an e_mux
  assign pll_s1_writedata = nios_ii_clock_0_out_writedata;

  //master is always granted when requested
  assign nios_ii_clock_0_out_granted_pll_s1 = nios_ii_clock_0_out_qualified_request_pll_s1;

  //nios_ii_clock_0/out saved-grant pll/s1, which is an e_assign
  assign nios_ii_clock_0_out_saved_grant_pll_s1 = nios_ii_clock_0_out_requests_pll_s1;

  //allow new arb cycle for pll/s1, which is an e_assign
  assign pll_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pll_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pll_s1_master_qreq_vector = 1;

  //pll_s1_reset_n assignment, which is an e_assign
  assign pll_s1_reset_n = reset_n;

  //assign pll_s1_resetrequest_from_sa = pll_s1_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pll_s1_resetrequest_from_sa = pll_s1_resetrequest;

  assign pll_s1_chipselect = nios_ii_clock_0_out_granted_pll_s1;
  //pll_s1_firsttransfer first transaction, which is an e_assign
  assign pll_s1_firsttransfer = pll_s1_begins_xfer ? pll_s1_unreg_firsttransfer : pll_s1_reg_firsttransfer;

  //pll_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pll_s1_unreg_firsttransfer = ~(pll_s1_slavearbiterlockenable & pll_s1_any_continuerequest);

  //pll_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pll_s1_reg_firsttransfer <= 1'b1;
      else if (pll_s1_begins_xfer)
          pll_s1_reg_firsttransfer <= pll_s1_unreg_firsttransfer;
    end


  //pll_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pll_s1_beginbursttransfer_internal = pll_s1_begins_xfer;

  //pll_s1_read assignment, which is an e_mux
  assign pll_s1_read = nios_ii_clock_0_out_granted_pll_s1 & nios_ii_clock_0_out_read;

  //pll_s1_write assignment, which is an e_mux
  assign pll_s1_write = nios_ii_clock_0_out_granted_pll_s1 & nios_ii_clock_0_out_write;

  //pll_s1_address mux, which is an e_mux
  assign pll_s1_address = nios_ii_clock_0_out_nativeaddress;

  //d1_pll_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pll_s1_end_xfer <= 1;
      else if (1)
          d1_pll_s1_end_xfer <= pll_s1_end_xfer;
    end


  //pll_s1_waits_for_read in a cycle, which is an e_mux
  assign pll_s1_waits_for_read = pll_s1_in_a_read_cycle & pll_s1_begins_xfer;

  //pll_s1_in_a_read_cycle assignment, which is an e_assign
  assign pll_s1_in_a_read_cycle = nios_ii_clock_0_out_granted_pll_s1 & nios_ii_clock_0_out_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pll_s1_in_a_read_cycle;

  //pll_s1_waits_for_write in a cycle, which is an e_mux
  assign pll_s1_waits_for_write = pll_s1_in_a_write_cycle & 0;

  //pll_s1_in_a_write_cycle assignment, which is an e_assign
  assign pll_s1_in_a_write_cycle = nios_ii_clock_0_out_granted_pll_s1 & nios_ii_clock_0_out_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pll_s1_in_a_write_cycle;

  assign wait_for_pll_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pll/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_u1_s1_module (
                                                            // inputs:
                                                             clear_fifo,
                                                             clk,
                                                             data_in,
                                                             read,
                                                             reset_n,
                                                             sync_reset,
                                                             write,

                                                            // outputs:
                                                             data_out,
                                                             empty,
                                                             fifo_contains_ones_n,
                                                             full
                                                          )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_u1_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_byteenable,
                                 cpu_data_master_dbs_address,
                                 cpu_data_master_dbs_write_16,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_data_master_write,
                                 cpu_instruction_master_address_to_slave,
                                 cpu_instruction_master_dbs_address,
                                 cpu_instruction_master_latency_counter,
                                 cpu_instruction_master_read,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                 reset_n,
                                 sdram_u1_s1_readdata,
                                 sdram_u1_s1_readdatavalid,
                                 sdram_u1_s1_waitrequest,

                                // outputs:
                                 cpu_data_master_byteenable_sdram_u1_s1,
                                 cpu_data_master_granted_sdram_u1_s1,
                                 cpu_data_master_qualified_request_sdram_u1_s1,
                                 cpu_data_master_read_data_valid_sdram_u1_s1,
                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_data_master_requests_sdram_u1_s1,
                                 cpu_instruction_master_granted_sdram_u1_s1,
                                 cpu_instruction_master_qualified_request_sdram_u1_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_instruction_master_requests_sdram_u1_s1,
                                 d1_sdram_u1_s1_end_xfer,
                                 sdram_u1_s1_address,
                                 sdram_u1_s1_byteenable_n,
                                 sdram_u1_s1_chipselect,
                                 sdram_u1_s1_read_n,
                                 sdram_u1_s1_readdata_from_sa,
                                 sdram_u1_s1_reset_n,
                                 sdram_u1_s1_waitrequest_from_sa,
                                 sdram_u1_s1_write_n,
                                 sdram_u1_s1_writedata
                              )
;

  output  [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  output           cpu_data_master_granted_sdram_u1_s1;
  output           cpu_data_master_qualified_request_sdram_u1_s1;
  output           cpu_data_master_read_data_valid_sdram_u1_s1;
  output           cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  output           cpu_data_master_requests_sdram_u1_s1;
  output           cpu_instruction_master_granted_sdram_u1_s1;
  output           cpu_instruction_master_qualified_request_sdram_u1_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u1_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_u1_s1;
  output           d1_sdram_u1_s1_end_xfer;
  output  [ 23: 0] sdram_u1_s1_address;
  output  [  1: 0] sdram_u1_s1_byteenable_n;
  output           sdram_u1_s1_chipselect;
  output           sdram_u1_s1_read_n;
  output  [ 15: 0] sdram_u1_s1_readdata_from_sa;
  output           sdram_u1_s1_reset_n;
  output           sdram_u1_s1_waitrequest_from_sa;
  output           sdram_u1_s1_write_n;
  output  [ 15: 0] sdram_u1_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  input            reset_n;
  input   [ 15: 0] sdram_u1_s1_readdata;
  input            sdram_u1_s1_readdatavalid;
  input            sdram_u1_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_u1_s1;
  wire             cpu_data_master_qualified_request_sdram_u1_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_u1_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_data_master_requests_sdram_u1_s1;
  wire             cpu_data_master_saved_grant_sdram_u1_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_u1_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u1_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_u1_s1;
  wire             cpu_instruction_master_saved_grant_sdram_u1_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_u1_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_u1_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_u1_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1;
  wire    [ 23: 0] sdram_u1_s1_address;
  wire             sdram_u1_s1_allgrants;
  wire             sdram_u1_s1_allow_new_arb_cycle;
  wire             sdram_u1_s1_any_bursting_master_saved_grant;
  wire             sdram_u1_s1_any_continuerequest;
  reg     [  1: 0] sdram_u1_s1_arb_addend;
  wire             sdram_u1_s1_arb_counter_enable;
  reg     [  1: 0] sdram_u1_s1_arb_share_counter;
  wire    [  1: 0] sdram_u1_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_u1_s1_arb_share_set_values;
  wire    [  1: 0] sdram_u1_s1_arb_winner;
  wire             sdram_u1_s1_arbitration_holdoff_internal;
  wire             sdram_u1_s1_beginbursttransfer_internal;
  wire             sdram_u1_s1_begins_xfer;
  wire    [  1: 0] sdram_u1_s1_byteenable_n;
  wire             sdram_u1_s1_chipselect;
  wire    [  3: 0] sdram_u1_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_u1_s1_chosen_master_rot_left;
  wire             sdram_u1_s1_end_xfer;
  wire             sdram_u1_s1_firsttransfer;
  wire    [  1: 0] sdram_u1_s1_grant_vector;
  wire             sdram_u1_s1_in_a_read_cycle;
  wire             sdram_u1_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_u1_s1_master_qreq_vector;
  wire             sdram_u1_s1_move_on_to_next_transaction;
  wire             sdram_u1_s1_non_bursting_master_requests;
  wire             sdram_u1_s1_read_n;
  wire    [ 15: 0] sdram_u1_s1_readdata_from_sa;
  wire             sdram_u1_s1_readdatavalid_from_sa;
  reg              sdram_u1_s1_reg_firsttransfer;
  wire             sdram_u1_s1_reset_n;
  reg     [  1: 0] sdram_u1_s1_saved_chosen_master_vector;
  reg              sdram_u1_s1_slavearbiterlockenable;
  wire             sdram_u1_s1_slavearbiterlockenable2;
  wire             sdram_u1_s1_unreg_firsttransfer;
  wire             sdram_u1_s1_waitrequest_from_sa;
  wire             sdram_u1_s1_waits_for_read;
  wire             sdram_u1_s1_waits_for_write;
  wire             sdram_u1_s1_write_n;
  wire    [ 15: 0] sdram_u1_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_u1_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_u1_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_u1_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sdram_u1_s1_end_xfer;
    end


  assign sdram_u1_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_u1_s1 | cpu_instruction_master_qualified_request_sdram_u1_s1));
  //assign sdram_u1_s1_readdatavalid_from_sa = sdram_u1_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_readdatavalid_from_sa = sdram_u1_s1_readdatavalid;

  //assign sdram_u1_s1_readdata_from_sa = sdram_u1_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_readdata_from_sa = sdram_u1_s1_readdata;

  assign cpu_data_master_requests_sdram_u1_s1 = ({cpu_data_master_address_to_slave[27 : 25] , 25'b0} == 28'h4000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_u1_s1_waitrequest_from_sa = sdram_u1_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u1_s1_waitrequest_from_sa = sdram_u1_s1_waitrequest;

  //sdram_u1_s1_arb_share_counter set values, which is an e_mux
  assign sdram_u1_s1_arb_share_set_values = (cpu_data_master_granted_sdram_u1_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u1_s1)? 2 :
    (cpu_data_master_granted_sdram_u1_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u1_s1)? 2 :
    1;

  //sdram_u1_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_u1_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_u1_s1 |
    cpu_instruction_master_requests_sdram_u1_s1 |
    cpu_data_master_requests_sdram_u1_s1 |
    cpu_instruction_master_requests_sdram_u1_s1;

  //sdram_u1_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_u1_s1_any_bursting_master_saved_grant = 0;

  //sdram_u1_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_u1_s1_arb_share_counter_next_value = sdram_u1_s1_firsttransfer ? (sdram_u1_s1_arb_share_set_values - 1) : |sdram_u1_s1_arb_share_counter ? (sdram_u1_s1_arb_share_counter - 1) : 0;

  //sdram_u1_s1_allgrants all slave grants, which is an e_mux
  assign sdram_u1_s1_allgrants = |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector |
    |sdram_u1_s1_grant_vector;

  //sdram_u1_s1_end_xfer assignment, which is an e_assign
  assign sdram_u1_s1_end_xfer = ~(sdram_u1_s1_waits_for_read | sdram_u1_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_u1_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_u1_s1 = sdram_u1_s1_end_xfer & (~sdram_u1_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_u1_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_u1_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_u1_s1 & sdram_u1_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_u1_s1 & ~sdram_u1_s1_non_bursting_master_requests);

  //sdram_u1_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_arb_share_counter <= 0;
      else if (sdram_u1_s1_arb_counter_enable)
          sdram_u1_s1_arb_share_counter <= sdram_u1_s1_arb_share_counter_next_value;
    end


  //sdram_u1_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_u1_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_u1_s1) | (end_xfer_arb_share_counter_term_sdram_u1_s1 & ~sdram_u1_s1_non_bursting_master_requests))
          sdram_u1_s1_slavearbiterlockenable <= |sdram_u1_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram_u1/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_u1_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_u1_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_u1_s1_slavearbiterlockenable2 = |sdram_u1_s1_arb_share_counter_next_value;

  //cpu/data_master sdram_u1/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_u1_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram_u1/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_u1_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram_u1/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_u1_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram_u1/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 <= cpu_instruction_master_saved_grant_sdram_u1_s1 ? 1 : (sdram_u1_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_u1_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_u1_s1 & cpu_instruction_master_requests_sdram_u1_s1;

  //sdram_u1_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_u1_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_u1_s1 = cpu_data_master_requests_sdram_u1_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))) | ((!cpu_data_master_byteenable_sdram_u1_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_u1_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_u1_s1_move_on_to_next_transaction = sdram_u1_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_u1_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_u1_s1_module rdv_fifo_for_cpu_data_master_to_sdram_u1_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_u1_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_u1_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_u1_s1),
      .full                 (),
      .read                 (sdram_u1_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u1_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_u1_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_u1_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_u1_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_u1_s1 = (sdram_u1_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_u1_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_u1_s1;

  //sdram_u1_s1_writedata mux, which is an e_mux
  assign sdram_u1_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_u1_s1 = (({cpu_instruction_master_address_to_slave[27 : 25] , 25'b0} == 28'h4000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram_u1/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 <= cpu_data_master_saved_grant_sdram_u1_s1 ? 1 : (sdram_u1_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_u1_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_u1_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_u1_s1 & cpu_data_master_requests_sdram_u1_s1;

  assign cpu_instruction_master_qualified_request_sdram_u1_s1 = cpu_instruction_master_requests_sdram_u1_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_u1_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_u1_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1),
      .full                 (),
      .read                 (sdram_u1_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u1_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_u1_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_u1_s1 = (sdram_u1_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_u1_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_u1_s1;

  //allow new arb cycle for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_u1_s1;

  //cpu/instruction_master grant sdram_u1/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_u1_s1 = sdram_u1_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram_u1/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_u1_s1 = sdram_u1_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_u1_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram_u1/s1, which is an e_assign
  assign sdram_u1_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_u1_s1;

  //cpu/data_master grant sdram_u1/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_u1_s1 = sdram_u1_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram_u1/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_u1_s1 = sdram_u1_s1_arb_winner[1] && cpu_data_master_requests_sdram_u1_s1;

  //sdram_u1/s1 chosen-master double-vector, which is an e_assign
  assign sdram_u1_s1_chosen_master_double_vector = {sdram_u1_s1_master_qreq_vector, sdram_u1_s1_master_qreq_vector} & ({~sdram_u1_s1_master_qreq_vector, ~sdram_u1_s1_master_qreq_vector} + sdram_u1_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_u1_s1_arb_winner = (sdram_u1_s1_allow_new_arb_cycle & | sdram_u1_s1_grant_vector) ? sdram_u1_s1_grant_vector : sdram_u1_s1_saved_chosen_master_vector;

  //saved sdram_u1_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_saved_chosen_master_vector <= 0;
      else if (sdram_u1_s1_allow_new_arb_cycle)
          sdram_u1_s1_saved_chosen_master_vector <= |sdram_u1_s1_grant_vector ? sdram_u1_s1_grant_vector : sdram_u1_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_u1_s1_grant_vector = {(sdram_u1_s1_chosen_master_double_vector[1] | sdram_u1_s1_chosen_master_double_vector[3]),
    (sdram_u1_s1_chosen_master_double_vector[0] | sdram_u1_s1_chosen_master_double_vector[2])};

  //sdram_u1/s1 chosen master rotated left, which is an e_assign
  assign sdram_u1_s1_chosen_master_rot_left = (sdram_u1_s1_arb_winner << 1) ? (sdram_u1_s1_arb_winner << 1) : 1;

  //sdram_u1/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_arb_addend <= 1;
      else if (|sdram_u1_s1_grant_vector)
          sdram_u1_s1_arb_addend <= sdram_u1_s1_end_xfer? sdram_u1_s1_chosen_master_rot_left : sdram_u1_s1_grant_vector;
    end


  //sdram_u1_s1_reset_n assignment, which is an e_assign
  assign sdram_u1_s1_reset_n = reset_n;

  assign sdram_u1_s1_chipselect = cpu_data_master_granted_sdram_u1_s1 | cpu_instruction_master_granted_sdram_u1_s1;
  //sdram_u1_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_u1_s1_firsttransfer = sdram_u1_s1_begins_xfer ? sdram_u1_s1_unreg_firsttransfer : sdram_u1_s1_reg_firsttransfer;

  //sdram_u1_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_u1_s1_unreg_firsttransfer = ~(sdram_u1_s1_slavearbiterlockenable & sdram_u1_s1_any_continuerequest);

  //sdram_u1_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u1_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_u1_s1_begins_xfer)
          sdram_u1_s1_reg_firsttransfer <= sdram_u1_s1_unreg_firsttransfer;
    end


  //sdram_u1_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_u1_s1_beginbursttransfer_internal = sdram_u1_s1_begins_xfer;

  //sdram_u1_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_u1_s1_arbitration_holdoff_internal = sdram_u1_s1_begins_xfer & sdram_u1_s1_firsttransfer;

  //~sdram_u1_s1_read_n assignment, which is an e_mux
  assign sdram_u1_s1_read_n = ~((cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read));

  //~sdram_u1_s1_write_n assignment, which is an e_mux
  assign sdram_u1_s1_write_n = ~(cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_u1_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_u1_s1_address mux, which is an e_mux
  assign sdram_u1_s1_address = (cpu_data_master_granted_sdram_u1_s1)? (shifted_address_to_sdram_u1_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_u1_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_u1_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_u1_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_u1_s1_end_xfer <= 1;
      else if (1)
          d1_sdram_u1_s1_end_xfer <= sdram_u1_s1_end_xfer;
    end


  //sdram_u1_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_u1_s1_waits_for_read = sdram_u1_s1_in_a_read_cycle & sdram_u1_s1_waitrequest_from_sa;

  //sdram_u1_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_u1_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u1_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_u1_s1_in_a_read_cycle;

  //sdram_u1_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_u1_s1_waits_for_write = sdram_u1_s1_in_a_write_cycle & sdram_u1_s1_waitrequest_from_sa;

  //sdram_u1_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_u1_s1_in_a_write_cycle = cpu_data_master_granted_sdram_u1_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_u1_s1_in_a_write_cycle;

  assign wait_for_sdram_u1_s1_counter = 0;
  //~sdram_u1_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_u1_s1_byteenable_n = ~((cpu_data_master_granted_sdram_u1_s1)? cpu_data_master_byteenable_sdram_u1_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_u1_s1_segment_1,
cpu_data_master_byteenable_sdram_u1_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_u1_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_u1_s1_segment_0 :
    cpu_data_master_byteenable_sdram_u1_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_u1/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_u1_s1 + cpu_instruction_master_granted_sdram_u1_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_u1_s1 + cpu_instruction_master_saved_grant_sdram_u1_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_u2_s1_module (
                                                            // inputs:
                                                             clear_fifo,
                                                             clk,
                                                             data_in,
                                                             read,
                                                             reset_n,
                                                             sync_reset,
                                                             write,

                                                            // outputs:
                                                             data_out,
                                                             empty,
                                                             fifo_contains_ones_n,
                                                             full
                                                          )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1_module (
                                                                   // inputs:
                                                                    clear_fifo,
                                                                    clk,
                                                                    data_in,
                                                                    read,
                                                                    reset_n,
                                                                    sync_reset,
                                                                    write,

                                                                   // outputs:
                                                                    data_out,
                                                                    empty,
                                                                    fifo_contains_ones_n,
                                                                    full
                                                                 )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_u2_s1_arbitrator (
                                // inputs:
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_byteenable,
                                 cpu_data_master_dbs_address,
                                 cpu_data_master_dbs_write_16,
                                 cpu_data_master_latency_counter,
                                 cpu_data_master_read,
                                 cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                 cpu_data_master_write,
                                 cpu_instruction_master_address_to_slave,
                                 cpu_instruction_master_dbs_address,
                                 cpu_instruction_master_latency_counter,
                                 cpu_instruction_master_read,
                                 cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register,
                                 reset_n,
                                 sdram_u2_s1_readdata,
                                 sdram_u2_s1_readdatavalid,
                                 sdram_u2_s1_waitrequest,

                                // outputs:
                                 cpu_data_master_byteenable_sdram_u2_s1,
                                 cpu_data_master_granted_sdram_u2_s1,
                                 cpu_data_master_qualified_request_sdram_u2_s1,
                                 cpu_data_master_read_data_valid_sdram_u2_s1,
                                 cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_data_master_requests_sdram_u2_s1,
                                 cpu_instruction_master_granted_sdram_u2_s1,
                                 cpu_instruction_master_qualified_request_sdram_u2_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1,
                                 cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register,
                                 cpu_instruction_master_requests_sdram_u2_s1,
                                 d1_sdram_u2_s1_end_xfer,
                                 sdram_u2_s1_address,
                                 sdram_u2_s1_byteenable_n,
                                 sdram_u2_s1_chipselect,
                                 sdram_u2_s1_read_n,
                                 sdram_u2_s1_readdata_from_sa,
                                 sdram_u2_s1_reset_n,
                                 sdram_u2_s1_waitrequest_from_sa,
                                 sdram_u2_s1_write_n,
                                 sdram_u2_s1_writedata
                              )
;

  output  [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  output           cpu_data_master_granted_sdram_u2_s1;
  output           cpu_data_master_qualified_request_sdram_u2_s1;
  output           cpu_data_master_read_data_valid_sdram_u2_s1;
  output           cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  output           cpu_data_master_requests_sdram_u2_s1;
  output           cpu_instruction_master_granted_sdram_u2_s1;
  output           cpu_instruction_master_qualified_request_sdram_u2_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u2_s1;
  output           cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_u2_s1;
  output           d1_sdram_u2_s1_end_xfer;
  output  [ 23: 0] sdram_u2_s1_address;
  output  [  1: 0] sdram_u2_s1_byteenable_n;
  output           sdram_u2_s1_chipselect;
  output           sdram_u2_s1_read_n;
  output  [ 15: 0] sdram_u2_s1_readdata_from_sa;
  output           sdram_u2_s1_reset_n;
  output           sdram_u2_s1_waitrequest_from_sa;
  output           sdram_u2_s1_write_n;
  output  [ 15: 0] sdram_u2_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 27: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  input            reset_n;
  input   [ 15: 0] sdram_u2_s1_readdata;
  input            sdram_u2_s1_readdatavalid;
  input            sdram_u2_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_u2_s1;
  wire             cpu_data_master_qualified_request_sdram_u2_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_u2_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_data_master_requests_sdram_u2_s1;
  wire             cpu_data_master_saved_grant_sdram_u2_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_u2_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u2_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_u2_s1;
  wire             cpu_instruction_master_saved_grant_sdram_u2_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_u2_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_u2_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_u2_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1;
  wire    [ 23: 0] sdram_u2_s1_address;
  wire             sdram_u2_s1_allgrants;
  wire             sdram_u2_s1_allow_new_arb_cycle;
  wire             sdram_u2_s1_any_bursting_master_saved_grant;
  wire             sdram_u2_s1_any_continuerequest;
  reg     [  1: 0] sdram_u2_s1_arb_addend;
  wire             sdram_u2_s1_arb_counter_enable;
  reg     [  1: 0] sdram_u2_s1_arb_share_counter;
  wire    [  1: 0] sdram_u2_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_u2_s1_arb_share_set_values;
  wire    [  1: 0] sdram_u2_s1_arb_winner;
  wire             sdram_u2_s1_arbitration_holdoff_internal;
  wire             sdram_u2_s1_beginbursttransfer_internal;
  wire             sdram_u2_s1_begins_xfer;
  wire    [  1: 0] sdram_u2_s1_byteenable_n;
  wire             sdram_u2_s1_chipselect;
  wire    [  3: 0] sdram_u2_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_u2_s1_chosen_master_rot_left;
  wire             sdram_u2_s1_end_xfer;
  wire             sdram_u2_s1_firsttransfer;
  wire    [  1: 0] sdram_u2_s1_grant_vector;
  wire             sdram_u2_s1_in_a_read_cycle;
  wire             sdram_u2_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_u2_s1_master_qreq_vector;
  wire             sdram_u2_s1_move_on_to_next_transaction;
  wire             sdram_u2_s1_non_bursting_master_requests;
  wire             sdram_u2_s1_read_n;
  wire    [ 15: 0] sdram_u2_s1_readdata_from_sa;
  wire             sdram_u2_s1_readdatavalid_from_sa;
  reg              sdram_u2_s1_reg_firsttransfer;
  wire             sdram_u2_s1_reset_n;
  reg     [  1: 0] sdram_u2_s1_saved_chosen_master_vector;
  reg              sdram_u2_s1_slavearbiterlockenable;
  wire             sdram_u2_s1_slavearbiterlockenable2;
  wire             sdram_u2_s1_unreg_firsttransfer;
  wire             sdram_u2_s1_waitrequest_from_sa;
  wire             sdram_u2_s1_waits_for_read;
  wire             sdram_u2_s1_waits_for_write;
  wire             sdram_u2_s1_write_n;
  wire    [ 15: 0] sdram_u2_s1_writedata;
  wire    [ 27: 0] shifted_address_to_sdram_u2_s1_from_cpu_data_master;
  wire    [ 27: 0] shifted_address_to_sdram_u2_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_u2_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sdram_u2_s1_end_xfer;
    end


  assign sdram_u2_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_u2_s1 | cpu_instruction_master_qualified_request_sdram_u2_s1));
  //assign sdram_u2_s1_readdatavalid_from_sa = sdram_u2_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_readdatavalid_from_sa = sdram_u2_s1_readdatavalid;

  //assign sdram_u2_s1_readdata_from_sa = sdram_u2_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_readdata_from_sa = sdram_u2_s1_readdata;

  assign cpu_data_master_requests_sdram_u2_s1 = ({cpu_data_master_address_to_slave[27 : 25] , 25'b0} == 28'h6000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_u2_s1_waitrequest_from_sa = sdram_u2_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_u2_s1_waitrequest_from_sa = sdram_u2_s1_waitrequest;

  //sdram_u2_s1_arb_share_counter set values, which is an e_mux
  assign sdram_u2_s1_arb_share_set_values = (cpu_data_master_granted_sdram_u2_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u2_s1)? 2 :
    (cpu_data_master_granted_sdram_u2_s1)? 2 :
    (cpu_instruction_master_granted_sdram_u2_s1)? 2 :
    1;

  //sdram_u2_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_u2_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_u2_s1 |
    cpu_instruction_master_requests_sdram_u2_s1 |
    cpu_data_master_requests_sdram_u2_s1 |
    cpu_instruction_master_requests_sdram_u2_s1;

  //sdram_u2_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_u2_s1_any_bursting_master_saved_grant = 0;

  //sdram_u2_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_u2_s1_arb_share_counter_next_value = sdram_u2_s1_firsttransfer ? (sdram_u2_s1_arb_share_set_values - 1) : |sdram_u2_s1_arb_share_counter ? (sdram_u2_s1_arb_share_counter - 1) : 0;

  //sdram_u2_s1_allgrants all slave grants, which is an e_mux
  assign sdram_u2_s1_allgrants = |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector |
    |sdram_u2_s1_grant_vector;

  //sdram_u2_s1_end_xfer assignment, which is an e_assign
  assign sdram_u2_s1_end_xfer = ~(sdram_u2_s1_waits_for_read | sdram_u2_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_u2_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_u2_s1 = sdram_u2_s1_end_xfer & (~sdram_u2_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_u2_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_u2_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_u2_s1 & sdram_u2_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_u2_s1 & ~sdram_u2_s1_non_bursting_master_requests);

  //sdram_u2_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_arb_share_counter <= 0;
      else if (sdram_u2_s1_arb_counter_enable)
          sdram_u2_s1_arb_share_counter <= sdram_u2_s1_arb_share_counter_next_value;
    end


  //sdram_u2_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_u2_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_u2_s1) | (end_xfer_arb_share_counter_term_sdram_u2_s1 & ~sdram_u2_s1_non_bursting_master_requests))
          sdram_u2_s1_slavearbiterlockenable <= |sdram_u2_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram_u2/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_u2_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_u2_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_u2_s1_slavearbiterlockenable2 = |sdram_u2_s1_arb_share_counter_next_value;

  //cpu/data_master sdram_u2/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_u2_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram_u2/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_u2_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram_u2/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_u2_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram_u2/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 <= 0;
      else if (1)
          last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 <= cpu_instruction_master_saved_grant_sdram_u2_s1 ? 1 : (sdram_u2_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_u2_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_u2_s1 & cpu_instruction_master_requests_sdram_u2_s1;

  //sdram_u2_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_u2_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_u2_s1 = cpu_data_master_requests_sdram_u2_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (1 < cpu_data_master_latency_counter) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register))) | ((!cpu_data_master_byteenable_sdram_u2_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_u2_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_u2_s1_move_on_to_next_transaction = sdram_u2_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_u2_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_u2_s1_module rdv_fifo_for_cpu_data_master_to_sdram_u2_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_u2_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_u2_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_u2_s1),
      .full                 (),
      .read                 (sdram_u2_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u2_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_u2_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_u2_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_u2_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_u2_s1 = (sdram_u2_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_u2_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_u2_s1;

  //sdram_u2_s1_writedata mux, which is an e_mux
  assign sdram_u2_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_u2_s1 = (({cpu_instruction_master_address_to_slave[27 : 25] , 25'b0} == 28'h6000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram_u2/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 <= 0;
      else if (1)
          last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 <= cpu_data_master_saved_grant_sdram_u2_s1 ? 1 : (sdram_u2_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_u2_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_u2_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_u2_s1 & cpu_data_master_requests_sdram_u2_s1;

  assign cpu_instruction_master_qualified_request_sdram_u2_s1 = cpu_instruction_master_requests_sdram_u2_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter) | (|cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_u2_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_u2_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1),
      .full                 (),
      .read                 (sdram_u2_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_u2_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_u2_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_u2_s1 = (sdram_u2_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_u2_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_u2_s1;

  //allow new arb cycle for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_u2_s1;

  //cpu/instruction_master grant sdram_u2/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_u2_s1 = sdram_u2_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram_u2/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_u2_s1 = sdram_u2_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_u2_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram_u2/s1, which is an e_assign
  assign sdram_u2_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_u2_s1;

  //cpu/data_master grant sdram_u2/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_u2_s1 = sdram_u2_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram_u2/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_u2_s1 = sdram_u2_s1_arb_winner[1] && cpu_data_master_requests_sdram_u2_s1;

  //sdram_u2/s1 chosen-master double-vector, which is an e_assign
  assign sdram_u2_s1_chosen_master_double_vector = {sdram_u2_s1_master_qreq_vector, sdram_u2_s1_master_qreq_vector} & ({~sdram_u2_s1_master_qreq_vector, ~sdram_u2_s1_master_qreq_vector} + sdram_u2_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_u2_s1_arb_winner = (sdram_u2_s1_allow_new_arb_cycle & | sdram_u2_s1_grant_vector) ? sdram_u2_s1_grant_vector : sdram_u2_s1_saved_chosen_master_vector;

  //saved sdram_u2_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_saved_chosen_master_vector <= 0;
      else if (sdram_u2_s1_allow_new_arb_cycle)
          sdram_u2_s1_saved_chosen_master_vector <= |sdram_u2_s1_grant_vector ? sdram_u2_s1_grant_vector : sdram_u2_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_u2_s1_grant_vector = {(sdram_u2_s1_chosen_master_double_vector[1] | sdram_u2_s1_chosen_master_double_vector[3]),
    (sdram_u2_s1_chosen_master_double_vector[0] | sdram_u2_s1_chosen_master_double_vector[2])};

  //sdram_u2/s1 chosen master rotated left, which is an e_assign
  assign sdram_u2_s1_chosen_master_rot_left = (sdram_u2_s1_arb_winner << 1) ? (sdram_u2_s1_arb_winner << 1) : 1;

  //sdram_u2/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_arb_addend <= 1;
      else if (|sdram_u2_s1_grant_vector)
          sdram_u2_s1_arb_addend <= sdram_u2_s1_end_xfer? sdram_u2_s1_chosen_master_rot_left : sdram_u2_s1_grant_vector;
    end


  //sdram_u2_s1_reset_n assignment, which is an e_assign
  assign sdram_u2_s1_reset_n = reset_n;

  assign sdram_u2_s1_chipselect = cpu_data_master_granted_sdram_u2_s1 | cpu_instruction_master_granted_sdram_u2_s1;
  //sdram_u2_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_u2_s1_firsttransfer = sdram_u2_s1_begins_xfer ? sdram_u2_s1_unreg_firsttransfer : sdram_u2_s1_reg_firsttransfer;

  //sdram_u2_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_u2_s1_unreg_firsttransfer = ~(sdram_u2_s1_slavearbiterlockenable & sdram_u2_s1_any_continuerequest);

  //sdram_u2_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_u2_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_u2_s1_begins_xfer)
          sdram_u2_s1_reg_firsttransfer <= sdram_u2_s1_unreg_firsttransfer;
    end


  //sdram_u2_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_u2_s1_beginbursttransfer_internal = sdram_u2_s1_begins_xfer;

  //sdram_u2_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_u2_s1_arbitration_holdoff_internal = sdram_u2_s1_begins_xfer & sdram_u2_s1_firsttransfer;

  //~sdram_u2_s1_read_n assignment, which is an e_mux
  assign sdram_u2_s1_read_n = ~((cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read));

  //~sdram_u2_s1_write_n assignment, which is an e_mux
  assign sdram_u2_s1_write_n = ~(cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_u2_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_u2_s1_address mux, which is an e_mux
  assign sdram_u2_s1_address = (cpu_data_master_granted_sdram_u2_s1)? (shifted_address_to_sdram_u2_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_u2_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_u2_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_u2_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_u2_s1_end_xfer <= 1;
      else if (1)
          d1_sdram_u2_s1_end_xfer <= sdram_u2_s1_end_xfer;
    end


  //sdram_u2_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_u2_s1_waits_for_read = sdram_u2_s1_in_a_read_cycle & sdram_u2_s1_waitrequest_from_sa;

  //sdram_u2_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_u2_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_u2_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_u2_s1_in_a_read_cycle;

  //sdram_u2_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_u2_s1_waits_for_write = sdram_u2_s1_in_a_write_cycle & sdram_u2_s1_waitrequest_from_sa;

  //sdram_u2_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_u2_s1_in_a_write_cycle = cpu_data_master_granted_sdram_u2_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_u2_s1_in_a_write_cycle;

  assign wait_for_sdram_u2_s1_counter = 0;
  //~sdram_u2_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_u2_s1_byteenable_n = ~((cpu_data_master_granted_sdram_u2_s1)? cpu_data_master_byteenable_sdram_u2_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_u2_s1_segment_1,
cpu_data_master_byteenable_sdram_u2_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_u2_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_u2_s1_segment_0 :
    cpu_data_master_byteenable_sdram_u2_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_u2/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_u2_s1 + cpu_instruction_master_granted_sdram_u2_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_u2_s1 + cpu_instruction_master_saved_grant_sdram_u2_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_data_master_address_to_slave,
                                         cpu_data_master_latency_counter,
                                         cpu_data_master_read,
                                         cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                         cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                         cpu_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_data_master_granted_sysid_control_slave,
                                         cpu_data_master_qualified_request_sysid_control_slave,
                                         cpu_data_master_read_data_valid_sysid_control_slave,
                                         cpu_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa
                                      )
;

  output           cpu_data_master_granted_sysid_control_slave;
  output           cpu_data_master_qualified_request_sysid_control_slave;
  output           cpu_data_master_read_data_valid_sysid_control_slave;
  output           cpu_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_sysid_control_slave_from_cpu_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_data_master_requests_sysid_control_slave = (({cpu_data_master_address_to_slave[27 : 3] , 3'b0} == 28'h96051d0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sysid_control_slave = cpu_data_master_requests_sysid_control_slave & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_sysid_control_slave, which is an e_mux
  assign cpu_data_master_read_data_valid_sysid_control_slave = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read & ~sysid_control_slave_waits_for_read;

  //master is always granted when requested
  assign cpu_data_master_granted_sysid_control_slave = cpu_data_master_qualified_request_sysid_control_slave;

  //cpu/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else if (1)
          d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_latency_counter,
                              cpu_data_master_read,
                              cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                              cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                              cpu_data_master_write,
                              cpu_data_master_writedata,
                              reset_n,
                              timer_s1_irq,
                              timer_s1_readdata,

                             // outputs:
                              cpu_data_master_granted_timer_s1,
                              cpu_data_master_qualified_request_timer_s1,
                              cpu_data_master_read_data_valid_timer_s1,
                              cpu_data_master_requests_timer_s1,
                              d1_timer_s1_end_xfer,
                              timer_s1_address,
                              timer_s1_chipselect,
                              timer_s1_irq_from_sa,
                              timer_s1_readdata_from_sa,
                              timer_s1_reset_n,
                              timer_s1_write_n,
                              timer_s1_writedata
                           )
;

  output           cpu_data_master_granted_timer_s1;
  output           cpu_data_master_qualified_request_timer_s1;
  output           cpu_data_master_read_data_valid_timer_s1;
  output           cpu_data_master_requests_timer_s1;
  output           d1_timer_s1_end_xfer;
  output  [  2: 0] timer_s1_address;
  output           timer_s1_chipselect;
  output           timer_s1_irq_from_sa;
  output  [ 15: 0] timer_s1_readdata_from_sa;
  output           timer_s1_reset_n;
  output           timer_s1_write_n;
  output  [ 15: 0] timer_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            timer_s1_irq;
  input   [ 15: 0] timer_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_saved_grant_timer_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_timer_s1_from_cpu_data_master;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_allgrants;
  wire             timer_s1_allow_new_arb_cycle;
  wire             timer_s1_any_bursting_master_saved_grant;
  wire             timer_s1_any_continuerequest;
  wire             timer_s1_arb_counter_enable;
  reg     [  1: 0] timer_s1_arb_share_counter;
  wire    [  1: 0] timer_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_s1_arb_share_set_values;
  wire             timer_s1_beginbursttransfer_internal;
  wire             timer_s1_begins_xfer;
  wire             timer_s1_chipselect;
  wire             timer_s1_end_xfer;
  wire             timer_s1_firsttransfer;
  wire             timer_s1_grant_vector;
  wire             timer_s1_in_a_read_cycle;
  wire             timer_s1_in_a_write_cycle;
  wire             timer_s1_irq_from_sa;
  wire             timer_s1_master_qreq_vector;
  wire             timer_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  reg              timer_s1_reg_firsttransfer;
  wire             timer_s1_reset_n;
  reg              timer_s1_slavearbiterlockenable;
  wire             timer_s1_slavearbiterlockenable2;
  wire             timer_s1_unreg_firsttransfer;
  wire             timer_s1_waits_for_read;
  wire             timer_s1_waits_for_write;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire             wait_for_timer_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~timer_s1_end_xfer;
    end


  assign timer_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_timer_s1));
  //assign timer_s1_readdata_from_sa = timer_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_readdata_from_sa = timer_s1_readdata;

  assign cpu_data_master_requests_timer_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h9605080) & (cpu_data_master_read | cpu_data_master_write);
  //timer_s1_arb_share_counter set values, which is an e_mux
  assign timer_s1_arb_share_set_values = 1;

  //timer_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_s1_non_bursting_master_requests = cpu_data_master_requests_timer_s1;

  //timer_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_s1_any_bursting_master_saved_grant = 0;

  //timer_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_s1_arb_share_counter_next_value = timer_s1_firsttransfer ? (timer_s1_arb_share_set_values - 1) : |timer_s1_arb_share_counter ? (timer_s1_arb_share_counter - 1) : 0;

  //timer_s1_allgrants all slave grants, which is an e_mux
  assign timer_s1_allgrants = |timer_s1_grant_vector;

  //timer_s1_end_xfer assignment, which is an e_assign
  assign timer_s1_end_xfer = ~(timer_s1_waits_for_read | timer_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_s1 = timer_s1_end_xfer & (~timer_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_s1 & timer_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests);

  //timer_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_arb_share_counter <= 0;
      else if (timer_s1_arb_counter_enable)
          timer_s1_arb_share_counter <= timer_s1_arb_share_counter_next_value;
    end


  //timer_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_slavearbiterlockenable <= 0;
      else if ((|timer_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_s1) | (end_xfer_arb_share_counter_term_timer_s1 & ~timer_s1_non_bursting_master_requests))
          timer_s1_slavearbiterlockenable <= |timer_s1_arb_share_counter_next_value;
    end


  //cpu/data_master timer/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = timer_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //timer_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_s1_slavearbiterlockenable2 = |timer_s1_arb_share_counter_next_value;

  //cpu/data_master timer/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = timer_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //timer_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_timer_s1 = cpu_data_master_requests_timer_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_timer_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_timer_s1 = cpu_data_master_granted_timer_s1 & cpu_data_master_read & ~timer_s1_waits_for_read;

  //timer_s1_writedata mux, which is an e_mux
  assign timer_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_timer_s1 = cpu_data_master_qualified_request_timer_s1;

  //cpu/data_master saved-grant timer/s1, which is an e_assign
  assign cpu_data_master_saved_grant_timer_s1 = cpu_data_master_requests_timer_s1;

  //allow new arb cycle for timer/s1, which is an e_assign
  assign timer_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_s1_master_qreq_vector = 1;

  //timer_s1_reset_n assignment, which is an e_assign
  assign timer_s1_reset_n = reset_n;

  assign timer_s1_chipselect = cpu_data_master_granted_timer_s1;
  //timer_s1_firsttransfer first transaction, which is an e_assign
  assign timer_s1_firsttransfer = timer_s1_begins_xfer ? timer_s1_unreg_firsttransfer : timer_s1_reg_firsttransfer;

  //timer_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_s1_unreg_firsttransfer = ~(timer_s1_slavearbiterlockenable & timer_s1_any_continuerequest);

  //timer_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_s1_reg_firsttransfer <= 1'b1;
      else if (timer_s1_begins_xfer)
          timer_s1_reg_firsttransfer <= timer_s1_unreg_firsttransfer;
    end


  //timer_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_s1_beginbursttransfer_internal = timer_s1_begins_xfer;

  //~timer_s1_write_n assignment, which is an e_mux
  assign timer_s1_write_n = ~(cpu_data_master_granted_timer_s1 & cpu_data_master_write);

  assign shifted_address_to_timer_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //timer_s1_address mux, which is an e_mux
  assign timer_s1_address = shifted_address_to_timer_s1_from_cpu_data_master >> 2;

  //d1_timer_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_s1_end_xfer <= 1;
      else if (1)
          d1_timer_s1_end_xfer <= timer_s1_end_xfer;
    end


  //timer_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_s1_waits_for_read = timer_s1_in_a_read_cycle & timer_s1_begins_xfer;

  //timer_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_s1_in_a_read_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_s1_in_a_read_cycle;

  //timer_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_s1_waits_for_write = timer_s1_in_a_write_cycle & 0;

  //timer_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_s1_in_a_write_cycle = cpu_data_master_granted_timer_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_s1_in_a_write_cycle;

  assign wait_for_timer_s1_counter = 0;
  //assign timer_s1_irq_from_sa = timer_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_s1_irq_from_sa = timer_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_stamp_s1_arbitrator (
                                   // inputs:
                                    clk,
                                    cpu_data_master_address_to_slave,
                                    cpu_data_master_latency_counter,
                                    cpu_data_master_read,
                                    cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                                    cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                                    cpu_data_master_write,
                                    cpu_data_master_writedata,
                                    reset_n,
                                    timer_stamp_s1_irq,
                                    timer_stamp_s1_readdata,

                                   // outputs:
                                    cpu_data_master_granted_timer_stamp_s1,
                                    cpu_data_master_qualified_request_timer_stamp_s1,
                                    cpu_data_master_read_data_valid_timer_stamp_s1,
                                    cpu_data_master_requests_timer_stamp_s1,
                                    d1_timer_stamp_s1_end_xfer,
                                    timer_stamp_s1_address,
                                    timer_stamp_s1_chipselect,
                                    timer_stamp_s1_irq_from_sa,
                                    timer_stamp_s1_readdata_from_sa,
                                    timer_stamp_s1_reset_n,
                                    timer_stamp_s1_write_n,
                                    timer_stamp_s1_writedata
                                 )
;

  output           cpu_data_master_granted_timer_stamp_s1;
  output           cpu_data_master_qualified_request_timer_stamp_s1;
  output           cpu_data_master_read_data_valid_timer_stamp_s1;
  output           cpu_data_master_requests_timer_stamp_s1;
  output           d1_timer_stamp_s1_end_xfer;
  output  [  2: 0] timer_stamp_s1_address;
  output           timer_stamp_s1_chipselect;
  output           timer_stamp_s1_irq_from_sa;
  output  [ 15: 0] timer_stamp_s1_readdata_from_sa;
  output           timer_stamp_s1_reset_n;
  output           timer_stamp_s1_write_n;
  output  [ 15: 0] timer_stamp_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            timer_stamp_s1_irq;
  input   [ 15: 0] timer_stamp_s1_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_timer_stamp_s1;
  wire             cpu_data_master_qualified_request_timer_stamp_s1;
  wire             cpu_data_master_read_data_valid_timer_stamp_s1;
  wire             cpu_data_master_requests_timer_stamp_s1;
  wire             cpu_data_master_saved_grant_timer_stamp_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_stamp_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_stamp_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_timer_stamp_s1_from_cpu_data_master;
  wire    [  2: 0] timer_stamp_s1_address;
  wire             timer_stamp_s1_allgrants;
  wire             timer_stamp_s1_allow_new_arb_cycle;
  wire             timer_stamp_s1_any_bursting_master_saved_grant;
  wire             timer_stamp_s1_any_continuerequest;
  wire             timer_stamp_s1_arb_counter_enable;
  reg     [  1: 0] timer_stamp_s1_arb_share_counter;
  wire    [  1: 0] timer_stamp_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_stamp_s1_arb_share_set_values;
  wire             timer_stamp_s1_beginbursttransfer_internal;
  wire             timer_stamp_s1_begins_xfer;
  wire             timer_stamp_s1_chipselect;
  wire             timer_stamp_s1_end_xfer;
  wire             timer_stamp_s1_firsttransfer;
  wire             timer_stamp_s1_grant_vector;
  wire             timer_stamp_s1_in_a_read_cycle;
  wire             timer_stamp_s1_in_a_write_cycle;
  wire             timer_stamp_s1_irq_from_sa;
  wire             timer_stamp_s1_master_qreq_vector;
  wire             timer_stamp_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_stamp_s1_readdata_from_sa;
  reg              timer_stamp_s1_reg_firsttransfer;
  wire             timer_stamp_s1_reset_n;
  reg              timer_stamp_s1_slavearbiterlockenable;
  wire             timer_stamp_s1_slavearbiterlockenable2;
  wire             timer_stamp_s1_unreg_firsttransfer;
  wire             timer_stamp_s1_waits_for_read;
  wire             timer_stamp_s1_waits_for_write;
  wire             timer_stamp_s1_write_n;
  wire    [ 15: 0] timer_stamp_s1_writedata;
  wire             wait_for_timer_stamp_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~timer_stamp_s1_end_xfer;
    end


  assign timer_stamp_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_timer_stamp_s1));
  //assign timer_stamp_s1_readdata_from_sa = timer_stamp_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_stamp_s1_readdata_from_sa = timer_stamp_s1_readdata;

  assign cpu_data_master_requests_timer_stamp_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96050a0) & (cpu_data_master_read | cpu_data_master_write);
  //timer_stamp_s1_arb_share_counter set values, which is an e_mux
  assign timer_stamp_s1_arb_share_set_values = 1;

  //timer_stamp_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_stamp_s1_non_bursting_master_requests = cpu_data_master_requests_timer_stamp_s1;

  //timer_stamp_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_stamp_s1_any_bursting_master_saved_grant = 0;

  //timer_stamp_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_stamp_s1_arb_share_counter_next_value = timer_stamp_s1_firsttransfer ? (timer_stamp_s1_arb_share_set_values - 1) : |timer_stamp_s1_arb_share_counter ? (timer_stamp_s1_arb_share_counter - 1) : 0;

  //timer_stamp_s1_allgrants all slave grants, which is an e_mux
  assign timer_stamp_s1_allgrants = |timer_stamp_s1_grant_vector;

  //timer_stamp_s1_end_xfer assignment, which is an e_assign
  assign timer_stamp_s1_end_xfer = ~(timer_stamp_s1_waits_for_read | timer_stamp_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_stamp_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_stamp_s1 = timer_stamp_s1_end_xfer & (~timer_stamp_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_stamp_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_stamp_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_stamp_s1 & timer_stamp_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_stamp_s1 & ~timer_stamp_s1_non_bursting_master_requests);

  //timer_stamp_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_arb_share_counter <= 0;
      else if (timer_stamp_s1_arb_counter_enable)
          timer_stamp_s1_arb_share_counter <= timer_stamp_s1_arb_share_counter_next_value;
    end


  //timer_stamp_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_slavearbiterlockenable <= 0;
      else if ((|timer_stamp_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_stamp_s1) | (end_xfer_arb_share_counter_term_timer_stamp_s1 & ~timer_stamp_s1_non_bursting_master_requests))
          timer_stamp_s1_slavearbiterlockenable <= |timer_stamp_s1_arb_share_counter_next_value;
    end


  //cpu/data_master timer_stamp/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = timer_stamp_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //timer_stamp_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_stamp_s1_slavearbiterlockenable2 = |timer_stamp_s1_arb_share_counter_next_value;

  //cpu/data_master timer_stamp/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = timer_stamp_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //timer_stamp_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_stamp_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_timer_stamp_s1 = cpu_data_master_requests_timer_stamp_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_timer_stamp_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_timer_stamp_s1 = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_read & ~timer_stamp_s1_waits_for_read;

  //timer_stamp_s1_writedata mux, which is an e_mux
  assign timer_stamp_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_timer_stamp_s1 = cpu_data_master_qualified_request_timer_stamp_s1;

  //cpu/data_master saved-grant timer_stamp/s1, which is an e_assign
  assign cpu_data_master_saved_grant_timer_stamp_s1 = cpu_data_master_requests_timer_stamp_s1;

  //allow new arb cycle for timer_stamp/s1, which is an e_assign
  assign timer_stamp_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_stamp_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_stamp_s1_master_qreq_vector = 1;

  //timer_stamp_s1_reset_n assignment, which is an e_assign
  assign timer_stamp_s1_reset_n = reset_n;

  assign timer_stamp_s1_chipselect = cpu_data_master_granted_timer_stamp_s1;
  //timer_stamp_s1_firsttransfer first transaction, which is an e_assign
  assign timer_stamp_s1_firsttransfer = timer_stamp_s1_begins_xfer ? timer_stamp_s1_unreg_firsttransfer : timer_stamp_s1_reg_firsttransfer;

  //timer_stamp_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_stamp_s1_unreg_firsttransfer = ~(timer_stamp_s1_slavearbiterlockenable & timer_stamp_s1_any_continuerequest);

  //timer_stamp_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_stamp_s1_reg_firsttransfer <= 1'b1;
      else if (timer_stamp_s1_begins_xfer)
          timer_stamp_s1_reg_firsttransfer <= timer_stamp_s1_unreg_firsttransfer;
    end


  //timer_stamp_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_stamp_s1_beginbursttransfer_internal = timer_stamp_s1_begins_xfer;

  //~timer_stamp_s1_write_n assignment, which is an e_mux
  assign timer_stamp_s1_write_n = ~(cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_write);

  assign shifted_address_to_timer_stamp_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //timer_stamp_s1_address mux, which is an e_mux
  assign timer_stamp_s1_address = shifted_address_to_timer_stamp_s1_from_cpu_data_master >> 2;

  //d1_timer_stamp_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_stamp_s1_end_xfer <= 1;
      else if (1)
          d1_timer_stamp_s1_end_xfer <= timer_stamp_s1_end_xfer;
    end


  //timer_stamp_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_stamp_s1_waits_for_read = timer_stamp_s1_in_a_read_cycle & timer_stamp_s1_begins_xfer;

  //timer_stamp_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_stamp_s1_in_a_read_cycle = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_stamp_s1_in_a_read_cycle;

  //timer_stamp_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_stamp_s1_waits_for_write = timer_stamp_s1_in_a_write_cycle & 0;

  //timer_stamp_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_stamp_s1_in_a_write_cycle = cpu_data_master_granted_timer_stamp_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_stamp_s1_in_a_write_cycle;

  assign wait_for_timer_stamp_s1_counter = 0;
  //assign timer_stamp_s1_irq_from_sa = timer_stamp_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_stamp_s1_irq_from_sa = timer_stamp_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_stamp/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module uart_s1_arbitrator (
                            // inputs:
                             clk,
                             cpu_data_master_address_to_slave,
                             cpu_data_master_latency_counter,
                             cpu_data_master_read,
                             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register,
                             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register,
                             cpu_data_master_write,
                             cpu_data_master_writedata,
                             reset_n,
                             uart_s1_dataavailable,
                             uart_s1_irq,
                             uart_s1_readdata,
                             uart_s1_readyfordata,

                            // outputs:
                             cpu_data_master_granted_uart_s1,
                             cpu_data_master_qualified_request_uart_s1,
                             cpu_data_master_read_data_valid_uart_s1,
                             cpu_data_master_requests_uart_s1,
                             d1_uart_s1_end_xfer,
                             uart_s1_address,
                             uart_s1_begintransfer,
                             uart_s1_chipselect,
                             uart_s1_dataavailable_from_sa,
                             uart_s1_irq_from_sa,
                             uart_s1_read_n,
                             uart_s1_readdata_from_sa,
                             uart_s1_readyfordata_from_sa,
                             uart_s1_reset_n,
                             uart_s1_write_n,
                             uart_s1_writedata
                          )
;

  output           cpu_data_master_granted_uart_s1;
  output           cpu_data_master_qualified_request_uart_s1;
  output           cpu_data_master_read_data_valid_uart_s1;
  output           cpu_data_master_requests_uart_s1;
  output           d1_uart_s1_end_xfer;
  output  [  2: 0] uart_s1_address;
  output           uart_s1_begintransfer;
  output           uart_s1_chipselect;
  output           uart_s1_dataavailable_from_sa;
  output           uart_s1_irq_from_sa;
  output           uart_s1_read_n;
  output  [ 15: 0] uart_s1_readdata_from_sa;
  output           uart_s1_readyfordata_from_sa;
  output           uart_s1_reset_n;
  output           uart_s1_write_n;
  output  [ 15: 0] uart_s1_writedata;
  input            clk;
  input   [ 27: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_latency_counter;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  input            cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;
  input            uart_s1_dataavailable;
  input            uart_s1_irq;
  input   [ 15: 0] uart_s1_readdata;
  input            uart_s1_readyfordata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_uart_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_saved_grant_uart_s1;
  reg              d1_reasons_to_wait;
  reg              d1_uart_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_uart_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 27: 0] shifted_address_to_uart_s1_from_cpu_data_master;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_allgrants;
  wire             uart_s1_allow_new_arb_cycle;
  wire             uart_s1_any_bursting_master_saved_grant;
  wire             uart_s1_any_continuerequest;
  wire             uart_s1_arb_counter_enable;
  reg     [  1: 0] uart_s1_arb_share_counter;
  wire    [  1: 0] uart_s1_arb_share_counter_next_value;
  wire    [  1: 0] uart_s1_arb_share_set_values;
  wire             uart_s1_beginbursttransfer_internal;
  wire             uart_s1_begins_xfer;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_end_xfer;
  wire             uart_s1_firsttransfer;
  wire             uart_s1_grant_vector;
  wire             uart_s1_in_a_read_cycle;
  wire             uart_s1_in_a_write_cycle;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_master_qreq_vector;
  wire             uart_s1_non_bursting_master_requests;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  reg              uart_s1_reg_firsttransfer;
  wire             uart_s1_reset_n;
  reg              uart_s1_slavearbiterlockenable;
  wire             uart_s1_slavearbiterlockenable2;
  wire             uart_s1_unreg_firsttransfer;
  wire             uart_s1_waits_for_read;
  wire             uart_s1_waits_for_write;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire             wait_for_uart_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~uart_s1_end_xfer;
    end


  assign uart_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_uart_s1));
  //assign uart_s1_readdata_from_sa = uart_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readdata_from_sa = uart_s1_readdata;

  assign cpu_data_master_requests_uart_s1 = ({cpu_data_master_address_to_slave[27 : 5] , 5'b0} == 28'h96050c0) & (cpu_data_master_read | cpu_data_master_write);
  //assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_dataavailable_from_sa = uart_s1_dataavailable;

  //assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_readyfordata_from_sa = uart_s1_readyfordata;

  //uart_s1_arb_share_counter set values, which is an e_mux
  assign uart_s1_arb_share_set_values = 1;

  //uart_s1_non_bursting_master_requests mux, which is an e_mux
  assign uart_s1_non_bursting_master_requests = cpu_data_master_requests_uart_s1;

  //uart_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign uart_s1_any_bursting_master_saved_grant = 0;

  //uart_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign uart_s1_arb_share_counter_next_value = uart_s1_firsttransfer ? (uart_s1_arb_share_set_values - 1) : |uart_s1_arb_share_counter ? (uart_s1_arb_share_counter - 1) : 0;

  //uart_s1_allgrants all slave grants, which is an e_mux
  assign uart_s1_allgrants = |uart_s1_grant_vector;

  //uart_s1_end_xfer assignment, which is an e_assign
  assign uart_s1_end_xfer = ~(uart_s1_waits_for_read | uart_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_uart_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_uart_s1 = uart_s1_end_xfer & (~uart_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //uart_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign uart_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_uart_s1 & uart_s1_allgrants) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests);

  //uart_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_arb_share_counter <= 0;
      else if (uart_s1_arb_counter_enable)
          uart_s1_arb_share_counter <= uart_s1_arb_share_counter_next_value;
    end


  //uart_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_slavearbiterlockenable <= 0;
      else if ((|uart_s1_master_qreq_vector & end_xfer_arb_share_counter_term_uart_s1) | (end_xfer_arb_share_counter_term_uart_s1 & ~uart_s1_non_bursting_master_requests))
          uart_s1_slavearbiterlockenable <= |uart_s1_arb_share_counter_next_value;
    end


  //cpu/data_master uart/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = uart_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //uart_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign uart_s1_slavearbiterlockenable2 = |uart_s1_arb_share_counter_next_value;

  //cpu/data_master uart/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = uart_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //uart_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign uart_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_uart_s1 = cpu_data_master_requests_uart_s1 & ~((cpu_data_master_read & ((cpu_data_master_latency_counter != 0) | (|cpu_data_master_read_data_valid_sdram_u1_s1_shift_register) | (|cpu_data_master_read_data_valid_sdram_u2_s1_shift_register))));
  //local readdatavalid cpu_data_master_read_data_valid_uart_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_uart_s1 = cpu_data_master_granted_uart_s1 & cpu_data_master_read & ~uart_s1_waits_for_read;

  //uart_s1_writedata mux, which is an e_mux
  assign uart_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_uart_s1 = cpu_data_master_qualified_request_uart_s1;

  //cpu/data_master saved-grant uart/s1, which is an e_assign
  assign cpu_data_master_saved_grant_uart_s1 = cpu_data_master_requests_uart_s1;

  //allow new arb cycle for uart/s1, which is an e_assign
  assign uart_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign uart_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign uart_s1_master_qreq_vector = 1;

  assign uart_s1_begintransfer = uart_s1_begins_xfer;
  //uart_s1_reset_n assignment, which is an e_assign
  assign uart_s1_reset_n = reset_n;

  assign uart_s1_chipselect = cpu_data_master_granted_uart_s1;
  //uart_s1_firsttransfer first transaction, which is an e_assign
  assign uart_s1_firsttransfer = uart_s1_begins_xfer ? uart_s1_unreg_firsttransfer : uart_s1_reg_firsttransfer;

  //uart_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign uart_s1_unreg_firsttransfer = ~(uart_s1_slavearbiterlockenable & uart_s1_any_continuerequest);

  //uart_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          uart_s1_reg_firsttransfer <= 1'b1;
      else if (uart_s1_begins_xfer)
          uart_s1_reg_firsttransfer <= uart_s1_unreg_firsttransfer;
    end


  //uart_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign uart_s1_beginbursttransfer_internal = uart_s1_begins_xfer;

  //~uart_s1_read_n assignment, which is an e_mux
  assign uart_s1_read_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_read);

  //~uart_s1_write_n assignment, which is an e_mux
  assign uart_s1_write_n = ~(cpu_data_master_granted_uart_s1 & cpu_data_master_write);

  assign shifted_address_to_uart_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //uart_s1_address mux, which is an e_mux
  assign uart_s1_address = shifted_address_to_uart_s1_from_cpu_data_master >> 2;

  //d1_uart_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_uart_s1_end_xfer <= 1;
      else if (1)
          d1_uart_s1_end_xfer <= uart_s1_end_xfer;
    end


  //uart_s1_waits_for_read in a cycle, which is an e_mux
  assign uart_s1_waits_for_read = uart_s1_in_a_read_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_read_cycle assignment, which is an e_assign
  assign uart_s1_in_a_read_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = uart_s1_in_a_read_cycle;

  //uart_s1_waits_for_write in a cycle, which is an e_mux
  assign uart_s1_waits_for_write = uart_s1_in_a_write_cycle & uart_s1_begins_xfer;

  //uart_s1_in_a_write_cycle assignment, which is an e_assign
  assign uart_s1_in_a_write_cycle = cpu_data_master_granted_uart_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = uart_s1_in_a_write_cycle;

  assign wait_for_uart_s1_counter = 0;
  //assign uart_s1_irq_from_sa = uart_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign uart_s1_irq_from_sa = uart_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //uart/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ii_reset_pll_c0_system_domain_synch_module (
                                                         // inputs:
                                                          clk,
                                                          data_in,
                                                          reset_n,

                                                         // outputs:
                                                          data_out
                                                       )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ii_reset_clk_50_domain_synch_module (
                                                  // inputs:
                                                   clk,
                                                   data_in,
                                                   reset_n,

                                                  // outputs:
                                                   data_out
                                                )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ii (
                 // 1) global signals:
                  clk_50,
                  pll_c0_system,
                  pll_c1_memory,
                  pll_c2_audio,
                  reset_n,

                 // the_SEG7
                  avs_s1_export_seg7_from_the_SEG7,

                 // the_lcd
                  LCD_E_from_the_lcd,
                  LCD_RS_from_the_lcd,
                  LCD_RW_from_the_lcd,
                  LCD_data_to_and_from_the_lcd,

                 // the_pio_button
                  in_port_to_the_pio_button,

                 // the_pio_green_led
                  out_port_from_the_pio_green_led,

                 // the_pio_red_led
                  out_port_from_the_pio_red_led,

                 // the_pio_switch
                  in_port_to_the_pio_switch,

                 // the_sdram_u1
                  zs_addr_from_the_sdram_u1,
                  zs_ba_from_the_sdram_u1,
                  zs_cas_n_from_the_sdram_u1,
                  zs_cke_from_the_sdram_u1,
                  zs_cs_n_from_the_sdram_u1,
                  zs_dq_to_and_from_the_sdram_u1,
                  zs_dqm_from_the_sdram_u1,
                  zs_ras_n_from_the_sdram_u1,
                  zs_we_n_from_the_sdram_u1,

                 // the_sdram_u2
                  zs_addr_from_the_sdram_u2,
                  zs_ba_from_the_sdram_u2,
                  zs_cas_n_from_the_sdram_u2,
                  zs_cke_from_the_sdram_u2,
                  zs_cs_n_from_the_sdram_u2,
                  zs_dq_to_and_from_the_sdram_u2,
                  zs_dqm_from_the_sdram_u2,
                  zs_ras_n_from_the_sdram_u2,
                  zs_we_n_from_the_sdram_u2,

                 // the_uart
                  cts_n_to_the_uart,
                  rts_n_from_the_uart,
                  rxd_to_the_uart,
                  txd_from_the_uart
               )
;

  output           LCD_E_from_the_lcd;
  output           LCD_RS_from_the_lcd;
  output           LCD_RW_from_the_lcd;
  inout   [  7: 0] LCD_data_to_and_from_the_lcd;
  output  [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  output  [  8: 0] out_port_from_the_pio_green_led;
  output  [ 17: 0] out_port_from_the_pio_red_led;
  output           pll_c0_system;
  output           pll_c1_memory;
  output           pll_c2_audio;
  output           rts_n_from_the_uart;
  output           txd_from_the_uart;
  output  [ 12: 0] zs_addr_from_the_sdram_u1;
  output  [ 12: 0] zs_addr_from_the_sdram_u2;
  output  [  1: 0] zs_ba_from_the_sdram_u1;
  output  [  1: 0] zs_ba_from_the_sdram_u2;
  output           zs_cas_n_from_the_sdram_u1;
  output           zs_cas_n_from_the_sdram_u2;
  output           zs_cke_from_the_sdram_u1;
  output           zs_cke_from_the_sdram_u2;
  output           zs_cs_n_from_the_sdram_u1;
  output           zs_cs_n_from_the_sdram_u2;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  output  [  1: 0] zs_dqm_from_the_sdram_u1;
  output  [  1: 0] zs_dqm_from_the_sdram_u2;
  output           zs_ras_n_from_the_sdram_u1;
  output           zs_ras_n_from_the_sdram_u2;
  output           zs_we_n_from_the_sdram_u1;
  output           zs_we_n_from_the_sdram_u2;
  input            clk_50;
  input            cts_n_to_the_uart;
  input   [  3: 0] in_port_to_the_pio_button;
  input   [ 17: 0] in_port_to_the_pio_switch;
  input            reset_n;
  input            rxd_to_the_uart;

  wire             LCD_E_from_the_lcd;
  wire             LCD_RS_from_the_lcd;
  wire             LCD_RW_from_the_lcd;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd;
  wire    [  2: 0] SEG7_s1_address;
  wire             SEG7_s1_read;
  wire    [  7: 0] SEG7_s1_readdata;
  wire    [  7: 0] SEG7_s1_readdata_from_sa;
  wire             SEG7_s1_reset;
  wire             SEG7_s1_write;
  wire    [  7: 0] SEG7_s1_writedata;
  wire    [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  wire             clk_50_reset_n;
  wire    [ 27: 0] cpu_data_master_address;
  wire    [ 27: 0] cpu_data_master_address_to_slave;
  wire    [  3: 0] cpu_data_master_byteenable;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u1_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_u2_s1;
  wire    [  1: 0] cpu_data_master_dbs_address;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire             cpu_data_master_debugaccess;
  wire             cpu_data_master_granted_SEG7_s1;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_granted_lcd_control_slave;
  wire             cpu_data_master_granted_nios_ii_clock_0_in;
  wire             cpu_data_master_granted_onchip_mem_s1;
  wire             cpu_data_master_granted_pio_button_s1;
  wire             cpu_data_master_granted_pio_green_led_s1;
  wire             cpu_data_master_granted_pio_red_led_s1;
  wire             cpu_data_master_granted_pio_switch_s1;
  wire             cpu_data_master_granted_sdram_u1_s1;
  wire             cpu_data_master_granted_sdram_u2_s1;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_granted_timer_s1;
  wire             cpu_data_master_granted_timer_stamp_s1;
  wire             cpu_data_master_granted_uart_s1;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_latency_counter;
  wire             cpu_data_master_qualified_request_SEG7_s1;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_lcd_control_slave;
  wire             cpu_data_master_qualified_request_nios_ii_clock_0_in;
  wire             cpu_data_master_qualified_request_onchip_mem_s1;
  wire             cpu_data_master_qualified_request_pio_button_s1;
  wire             cpu_data_master_qualified_request_pio_green_led_s1;
  wire             cpu_data_master_qualified_request_pio_red_led_s1;
  wire             cpu_data_master_qualified_request_pio_switch_s1;
  wire             cpu_data_master_qualified_request_sdram_u1_s1;
  wire             cpu_data_master_qualified_request_sdram_u2_s1;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_qualified_request_timer_s1;
  wire             cpu_data_master_qualified_request_timer_stamp_s1;
  wire             cpu_data_master_qualified_request_uart_s1;
  wire             cpu_data_master_read;
  wire             cpu_data_master_read_data_valid_SEG7_s1;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_lcd_control_slave;
  wire             cpu_data_master_read_data_valid_nios_ii_clock_0_in;
  wire             cpu_data_master_read_data_valid_onchip_mem_s1;
  wire             cpu_data_master_read_data_valid_pio_button_s1;
  wire             cpu_data_master_read_data_valid_pio_green_led_s1;
  wire             cpu_data_master_read_data_valid_pio_red_led_s1;
  wire             cpu_data_master_read_data_valid_pio_switch_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1;
  wire             cpu_data_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1;
  wire             cpu_data_master_read_data_valid_sdram_u2_s1_shift_register;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_timer_s1;
  wire             cpu_data_master_read_data_valid_timer_stamp_s1;
  wire             cpu_data_master_read_data_valid_uart_s1;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_readdatavalid;
  wire             cpu_data_master_requests_SEG7_s1;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_lcd_control_slave;
  wire             cpu_data_master_requests_nios_ii_clock_0_in;
  wire             cpu_data_master_requests_onchip_mem_s1;
  wire             cpu_data_master_requests_pio_button_s1;
  wire             cpu_data_master_requests_pio_green_led_s1;
  wire             cpu_data_master_requests_pio_red_led_s1;
  wire             cpu_data_master_requests_pio_switch_s1;
  wire             cpu_data_master_requests_sdram_u1_s1;
  wire             cpu_data_master_requests_sdram_u2_s1;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_requests_timer_s1;
  wire             cpu_data_master_requests_timer_stamp_s1;
  wire             cpu_data_master_requests_uart_s1;
  wire             cpu_data_master_waitrequest;
  wire             cpu_data_master_write;
  wire    [ 31: 0] cpu_data_master_writedata;
  wire    [ 27: 0] cpu_instruction_master_address;
  wire    [ 27: 0] cpu_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_instruction_master_dbs_address;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_granted_onchip_mem_s1;
  wire             cpu_instruction_master_granted_sdram_u1_s1;
  wire             cpu_instruction_master_granted_sdram_u2_s1;
  wire             cpu_instruction_master_latency_counter;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_onchip_mem_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u1_s1;
  wire             cpu_instruction_master_qualified_request_sdram_u2_s1;
  wire             cpu_instruction_master_read;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_onchip_mem_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_onchip_mem_s1;
  wire             cpu_instruction_master_requests_sdram_u1_s1;
  wire             cpu_instruction_master_requests_sdram_u2_s1;
  wire             cpu_instruction_master_waitrequest;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire             cpu_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  wire             cpu_jtag_debug_module_reset;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  wire             d1_SEG7_s1_end_xfer;
  wire             d1_cpu_jtag_debug_module_end_xfer;
  wire             d1_jtag_uart_avalon_jtag_slave_end_xfer;
  wire             d1_lcd_control_slave_end_xfer;
  wire             d1_nios_ii_clock_0_in_end_xfer;
  wire             d1_onchip_mem_s1_end_xfer;
  wire             d1_pio_button_s1_end_xfer;
  wire             d1_pio_green_led_s1_end_xfer;
  wire             d1_pio_red_led_s1_end_xfer;
  wire             d1_pio_switch_s1_end_xfer;
  wire             d1_pll_s1_end_xfer;
  wire             d1_sdram_u1_s1_end_xfer;
  wire             d1_sdram_u2_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_s1_end_xfer;
  wire             d1_timer_stamp_s1_end_xfer;
  wire             d1_uart_s1_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_irq;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  wire             jtag_uart_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [  1: 0] lcd_control_slave_address;
  wire             lcd_control_slave_begintransfer;
  wire             lcd_control_slave_read;
  wire    [  7: 0] lcd_control_slave_readdata;
  wire    [  7: 0] lcd_control_slave_readdata_from_sa;
  wire             lcd_control_slave_wait_counter_eq_0;
  wire             lcd_control_slave_write;
  wire    [  7: 0] lcd_control_slave_writedata;
  wire    [  3: 0] nios_ii_clock_0_in_address;
  wire    [  1: 0] nios_ii_clock_0_in_byteenable;
  wire             nios_ii_clock_0_in_endofpacket;
  wire             nios_ii_clock_0_in_endofpacket_from_sa;
  wire    [  2: 0] nios_ii_clock_0_in_nativeaddress;
  wire             nios_ii_clock_0_in_read;
  wire    [ 15: 0] nios_ii_clock_0_in_readdata;
  wire    [ 15: 0] nios_ii_clock_0_in_readdata_from_sa;
  wire             nios_ii_clock_0_in_reset_n;
  wire             nios_ii_clock_0_in_waitrequest;
  wire             nios_ii_clock_0_in_waitrequest_from_sa;
  wire             nios_ii_clock_0_in_write;
  wire    [ 15: 0] nios_ii_clock_0_in_writedata;
  wire    [  3: 0] nios_ii_clock_0_out_address;
  wire    [  3: 0] nios_ii_clock_0_out_address_to_slave;
  wire    [  1: 0] nios_ii_clock_0_out_byteenable;
  wire             nios_ii_clock_0_out_endofpacket;
  wire             nios_ii_clock_0_out_granted_pll_s1;
  wire    [  2: 0] nios_ii_clock_0_out_nativeaddress;
  wire             nios_ii_clock_0_out_qualified_request_pll_s1;
  wire             nios_ii_clock_0_out_read;
  wire             nios_ii_clock_0_out_read_data_valid_pll_s1;
  wire    [ 15: 0] nios_ii_clock_0_out_readdata;
  wire             nios_ii_clock_0_out_requests_pll_s1;
  wire             nios_ii_clock_0_out_reset_n;
  wire             nios_ii_clock_0_out_waitrequest;
  wire             nios_ii_clock_0_out_write;
  wire    [ 15: 0] nios_ii_clock_0_out_writedata;
  wire    [ 10: 0] onchip_mem_s1_address;
  wire    [  3: 0] onchip_mem_s1_byteenable;
  wire             onchip_mem_s1_chipselect;
  wire             onchip_mem_s1_clken;
  wire    [ 31: 0] onchip_mem_s1_readdata;
  wire    [ 31: 0] onchip_mem_s1_readdata_from_sa;
  wire             onchip_mem_s1_write;
  wire    [ 31: 0] onchip_mem_s1_writedata;
  wire             out_clk_pll_c0;
  wire             out_clk_pll_c1;
  wire             out_clk_pll_c2;
  wire    [  8: 0] out_port_from_the_pio_green_led;
  wire    [ 17: 0] out_port_from_the_pio_red_led;
  wire    [  1: 0] pio_button_s1_address;
  wire             pio_button_s1_chipselect;
  wire             pio_button_s1_irq;
  wire             pio_button_s1_irq_from_sa;
  wire    [  3: 0] pio_button_s1_readdata;
  wire    [  3: 0] pio_button_s1_readdata_from_sa;
  wire             pio_button_s1_reset_n;
  wire             pio_button_s1_write_n;
  wire    [  3: 0] pio_button_s1_writedata;
  wire    [  1: 0] pio_green_led_s1_address;
  wire             pio_green_led_s1_chipselect;
  wire             pio_green_led_s1_reset_n;
  wire             pio_green_led_s1_write_n;
  wire    [  8: 0] pio_green_led_s1_writedata;
  wire    [  1: 0] pio_red_led_s1_address;
  wire             pio_red_led_s1_chipselect;
  wire             pio_red_led_s1_reset_n;
  wire             pio_red_led_s1_write_n;
  wire    [ 17: 0] pio_red_led_s1_writedata;
  wire    [  1: 0] pio_switch_s1_address;
  wire    [ 17: 0] pio_switch_s1_readdata;
  wire    [ 17: 0] pio_switch_s1_readdata_from_sa;
  wire             pio_switch_s1_reset_n;
  wire             pll_c0_system;
  wire             pll_c0_system_reset_n;
  wire             pll_c1_memory;
  wire             pll_c2_audio;
  wire    [  2: 0] pll_s1_address;
  wire             pll_s1_chipselect;
  wire             pll_s1_read;
  wire    [ 15: 0] pll_s1_readdata;
  wire    [ 15: 0] pll_s1_readdata_from_sa;
  wire             pll_s1_reset_n;
  wire             pll_s1_resetrequest;
  wire             pll_s1_resetrequest_from_sa;
  wire             pll_s1_write;
  wire    [ 15: 0] pll_s1_writedata;
  wire             reset_n_sources;
  wire             rts_n_from_the_uart;
  wire    [ 23: 0] sdram_u1_s1_address;
  wire    [  1: 0] sdram_u1_s1_byteenable_n;
  wire             sdram_u1_s1_chipselect;
  wire             sdram_u1_s1_read_n;
  wire    [ 15: 0] sdram_u1_s1_readdata;
  wire    [ 15: 0] sdram_u1_s1_readdata_from_sa;
  wire             sdram_u1_s1_readdatavalid;
  wire             sdram_u1_s1_reset_n;
  wire             sdram_u1_s1_waitrequest;
  wire             sdram_u1_s1_waitrequest_from_sa;
  wire             sdram_u1_s1_write_n;
  wire    [ 15: 0] sdram_u1_s1_writedata;
  wire    [ 23: 0] sdram_u2_s1_address;
  wire    [  1: 0] sdram_u2_s1_byteenable_n;
  wire             sdram_u2_s1_chipselect;
  wire             sdram_u2_s1_read_n;
  wire    [ 15: 0] sdram_u2_s1_readdata;
  wire    [ 15: 0] sdram_u2_s1_readdata_from_sa;
  wire             sdram_u2_s1_readdatavalid;
  wire             sdram_u2_s1_reset_n;
  wire             sdram_u2_s1_waitrequest;
  wire             sdram_u2_s1_waitrequest_from_sa;
  wire             sdram_u2_s1_write_n;
  wire    [ 15: 0] sdram_u2_s1_writedata;
  wire             sysid_control_slave_address;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire    [  2: 0] timer_s1_address;
  wire             timer_s1_chipselect;
  wire             timer_s1_irq;
  wire             timer_s1_irq_from_sa;
  wire    [ 15: 0] timer_s1_readdata;
  wire    [ 15: 0] timer_s1_readdata_from_sa;
  wire             timer_s1_reset_n;
  wire             timer_s1_write_n;
  wire    [ 15: 0] timer_s1_writedata;
  wire    [  2: 0] timer_stamp_s1_address;
  wire             timer_stamp_s1_chipselect;
  wire             timer_stamp_s1_irq;
  wire             timer_stamp_s1_irq_from_sa;
  wire    [ 15: 0] timer_stamp_s1_readdata;
  wire    [ 15: 0] timer_stamp_s1_readdata_from_sa;
  wire             timer_stamp_s1_reset_n;
  wire             timer_stamp_s1_write_n;
  wire    [ 15: 0] timer_stamp_s1_writedata;
  wire             txd_from_the_uart;
  wire    [  2: 0] uart_s1_address;
  wire             uart_s1_begintransfer;
  wire             uart_s1_chipselect;
  wire             uart_s1_dataavailable;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_irq;
  wire             uart_s1_irq_from_sa;
  wire             uart_s1_read_n;
  wire    [ 15: 0] uart_s1_readdata;
  wire    [ 15: 0] uart_s1_readdata_from_sa;
  wire             uart_s1_readyfordata;
  wire             uart_s1_readyfordata_from_sa;
  wire             uart_s1_reset_n;
  wire             uart_s1_write_n;
  wire    [ 15: 0] uart_s1_writedata;
  wire    [ 12: 0] zs_addr_from_the_sdram_u1;
  wire    [ 12: 0] zs_addr_from_the_sdram_u2;
  wire    [  1: 0] zs_ba_from_the_sdram_u1;
  wire    [  1: 0] zs_ba_from_the_sdram_u2;
  wire             zs_cas_n_from_the_sdram_u1;
  wire             zs_cas_n_from_the_sdram_u2;
  wire             zs_cke_from_the_sdram_u1;
  wire             zs_cke_from_the_sdram_u2;
  wire             zs_cs_n_from_the_sdram_u1;
  wire             zs_cs_n_from_the_sdram_u2;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  wire    [  1: 0] zs_dqm_from_the_sdram_u1;
  wire    [  1: 0] zs_dqm_from_the_sdram_u2;
  wire             zs_ras_n_from_the_sdram_u1;
  wire             zs_ras_n_from_the_sdram_u2;
  wire             zs_we_n_from_the_sdram_u1;
  wire             zs_we_n_from_the_sdram_u2;
  SEG7_s1_arbitrator the_SEG7_s1
    (
      .SEG7_s1_address                                            (SEG7_s1_address),
      .SEG7_s1_read                                               (SEG7_s1_read),
      .SEG7_s1_readdata                                           (SEG7_s1_readdata),
      .SEG7_s1_readdata_from_sa                                   (SEG7_s1_readdata_from_sa),
      .SEG7_s1_reset                                              (SEG7_s1_reset),
      .SEG7_s1_write                                              (SEG7_s1_write),
      .SEG7_s1_writedata                                          (SEG7_s1_writedata),
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_SEG7_s1                            (cpu_data_master_granted_SEG7_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_SEG7_s1                  (cpu_data_master_qualified_request_SEG7_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_SEG7_s1                    (cpu_data_master_read_data_valid_SEG7_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_SEG7_s1                           (cpu_data_master_requests_SEG7_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_SEG7_s1_end_xfer                                        (d1_SEG7_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  SEG7 the_SEG7
    (
      .avs_s1_address     (SEG7_s1_address),
      .avs_s1_clk         (pll_c0_system),
      .avs_s1_export_seg7 (avs_s1_export_seg7_from_the_SEG7),
      .avs_s1_read        (SEG7_s1_read),
      .avs_s1_readdata    (SEG7_s1_readdata),
      .avs_s1_reset       (SEG7_s1_reset),
      .avs_s1_write       (SEG7_s1_write),
      .avs_s1_writedata   (SEG7_s1_writedata)
    );

  cpu_jtag_debug_module_arbitrator the_cpu_jtag_debug_module
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_debugaccess                                       (cpu_data_master_debugaccess),
      .cpu_data_master_granted_cpu_jtag_debug_module                     (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module           (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module             (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_cpu_jtag_debug_module                    (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_data_master_writedata                                         (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_cpu_jtag_debug_module              (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module    (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module      (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_cpu_jtag_debug_module             (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_jtag_debug_module_address                                     (cpu_jtag_debug_module_address),
      .cpu_jtag_debug_module_begintransfer                               (cpu_jtag_debug_module_begintransfer),
      .cpu_jtag_debug_module_byteenable                                  (cpu_jtag_debug_module_byteenable),
      .cpu_jtag_debug_module_chipselect                                  (cpu_jtag_debug_module_chipselect),
      .cpu_jtag_debug_module_debugaccess                                 (cpu_jtag_debug_module_debugaccess),
      .cpu_jtag_debug_module_readdata                                    (cpu_jtag_debug_module_readdata),
      .cpu_jtag_debug_module_readdata_from_sa                            (cpu_jtag_debug_module_readdata_from_sa),
      .cpu_jtag_debug_module_reset                                       (cpu_jtag_debug_module_reset),
      .cpu_jtag_debug_module_reset_n                                     (cpu_jtag_debug_module_reset_n),
      .cpu_jtag_debug_module_resetrequest                                (cpu_jtag_debug_module_resetrequest),
      .cpu_jtag_debug_module_resetrequest_from_sa                        (cpu_jtag_debug_module_resetrequest_from_sa),
      .cpu_jtag_debug_module_write                                       (cpu_jtag_debug_module_write),
      .cpu_jtag_debug_module_writedata                                   (cpu_jtag_debug_module_writedata),
      .d1_cpu_jtag_debug_module_end_xfer                                 (d1_cpu_jtag_debug_module_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n)
    );

  cpu_data_master_arbitrator the_cpu_data_master
    (
      .SEG7_s1_readdata_from_sa                                      (SEG7_s1_readdata_from_sa),
      .clk                                                           (pll_c0_system),
      .cpu_data_master_address                                       (cpu_data_master_address),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable_sdram_u1_s1                        (cpu_data_master_byteenable_sdram_u1_s1),
      .cpu_data_master_byteenable_sdram_u2_s1                        (cpu_data_master_byteenable_sdram_u2_s1),
      .cpu_data_master_dbs_address                                   (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                  (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_SEG7_s1                               (cpu_data_master_granted_SEG7_s1),
      .cpu_data_master_granted_cpu_jtag_debug_module                 (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_granted_lcd_control_slave                     (cpu_data_master_granted_lcd_control_slave),
      .cpu_data_master_granted_nios_ii_clock_0_in                    (cpu_data_master_granted_nios_ii_clock_0_in),
      .cpu_data_master_granted_onchip_mem_s1                         (cpu_data_master_granted_onchip_mem_s1),
      .cpu_data_master_granted_pio_button_s1                         (cpu_data_master_granted_pio_button_s1),
      .cpu_data_master_granted_pio_green_led_s1                      (cpu_data_master_granted_pio_green_led_s1),
      .cpu_data_master_granted_pio_red_led_s1                        (cpu_data_master_granted_pio_red_led_s1),
      .cpu_data_master_granted_pio_switch_s1                         (cpu_data_master_granted_pio_switch_s1),
      .cpu_data_master_granted_sdram_u1_s1                           (cpu_data_master_granted_sdram_u1_s1),
      .cpu_data_master_granted_sdram_u2_s1                           (cpu_data_master_granted_sdram_u2_s1),
      .cpu_data_master_granted_sysid_control_slave                   (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_granted_timer_s1                              (cpu_data_master_granted_timer_s1),
      .cpu_data_master_granted_timer_stamp_s1                        (cpu_data_master_granted_timer_stamp_s1),
      .cpu_data_master_granted_uart_s1                               (cpu_data_master_granted_uart_s1),
      .cpu_data_master_irq                                           (cpu_data_master_irq),
      .cpu_data_master_latency_counter                               (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_SEG7_s1                     (cpu_data_master_qualified_request_SEG7_s1),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module       (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_lcd_control_slave           (cpu_data_master_qualified_request_lcd_control_slave),
      .cpu_data_master_qualified_request_nios_ii_clock_0_in          (cpu_data_master_qualified_request_nios_ii_clock_0_in),
      .cpu_data_master_qualified_request_onchip_mem_s1               (cpu_data_master_qualified_request_onchip_mem_s1),
      .cpu_data_master_qualified_request_pio_button_s1               (cpu_data_master_qualified_request_pio_button_s1),
      .cpu_data_master_qualified_request_pio_green_led_s1            (cpu_data_master_qualified_request_pio_green_led_s1),
      .cpu_data_master_qualified_request_pio_red_led_s1              (cpu_data_master_qualified_request_pio_red_led_s1),
      .cpu_data_master_qualified_request_pio_switch_s1               (cpu_data_master_qualified_request_pio_switch_s1),
      .cpu_data_master_qualified_request_sdram_u1_s1                 (cpu_data_master_qualified_request_sdram_u1_s1),
      .cpu_data_master_qualified_request_sdram_u2_s1                 (cpu_data_master_qualified_request_sdram_u2_s1),
      .cpu_data_master_qualified_request_sysid_control_slave         (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_qualified_request_timer_s1                    (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_qualified_request_timer_stamp_s1              (cpu_data_master_qualified_request_timer_stamp_s1),
      .cpu_data_master_qualified_request_uart_s1                     (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_SEG7_s1                       (cpu_data_master_read_data_valid_SEG7_s1),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module         (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_lcd_control_slave             (cpu_data_master_read_data_valid_lcd_control_slave),
      .cpu_data_master_read_data_valid_nios_ii_clock_0_in            (cpu_data_master_read_data_valid_nios_ii_clock_0_in),
      .cpu_data_master_read_data_valid_onchip_mem_s1                 (cpu_data_master_read_data_valid_onchip_mem_s1),
      .cpu_data_master_read_data_valid_pio_button_s1                 (cpu_data_master_read_data_valid_pio_button_s1),
      .cpu_data_master_read_data_valid_pio_green_led_s1              (cpu_data_master_read_data_valid_pio_green_led_s1),
      .cpu_data_master_read_data_valid_pio_red_led_s1                (cpu_data_master_read_data_valid_pio_red_led_s1),
      .cpu_data_master_read_data_valid_pio_switch_s1                 (cpu_data_master_read_data_valid_pio_switch_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1                   (cpu_data_master_read_data_valid_sdram_u1_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1                   (cpu_data_master_read_data_valid_sdram_u2_s1),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_sysid_control_slave           (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_read_data_valid_timer_s1                      (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_read_data_valid_timer_stamp_s1                (cpu_data_master_read_data_valid_timer_stamp_s1),
      .cpu_data_master_read_data_valid_uart_s1                       (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_readdata                                      (cpu_data_master_readdata),
      .cpu_data_master_readdatavalid                                 (cpu_data_master_readdatavalid),
      .cpu_data_master_requests_SEG7_s1                              (cpu_data_master_requests_SEG7_s1),
      .cpu_data_master_requests_cpu_jtag_debug_module                (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_lcd_control_slave                    (cpu_data_master_requests_lcd_control_slave),
      .cpu_data_master_requests_nios_ii_clock_0_in                   (cpu_data_master_requests_nios_ii_clock_0_in),
      .cpu_data_master_requests_onchip_mem_s1                        (cpu_data_master_requests_onchip_mem_s1),
      .cpu_data_master_requests_pio_button_s1                        (cpu_data_master_requests_pio_button_s1),
      .cpu_data_master_requests_pio_green_led_s1                     (cpu_data_master_requests_pio_green_led_s1),
      .cpu_data_master_requests_pio_red_led_s1                       (cpu_data_master_requests_pio_red_led_s1),
      .cpu_data_master_requests_pio_switch_s1                        (cpu_data_master_requests_pio_switch_s1),
      .cpu_data_master_requests_sdram_u1_s1                          (cpu_data_master_requests_sdram_u1_s1),
      .cpu_data_master_requests_sdram_u2_s1                          (cpu_data_master_requests_sdram_u2_s1),
      .cpu_data_master_requests_sysid_control_slave                  (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_requests_timer_s1                             (cpu_data_master_requests_timer_s1),
      .cpu_data_master_requests_timer_stamp_s1                       (cpu_data_master_requests_timer_stamp_s1),
      .cpu_data_master_requests_uart_s1                              (cpu_data_master_requests_uart_s1),
      .cpu_data_master_waitrequest                                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .cpu_jtag_debug_module_readdata_from_sa                        (cpu_jtag_debug_module_readdata_from_sa),
      .d1_SEG7_s1_end_xfer                                           (d1_SEG7_s1_end_xfer),
      .d1_cpu_jtag_debug_module_end_xfer                             (d1_cpu_jtag_debug_module_end_xfer),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .d1_lcd_control_slave_end_xfer                                 (d1_lcd_control_slave_end_xfer),
      .d1_nios_ii_clock_0_in_end_xfer                                (d1_nios_ii_clock_0_in_end_xfer),
      .d1_onchip_mem_s1_end_xfer                                     (d1_onchip_mem_s1_end_xfer),
      .d1_pio_button_s1_end_xfer                                     (d1_pio_button_s1_end_xfer),
      .d1_pio_green_led_s1_end_xfer                                  (d1_pio_green_led_s1_end_xfer),
      .d1_pio_red_led_s1_end_xfer                                    (d1_pio_red_led_s1_end_xfer),
      .d1_pio_switch_s1_end_xfer                                     (d1_pio_switch_s1_end_xfer),
      .d1_sdram_u1_s1_end_xfer                                       (d1_sdram_u1_s1_end_xfer),
      .d1_sdram_u2_s1_end_xfer                                       (d1_sdram_u2_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                               (d1_sysid_control_slave_end_xfer),
      .d1_timer_s1_end_xfer                                          (d1_timer_s1_end_xfer),
      .d1_timer_stamp_s1_end_xfer                                    (d1_timer_stamp_s1_end_xfer),
      .d1_uart_s1_end_xfer                                           (d1_uart_s1_end_xfer),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .lcd_control_slave_readdata_from_sa                            (lcd_control_slave_readdata_from_sa),
      .lcd_control_slave_wait_counter_eq_0                           (lcd_control_slave_wait_counter_eq_0),
      .nios_ii_clock_0_in_readdata_from_sa                           (nios_ii_clock_0_in_readdata_from_sa),
      .nios_ii_clock_0_in_waitrequest_from_sa                        (nios_ii_clock_0_in_waitrequest_from_sa),
      .onchip_mem_s1_readdata_from_sa                                (onchip_mem_s1_readdata_from_sa),
      .pio_button_s1_irq_from_sa                                     (pio_button_s1_irq_from_sa),
      .pio_button_s1_readdata_from_sa                                (pio_button_s1_readdata_from_sa),
      .pio_switch_s1_readdata_from_sa                                (pio_switch_s1_readdata_from_sa),
      .reset_n                                                       (pll_c0_system_reset_n),
      .sdram_u1_s1_readdata_from_sa                                  (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_waitrequest_from_sa                               (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u2_s1_readdata_from_sa                                  (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_waitrequest_from_sa                               (sdram_u2_s1_waitrequest_from_sa),
      .sysid_control_slave_readdata_from_sa                          (sysid_control_slave_readdata_from_sa),
      .timer_s1_irq_from_sa                                          (timer_s1_irq_from_sa),
      .timer_s1_readdata_from_sa                                     (timer_s1_readdata_from_sa),
      .timer_stamp_s1_irq_from_sa                                    (timer_stamp_s1_irq_from_sa),
      .timer_stamp_s1_readdata_from_sa                               (timer_stamp_s1_readdata_from_sa),
      .uart_s1_irq_from_sa                                           (uart_s1_irq_from_sa),
      .uart_s1_readdata_from_sa                                      (uart_s1_readdata_from_sa)
    );

  cpu_instruction_master_arbitrator the_cpu_instruction_master
    (
      .clk                                                               (pll_c0_system),
      .cpu_instruction_master_address                                    (cpu_instruction_master_address),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cpu_jtag_debug_module              (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_granted_onchip_mem_s1                      (cpu_instruction_master_granted_onchip_mem_s1),
      .cpu_instruction_master_granted_sdram_u1_s1                        (cpu_instruction_master_granted_sdram_u1_s1),
      .cpu_instruction_master_granted_sdram_u2_s1                        (cpu_instruction_master_granted_sdram_u2_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module    (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_qualified_request_onchip_mem_s1            (cpu_instruction_master_qualified_request_onchip_mem_s1),
      .cpu_instruction_master_qualified_request_sdram_u1_s1              (cpu_instruction_master_qualified_request_sdram_u1_s1),
      .cpu_instruction_master_qualified_request_sdram_u2_s1              (cpu_instruction_master_qualified_request_sdram_u2_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module      (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_onchip_mem_s1              (cpu_instruction_master_read_data_valid_onchip_mem_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1                (cpu_instruction_master_read_data_valid_sdram_u1_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1                (cpu_instruction_master_read_data_valid_sdram_u2_s1),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_readdata                                   (cpu_instruction_master_readdata),
      .cpu_instruction_master_readdatavalid                              (cpu_instruction_master_readdatavalid),
      .cpu_instruction_master_requests_cpu_jtag_debug_module             (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_instruction_master_requests_onchip_mem_s1                     (cpu_instruction_master_requests_onchip_mem_s1),
      .cpu_instruction_master_requests_sdram_u1_s1                       (cpu_instruction_master_requests_sdram_u1_s1),
      .cpu_instruction_master_requests_sdram_u2_s1                       (cpu_instruction_master_requests_sdram_u2_s1),
      .cpu_instruction_master_waitrequest                                (cpu_instruction_master_waitrequest),
      .cpu_jtag_debug_module_readdata_from_sa                            (cpu_jtag_debug_module_readdata_from_sa),
      .d1_cpu_jtag_debug_module_end_xfer                                 (d1_cpu_jtag_debug_module_end_xfer),
      .d1_onchip_mem_s1_end_xfer                                         (d1_onchip_mem_s1_end_xfer),
      .d1_sdram_u1_s1_end_xfer                                           (d1_sdram_u1_s1_end_xfer),
      .d1_sdram_u2_s1_end_xfer                                           (d1_sdram_u2_s1_end_xfer),
      .onchip_mem_s1_readdata_from_sa                                    (onchip_mem_s1_readdata_from_sa),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u1_s1_readdata_from_sa                                      (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_waitrequest_from_sa                                   (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u2_s1_readdata_from_sa                                      (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_waitrequest_from_sa                                   (sdram_u2_s1_waitrequest_from_sa)
    );

  cpu the_cpu
    (
      .clk                                   (pll_c0_system),
      .d_address                             (cpu_data_master_address),
      .d_byteenable                          (cpu_data_master_byteenable),
      .d_irq                                 (cpu_data_master_irq),
      .d_read                                (cpu_data_master_read),
      .d_readdata                            (cpu_data_master_readdata),
      .d_readdatavalid                       (cpu_data_master_readdatavalid),
      .d_waitrequest                         (cpu_data_master_waitrequest),
      .d_write                               (cpu_data_master_write),
      .d_writedata                           (cpu_data_master_writedata),
      .i_address                             (cpu_instruction_master_address),
      .i_read                                (cpu_instruction_master_read),
      .i_readdata                            (cpu_instruction_master_readdata),
      .i_readdatavalid                       (cpu_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_jtag_debug_module_byteenable),
      .jtag_debug_module_clk                 (pll_c0_system),
      .jtag_debug_module_debugaccess         (cpu_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_jtag_debug_module_readdata),
      .jtag_debug_module_reset               (cpu_jtag_debug_module_reset),
      .jtag_debug_module_resetrequest        (cpu_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_jtag_debug_module_writedata),
      .reset_n                               (cpu_jtag_debug_module_reset_n)
    );

  jtag_uart_avalon_jtag_slave_arbitrator the_jtag_uart_avalon_jtag_slave
    (
      .clk                                                           (pll_c0_system),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_latency_counter                               (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register    (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .jtag_uart_avalon_jtag_slave_address                           (jtag_uart_avalon_jtag_slave_address),
      .jtag_uart_avalon_jtag_slave_chipselect                        (jtag_uart_avalon_jtag_slave_chipselect),
      .jtag_uart_avalon_jtag_slave_dataavailable                     (jtag_uart_avalon_jtag_slave_dataavailable),
      .jtag_uart_avalon_jtag_slave_dataavailable_from_sa             (jtag_uart_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_avalon_jtag_slave_irq                               (jtag_uart_avalon_jtag_slave_irq),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_read_n                            (jtag_uart_avalon_jtag_slave_read_n),
      .jtag_uart_avalon_jtag_slave_readdata                          (jtag_uart_avalon_jtag_slave_readdata),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_readyfordata                      (jtag_uart_avalon_jtag_slave_readyfordata),
      .jtag_uart_avalon_jtag_slave_readyfordata_from_sa              (jtag_uart_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_avalon_jtag_slave_reset_n                           (jtag_uart_avalon_jtag_slave_reset_n),
      .jtag_uart_avalon_jtag_slave_waitrequest                       (jtag_uart_avalon_jtag_slave_waitrequest),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_avalon_jtag_slave_write_n                           (jtag_uart_avalon_jtag_slave_write_n),
      .jtag_uart_avalon_jtag_slave_writedata                         (jtag_uart_avalon_jtag_slave_writedata),
      .reset_n                                                       (pll_c0_system_reset_n)
    );

  jtag_uart the_jtag_uart
    (
      .av_address     (jtag_uart_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_avalon_jtag_slave_writedata),
      .clk            (pll_c0_system),
      .dataavailable  (jtag_uart_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_avalon_jtag_slave_reset_n)
    );

  lcd_control_slave_arbitrator the_lcd_control_slave
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_lcd_control_slave                  (cpu_data_master_granted_lcd_control_slave),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_lcd_control_slave        (cpu_data_master_qualified_request_lcd_control_slave),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_lcd_control_slave          (cpu_data_master_read_data_valid_lcd_control_slave),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_lcd_control_slave                 (cpu_data_master_requests_lcd_control_slave),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_lcd_control_slave_end_xfer                              (d1_lcd_control_slave_end_xfer),
      .lcd_control_slave_address                                  (lcd_control_slave_address),
      .lcd_control_slave_begintransfer                            (lcd_control_slave_begintransfer),
      .lcd_control_slave_read                                     (lcd_control_slave_read),
      .lcd_control_slave_readdata                                 (lcd_control_slave_readdata),
      .lcd_control_slave_readdata_from_sa                         (lcd_control_slave_readdata_from_sa),
      .lcd_control_slave_wait_counter_eq_0                        (lcd_control_slave_wait_counter_eq_0),
      .lcd_control_slave_write                                    (lcd_control_slave_write),
      .lcd_control_slave_writedata                                (lcd_control_slave_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  lcd the_lcd
    (
      .LCD_E         (LCD_E_from_the_lcd),
      .LCD_RS        (LCD_RS_from_the_lcd),
      .LCD_RW        (LCD_RW_from_the_lcd),
      .LCD_data      (LCD_data_to_and_from_the_lcd),
      .address       (lcd_control_slave_address),
      .begintransfer (lcd_control_slave_begintransfer),
      .read          (lcd_control_slave_read),
      .readdata      (lcd_control_slave_readdata),
      .write         (lcd_control_slave_write),
      .writedata     (lcd_control_slave_writedata)
    );

  nios_ii_clock_0_in_arbitrator the_nios_ii_clock_0_in
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                 (cpu_data_master_byteenable),
      .cpu_data_master_granted_nios_ii_clock_0_in                 (cpu_data_master_granted_nios_ii_clock_0_in),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_nios_ii_clock_0_in       (cpu_data_master_qualified_request_nios_ii_clock_0_in),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_nios_ii_clock_0_in         (cpu_data_master_read_data_valid_nios_ii_clock_0_in),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_nios_ii_clock_0_in                (cpu_data_master_requests_nios_ii_clock_0_in),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_nios_ii_clock_0_in_end_xfer                             (d1_nios_ii_clock_0_in_end_xfer),
      .nios_ii_clock_0_in_address                                 (nios_ii_clock_0_in_address),
      .nios_ii_clock_0_in_byteenable                              (nios_ii_clock_0_in_byteenable),
      .nios_ii_clock_0_in_endofpacket                             (nios_ii_clock_0_in_endofpacket),
      .nios_ii_clock_0_in_endofpacket_from_sa                     (nios_ii_clock_0_in_endofpacket_from_sa),
      .nios_ii_clock_0_in_nativeaddress                           (nios_ii_clock_0_in_nativeaddress),
      .nios_ii_clock_0_in_read                                    (nios_ii_clock_0_in_read),
      .nios_ii_clock_0_in_readdata                                (nios_ii_clock_0_in_readdata),
      .nios_ii_clock_0_in_readdata_from_sa                        (nios_ii_clock_0_in_readdata_from_sa),
      .nios_ii_clock_0_in_reset_n                                 (nios_ii_clock_0_in_reset_n),
      .nios_ii_clock_0_in_waitrequest                             (nios_ii_clock_0_in_waitrequest),
      .nios_ii_clock_0_in_waitrequest_from_sa                     (nios_ii_clock_0_in_waitrequest_from_sa),
      .nios_ii_clock_0_in_write                                   (nios_ii_clock_0_in_write),
      .nios_ii_clock_0_in_writedata                               (nios_ii_clock_0_in_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  nios_ii_clock_0_out_arbitrator the_nios_ii_clock_0_out
    (
      .clk                                          (clk_50),
      .d1_pll_s1_end_xfer                           (d1_pll_s1_end_xfer),
      .nios_ii_clock_0_out_address                  (nios_ii_clock_0_out_address),
      .nios_ii_clock_0_out_address_to_slave         (nios_ii_clock_0_out_address_to_slave),
      .nios_ii_clock_0_out_granted_pll_s1           (nios_ii_clock_0_out_granted_pll_s1),
      .nios_ii_clock_0_out_qualified_request_pll_s1 (nios_ii_clock_0_out_qualified_request_pll_s1),
      .nios_ii_clock_0_out_read                     (nios_ii_clock_0_out_read),
      .nios_ii_clock_0_out_read_data_valid_pll_s1   (nios_ii_clock_0_out_read_data_valid_pll_s1),
      .nios_ii_clock_0_out_readdata                 (nios_ii_clock_0_out_readdata),
      .nios_ii_clock_0_out_requests_pll_s1          (nios_ii_clock_0_out_requests_pll_s1),
      .nios_ii_clock_0_out_reset_n                  (nios_ii_clock_0_out_reset_n),
      .nios_ii_clock_0_out_waitrequest              (nios_ii_clock_0_out_waitrequest),
      .nios_ii_clock_0_out_write                    (nios_ii_clock_0_out_write),
      .nios_ii_clock_0_out_writedata                (nios_ii_clock_0_out_writedata),
      .pll_s1_readdata_from_sa                      (pll_s1_readdata_from_sa),
      .reset_n                                      (clk_50_reset_n)
    );

  nios_ii_clock_0 the_nios_ii_clock_0
    (
      .master_address       (nios_ii_clock_0_out_address),
      .master_byteenable    (nios_ii_clock_0_out_byteenable),
      .master_clk           (clk_50),
      .master_endofpacket   (nios_ii_clock_0_out_endofpacket),
      .master_nativeaddress (nios_ii_clock_0_out_nativeaddress),
      .master_read          (nios_ii_clock_0_out_read),
      .master_readdata      (nios_ii_clock_0_out_readdata),
      .master_reset_n       (nios_ii_clock_0_out_reset_n),
      .master_waitrequest   (nios_ii_clock_0_out_waitrequest),
      .master_write         (nios_ii_clock_0_out_write),
      .master_writedata     (nios_ii_clock_0_out_writedata),
      .slave_address        (nios_ii_clock_0_in_address),
      .slave_byteenable     (nios_ii_clock_0_in_byteenable),
      .slave_clk            (pll_c0_system),
      .slave_endofpacket    (nios_ii_clock_0_in_endofpacket),
      .slave_nativeaddress  (nios_ii_clock_0_in_nativeaddress),
      .slave_read           (nios_ii_clock_0_in_read),
      .slave_readdata       (nios_ii_clock_0_in_readdata),
      .slave_reset_n        (nios_ii_clock_0_in_reset_n),
      .slave_waitrequest    (nios_ii_clock_0_in_waitrequest),
      .slave_write          (nios_ii_clock_0_in_write),
      .slave_writedata      (nios_ii_clock_0_in_writedata)
    );

  onchip_mem_s1_arbitrator the_onchip_mem_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_granted_onchip_mem_s1                             (cpu_data_master_granted_onchip_mem_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_onchip_mem_s1                   (cpu_data_master_qualified_request_onchip_mem_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_onchip_mem_s1                     (cpu_data_master_read_data_valid_onchip_mem_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_onchip_mem_s1                            (cpu_data_master_requests_onchip_mem_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_data_master_writedata                                         (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_onchip_mem_s1                      (cpu_instruction_master_granted_onchip_mem_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_onchip_mem_s1            (cpu_instruction_master_qualified_request_onchip_mem_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_onchip_mem_s1              (cpu_instruction_master_read_data_valid_onchip_mem_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_onchip_mem_s1                     (cpu_instruction_master_requests_onchip_mem_s1),
      .d1_onchip_mem_s1_end_xfer                                         (d1_onchip_mem_s1_end_xfer),
      .onchip_mem_s1_address                                             (onchip_mem_s1_address),
      .onchip_mem_s1_byteenable                                          (onchip_mem_s1_byteenable),
      .onchip_mem_s1_chipselect                                          (onchip_mem_s1_chipselect),
      .onchip_mem_s1_clken                                               (onchip_mem_s1_clken),
      .onchip_mem_s1_readdata                                            (onchip_mem_s1_readdata),
      .onchip_mem_s1_readdata_from_sa                                    (onchip_mem_s1_readdata_from_sa),
      .onchip_mem_s1_write                                               (onchip_mem_s1_write),
      .onchip_mem_s1_writedata                                           (onchip_mem_s1_writedata),
      .reset_n                                                           (pll_c0_system_reset_n)
    );

  onchip_mem the_onchip_mem
    (
      .address    (onchip_mem_s1_address),
      .byteenable (onchip_mem_s1_byteenable),
      .chipselect (onchip_mem_s1_chipselect),
      .clk        (pll_c0_system),
      .clken      (onchip_mem_s1_clken),
      .readdata   (onchip_mem_s1_readdata),
      .write      (onchip_mem_s1_write),
      .writedata  (onchip_mem_s1_writedata)
    );

  pio_button_s1_arbitrator the_pio_button_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_button_s1                      (cpu_data_master_granted_pio_button_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_button_s1            (cpu_data_master_qualified_request_pio_button_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_button_s1              (cpu_data_master_read_data_valid_pio_button_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_pio_button_s1                     (cpu_data_master_requests_pio_button_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_pio_button_s1_end_xfer                                  (d1_pio_button_s1_end_xfer),
      .pio_button_s1_address                                      (pio_button_s1_address),
      .pio_button_s1_chipselect                                   (pio_button_s1_chipselect),
      .pio_button_s1_irq                                          (pio_button_s1_irq),
      .pio_button_s1_irq_from_sa                                  (pio_button_s1_irq_from_sa),
      .pio_button_s1_readdata                                     (pio_button_s1_readdata),
      .pio_button_s1_readdata_from_sa                             (pio_button_s1_readdata_from_sa),
      .pio_button_s1_reset_n                                      (pio_button_s1_reset_n),
      .pio_button_s1_write_n                                      (pio_button_s1_write_n),
      .pio_button_s1_writedata                                    (pio_button_s1_writedata),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  pio_button the_pio_button
    (
      .address    (pio_button_s1_address),
      .chipselect (pio_button_s1_chipselect),
      .clk        (pll_c0_system),
      .in_port    (in_port_to_the_pio_button),
      .irq        (pio_button_s1_irq),
      .readdata   (pio_button_s1_readdata),
      .reset_n    (pio_button_s1_reset_n),
      .write_n    (pio_button_s1_write_n),
      .writedata  (pio_button_s1_writedata)
    );

  pio_green_led_s1_arbitrator the_pio_green_led_s1
    (
      .clk                                                (pll_c0_system),
      .cpu_data_master_address_to_slave                   (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_green_led_s1           (cpu_data_master_granted_pio_green_led_s1),
      .cpu_data_master_latency_counter                    (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_green_led_s1 (cpu_data_master_qualified_request_pio_green_led_s1),
      .cpu_data_master_read                               (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_green_led_s1   (cpu_data_master_read_data_valid_pio_green_led_s1),
      .cpu_data_master_requests_pio_green_led_s1          (cpu_data_master_requests_pio_green_led_s1),
      .cpu_data_master_write                              (cpu_data_master_write),
      .cpu_data_master_writedata                          (cpu_data_master_writedata),
      .d1_pio_green_led_s1_end_xfer                       (d1_pio_green_led_s1_end_xfer),
      .pio_green_led_s1_address                           (pio_green_led_s1_address),
      .pio_green_led_s1_chipselect                        (pio_green_led_s1_chipselect),
      .pio_green_led_s1_reset_n                           (pio_green_led_s1_reset_n),
      .pio_green_led_s1_write_n                           (pio_green_led_s1_write_n),
      .pio_green_led_s1_writedata                         (pio_green_led_s1_writedata),
      .reset_n                                            (pll_c0_system_reset_n)
    );

  pio_green_led the_pio_green_led
    (
      .address    (pio_green_led_s1_address),
      .chipselect (pio_green_led_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_pio_green_led),
      .reset_n    (pio_green_led_s1_reset_n),
      .write_n    (pio_green_led_s1_write_n),
      .writedata  (pio_green_led_s1_writedata)
    );

  pio_red_led_s1_arbitrator the_pio_red_led_s1
    (
      .clk                                              (pll_c0_system),
      .cpu_data_master_address_to_slave                 (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_red_led_s1           (cpu_data_master_granted_pio_red_led_s1),
      .cpu_data_master_latency_counter                  (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_red_led_s1 (cpu_data_master_qualified_request_pio_red_led_s1),
      .cpu_data_master_read                             (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_red_led_s1   (cpu_data_master_read_data_valid_pio_red_led_s1),
      .cpu_data_master_requests_pio_red_led_s1          (cpu_data_master_requests_pio_red_led_s1),
      .cpu_data_master_write                            (cpu_data_master_write),
      .cpu_data_master_writedata                        (cpu_data_master_writedata),
      .d1_pio_red_led_s1_end_xfer                       (d1_pio_red_led_s1_end_xfer),
      .pio_red_led_s1_address                           (pio_red_led_s1_address),
      .pio_red_led_s1_chipselect                        (pio_red_led_s1_chipselect),
      .pio_red_led_s1_reset_n                           (pio_red_led_s1_reset_n),
      .pio_red_led_s1_write_n                           (pio_red_led_s1_write_n),
      .pio_red_led_s1_writedata                         (pio_red_led_s1_writedata),
      .reset_n                                          (pll_c0_system_reset_n)
    );

  pio_red_led the_pio_red_led
    (
      .address    (pio_red_led_s1_address),
      .chipselect (pio_red_led_s1_chipselect),
      .clk        (pll_c0_system),
      .out_port   (out_port_from_the_pio_red_led),
      .reset_n    (pio_red_led_s1_reset_n),
      .write_n    (pio_red_led_s1_write_n),
      .writedata  (pio_red_led_s1_writedata)
    );

  pio_switch_s1_arbitrator the_pio_switch_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_switch_s1                      (cpu_data_master_granted_pio_switch_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_pio_switch_s1            (cpu_data_master_qualified_request_pio_switch_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_switch_s1              (cpu_data_master_read_data_valid_pio_switch_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_pio_switch_s1                     (cpu_data_master_requests_pio_switch_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .d1_pio_switch_s1_end_xfer                                  (d1_pio_switch_s1_end_xfer),
      .pio_switch_s1_address                                      (pio_switch_s1_address),
      .pio_switch_s1_readdata                                     (pio_switch_s1_readdata),
      .pio_switch_s1_readdata_from_sa                             (pio_switch_s1_readdata_from_sa),
      .pio_switch_s1_reset_n                                      (pio_switch_s1_reset_n),
      .reset_n                                                    (pll_c0_system_reset_n)
    );

  pio_switch the_pio_switch
    (
      .address  (pio_switch_s1_address),
      .clk      (pll_c0_system),
      .in_port  (in_port_to_the_pio_switch),
      .readdata (pio_switch_s1_readdata),
      .reset_n  (pio_switch_s1_reset_n)
    );

  pll_s1_arbitrator the_pll_s1
    (
      .clk                                          (clk_50),
      .d1_pll_s1_end_xfer                           (d1_pll_s1_end_xfer),
      .nios_ii_clock_0_out_address_to_slave         (nios_ii_clock_0_out_address_to_slave),
      .nios_ii_clock_0_out_granted_pll_s1           (nios_ii_clock_0_out_granted_pll_s1),
      .nios_ii_clock_0_out_nativeaddress            (nios_ii_clock_0_out_nativeaddress),
      .nios_ii_clock_0_out_qualified_request_pll_s1 (nios_ii_clock_0_out_qualified_request_pll_s1),
      .nios_ii_clock_0_out_read                     (nios_ii_clock_0_out_read),
      .nios_ii_clock_0_out_read_data_valid_pll_s1   (nios_ii_clock_0_out_read_data_valid_pll_s1),
      .nios_ii_clock_0_out_requests_pll_s1          (nios_ii_clock_0_out_requests_pll_s1),
      .nios_ii_clock_0_out_write                    (nios_ii_clock_0_out_write),
      .nios_ii_clock_0_out_writedata                (nios_ii_clock_0_out_writedata),
      .pll_s1_address                               (pll_s1_address),
      .pll_s1_chipselect                            (pll_s1_chipselect),
      .pll_s1_read                                  (pll_s1_read),
      .pll_s1_readdata                              (pll_s1_readdata),
      .pll_s1_readdata_from_sa                      (pll_s1_readdata_from_sa),
      .pll_s1_reset_n                               (pll_s1_reset_n),
      .pll_s1_resetrequest                          (pll_s1_resetrequest),
      .pll_s1_resetrequest_from_sa                  (pll_s1_resetrequest_from_sa),
      .pll_s1_write                                 (pll_s1_write),
      .pll_s1_writedata                             (pll_s1_writedata),
      .reset_n                                      (clk_50_reset_n)
    );

  //pll_c0_system out_clk assignment, which is an e_assign
  assign pll_c0_system = out_clk_pll_c0;

  //pll_c1_memory out_clk assignment, which is an e_assign
  assign pll_c1_memory = out_clk_pll_c1;

  //pll_c2_audio out_clk assignment, which is an e_assign
  assign pll_c2_audio = out_clk_pll_c2;

  pll the_pll
    (
      .address      (pll_s1_address),
      .c0           (out_clk_pll_c0),
      .c1           (out_clk_pll_c1),
      .c2           (out_clk_pll_c2),
      .chipselect   (pll_s1_chipselect),
      .clk          (clk_50),
      .read         (pll_s1_read),
      .readdata     (pll_s1_readdata),
      .reset_n      (pll_s1_reset_n),
      .resetrequest (pll_s1_resetrequest),
      .write        (pll_s1_write),
      .writedata    (pll_s1_writedata)
    );

  sdram_u1_s1_arbitrator the_sdram_u1_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_u1_s1                            (cpu_data_master_byteenable_sdram_u1_s1),
      .cpu_data_master_dbs_address                                       (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                      (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_u1_s1                               (cpu_data_master_granted_sdram_u1_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sdram_u1_s1                     (cpu_data_master_qualified_request_sdram_u1_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1                       (cpu_data_master_read_data_valid_sdram_u1_s1),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sdram_u1_s1                              (cpu_data_master_requests_sdram_u1_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_u1_s1                        (cpu_instruction_master_granted_sdram_u1_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_u1_s1              (cpu_instruction_master_qualified_request_sdram_u1_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1                (cpu_instruction_master_read_data_valid_sdram_u1_s1),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_sdram_u1_s1                       (cpu_instruction_master_requests_sdram_u1_s1),
      .d1_sdram_u1_s1_end_xfer                                           (d1_sdram_u1_s1_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u1_s1_address                                               (sdram_u1_s1_address),
      .sdram_u1_s1_byteenable_n                                          (sdram_u1_s1_byteenable_n),
      .sdram_u1_s1_chipselect                                            (sdram_u1_s1_chipselect),
      .sdram_u1_s1_read_n                                                (sdram_u1_s1_read_n),
      .sdram_u1_s1_readdata                                              (sdram_u1_s1_readdata),
      .sdram_u1_s1_readdata_from_sa                                      (sdram_u1_s1_readdata_from_sa),
      .sdram_u1_s1_readdatavalid                                         (sdram_u1_s1_readdatavalid),
      .sdram_u1_s1_reset_n                                               (sdram_u1_s1_reset_n),
      .sdram_u1_s1_waitrequest                                           (sdram_u1_s1_waitrequest),
      .sdram_u1_s1_waitrequest_from_sa                                   (sdram_u1_s1_waitrequest_from_sa),
      .sdram_u1_s1_write_n                                               (sdram_u1_s1_write_n),
      .sdram_u1_s1_writedata                                             (sdram_u1_s1_writedata)
    );

  sdram_u1 the_sdram_u1
    (
      .az_addr        (sdram_u1_s1_address),
      .az_be_n        (sdram_u1_s1_byteenable_n),
      .az_cs          (sdram_u1_s1_chipselect),
      .az_data        (sdram_u1_s1_writedata),
      .az_rd_n        (sdram_u1_s1_read_n),
      .az_wr_n        (sdram_u1_s1_write_n),
      .clk            (pll_c0_system),
      .reset_n        (sdram_u1_s1_reset_n),
      .za_data        (sdram_u1_s1_readdata),
      .za_valid       (sdram_u1_s1_readdatavalid),
      .za_waitrequest (sdram_u1_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_u1),
      .zs_ba          (zs_ba_from_the_sdram_u1),
      .zs_cas_n       (zs_cas_n_from_the_sdram_u1),
      .zs_cke         (zs_cke_from_the_sdram_u1),
      .zs_cs_n        (zs_cs_n_from_the_sdram_u1),
      .zs_dq          (zs_dq_to_and_from_the_sdram_u1),
      .zs_dqm         (zs_dqm_from_the_sdram_u1),
      .zs_ras_n       (zs_ras_n_from_the_sdram_u1),
      .zs_we_n        (zs_we_n_from_the_sdram_u1)
    );

  sdram_u2_s1_arbitrator the_sdram_u2_s1
    (
      .clk                                                               (pll_c0_system),
      .cpu_data_master_address_to_slave                                  (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                        (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_u2_s1                            (cpu_data_master_byteenable_sdram_u2_s1),
      .cpu_data_master_dbs_address                                       (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                      (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_u2_s1                               (cpu_data_master_granted_sdram_u2_s1),
      .cpu_data_master_latency_counter                                   (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sdram_u2_s1                     (cpu_data_master_qualified_request_sdram_u2_s1),
      .cpu_data_master_read                                              (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1                       (cpu_data_master_read_data_valid_sdram_u2_s1),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register        (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_requests_sdram_u2_s1                              (cpu_data_master_requests_sdram_u2_s1),
      .cpu_data_master_write                                             (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                           (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                                (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_u2_s1                        (cpu_instruction_master_granted_sdram_u2_s1),
      .cpu_instruction_master_latency_counter                            (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_u2_s1              (cpu_instruction_master_qualified_request_sdram_u2_s1),
      .cpu_instruction_master_read                                       (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1                (cpu_instruction_master_read_data_valid_sdram_u2_s1),
      .cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_instruction_master_requests_sdram_u2_s1                       (cpu_instruction_master_requests_sdram_u2_s1),
      .d1_sdram_u2_s1_end_xfer                                           (d1_sdram_u2_s1_end_xfer),
      .reset_n                                                           (pll_c0_system_reset_n),
      .sdram_u2_s1_address                                               (sdram_u2_s1_address),
      .sdram_u2_s1_byteenable_n                                          (sdram_u2_s1_byteenable_n),
      .sdram_u2_s1_chipselect                                            (sdram_u2_s1_chipselect),
      .sdram_u2_s1_read_n                                                (sdram_u2_s1_read_n),
      .sdram_u2_s1_readdata                                              (sdram_u2_s1_readdata),
      .sdram_u2_s1_readdata_from_sa                                      (sdram_u2_s1_readdata_from_sa),
      .sdram_u2_s1_readdatavalid                                         (sdram_u2_s1_readdatavalid),
      .sdram_u2_s1_reset_n                                               (sdram_u2_s1_reset_n),
      .sdram_u2_s1_waitrequest                                           (sdram_u2_s1_waitrequest),
      .sdram_u2_s1_waitrequest_from_sa                                   (sdram_u2_s1_waitrequest_from_sa),
      .sdram_u2_s1_write_n                                               (sdram_u2_s1_write_n),
      .sdram_u2_s1_writedata                                             (sdram_u2_s1_writedata)
    );

  sdram_u2 the_sdram_u2
    (
      .az_addr        (sdram_u2_s1_address),
      .az_be_n        (sdram_u2_s1_byteenable_n),
      .az_cs          (sdram_u2_s1_chipselect),
      .az_data        (sdram_u2_s1_writedata),
      .az_rd_n        (sdram_u2_s1_read_n),
      .az_wr_n        (sdram_u2_s1_write_n),
      .clk            (pll_c0_system),
      .reset_n        (sdram_u2_s1_reset_n),
      .za_data        (sdram_u2_s1_readdata),
      .za_valid       (sdram_u2_s1_readdatavalid),
      .za_waitrequest (sdram_u2_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_u2),
      .zs_ba          (zs_ba_from_the_sdram_u2),
      .zs_cas_n       (zs_cas_n_from_the_sdram_u2),
      .zs_cke         (zs_cke_from_the_sdram_u2),
      .zs_cs_n        (zs_cs_n_from_the_sdram_u2),
      .zs_dq          (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm         (zs_dqm_from_the_sdram_u2),
      .zs_ras_n       (zs_ras_n_from_the_sdram_u2),
      .zs_we_n        (zs_we_n_from_the_sdram_u2)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sysid_control_slave                (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_sysid_control_slave      (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_sysid_control_slave        (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_requests_sysid_control_slave               (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .d1_sysid_control_slave_end_xfer                            (d1_sysid_control_slave_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .sysid_control_slave_address                                (sysid_control_slave_address),
      .sysid_control_slave_readdata                               (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                       (sysid_control_slave_readdata_from_sa)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .readdata (sysid_control_slave_readdata)
    );

  timer_s1_arbitrator the_timer_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_timer_s1                           (cpu_data_master_granted_timer_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_timer_s1                 (cpu_data_master_qualified_request_timer_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_timer_s1                   (cpu_data_master_read_data_valid_timer_s1),
      .cpu_data_master_requests_timer_s1                          (cpu_data_master_requests_timer_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_timer_s1_end_xfer                                       (d1_timer_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .timer_s1_address                                           (timer_s1_address),
      .timer_s1_chipselect                                        (timer_s1_chipselect),
      .timer_s1_irq                                               (timer_s1_irq),
      .timer_s1_irq_from_sa                                       (timer_s1_irq_from_sa),
      .timer_s1_readdata                                          (timer_s1_readdata),
      .timer_s1_readdata_from_sa                                  (timer_s1_readdata_from_sa),
      .timer_s1_reset_n                                           (timer_s1_reset_n),
      .timer_s1_write_n                                           (timer_s1_write_n),
      .timer_s1_writedata                                         (timer_s1_writedata)
    );

  timer the_timer
    (
      .address    (timer_s1_address),
      .chipselect (timer_s1_chipselect),
      .clk        (pll_c0_system),
      .irq        (timer_s1_irq),
      .readdata   (timer_s1_readdata),
      .reset_n    (timer_s1_reset_n),
      .write_n    (timer_s1_write_n),
      .writedata  (timer_s1_writedata)
    );

  timer_stamp_s1_arbitrator the_timer_stamp_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_timer_stamp_s1                     (cpu_data_master_granted_timer_stamp_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_timer_stamp_s1           (cpu_data_master_qualified_request_timer_stamp_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_timer_stamp_s1             (cpu_data_master_read_data_valid_timer_stamp_s1),
      .cpu_data_master_requests_timer_stamp_s1                    (cpu_data_master_requests_timer_stamp_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_timer_stamp_s1_end_xfer                                 (d1_timer_stamp_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .timer_stamp_s1_address                                     (timer_stamp_s1_address),
      .timer_stamp_s1_chipselect                                  (timer_stamp_s1_chipselect),
      .timer_stamp_s1_irq                                         (timer_stamp_s1_irq),
      .timer_stamp_s1_irq_from_sa                                 (timer_stamp_s1_irq_from_sa),
      .timer_stamp_s1_readdata                                    (timer_stamp_s1_readdata),
      .timer_stamp_s1_readdata_from_sa                            (timer_stamp_s1_readdata_from_sa),
      .timer_stamp_s1_reset_n                                     (timer_stamp_s1_reset_n),
      .timer_stamp_s1_write_n                                     (timer_stamp_s1_write_n),
      .timer_stamp_s1_writedata                                   (timer_stamp_s1_writedata)
    );

  timer_stamp the_timer_stamp
    (
      .address    (timer_stamp_s1_address),
      .chipselect (timer_stamp_s1_chipselect),
      .clk        (pll_c0_system),
      .irq        (timer_stamp_s1_irq),
      .readdata   (timer_stamp_s1_readdata),
      .reset_n    (timer_stamp_s1_reset_n),
      .write_n    (timer_stamp_s1_write_n),
      .writedata  (timer_stamp_s1_writedata)
    );

  uart_s1_arbitrator the_uart_s1
    (
      .clk                                                        (pll_c0_system),
      .cpu_data_master_address_to_slave                           (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_uart_s1                            (cpu_data_master_granted_uart_s1),
      .cpu_data_master_latency_counter                            (cpu_data_master_latency_counter),
      .cpu_data_master_qualified_request_uart_s1                  (cpu_data_master_qualified_request_uart_s1),
      .cpu_data_master_read                                       (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_u1_s1_shift_register (cpu_data_master_read_data_valid_sdram_u1_s1_shift_register),
      .cpu_data_master_read_data_valid_sdram_u2_s1_shift_register (cpu_data_master_read_data_valid_sdram_u2_s1_shift_register),
      .cpu_data_master_read_data_valid_uart_s1                    (cpu_data_master_read_data_valid_uart_s1),
      .cpu_data_master_requests_uart_s1                           (cpu_data_master_requests_uart_s1),
      .cpu_data_master_write                                      (cpu_data_master_write),
      .cpu_data_master_writedata                                  (cpu_data_master_writedata),
      .d1_uart_s1_end_xfer                                        (d1_uart_s1_end_xfer),
      .reset_n                                                    (pll_c0_system_reset_n),
      .uart_s1_address                                            (uart_s1_address),
      .uart_s1_begintransfer                                      (uart_s1_begintransfer),
      .uart_s1_chipselect                                         (uart_s1_chipselect),
      .uart_s1_dataavailable                                      (uart_s1_dataavailable),
      .uart_s1_dataavailable_from_sa                              (uart_s1_dataavailable_from_sa),
      .uart_s1_irq                                                (uart_s1_irq),
      .uart_s1_irq_from_sa                                        (uart_s1_irq_from_sa),
      .uart_s1_read_n                                             (uart_s1_read_n),
      .uart_s1_readdata                                           (uart_s1_readdata),
      .uart_s1_readdata_from_sa                                   (uart_s1_readdata_from_sa),
      .uart_s1_readyfordata                                       (uart_s1_readyfordata),
      .uart_s1_readyfordata_from_sa                               (uart_s1_readyfordata_from_sa),
      .uart_s1_reset_n                                            (uart_s1_reset_n),
      .uart_s1_write_n                                            (uart_s1_write_n),
      .uart_s1_writedata                                          (uart_s1_writedata)
    );

  uart the_uart
    (
      .address       (uart_s1_address),
      .begintransfer (uart_s1_begintransfer),
      .chipselect    (uart_s1_chipselect),
      .clk           (pll_c0_system),
      .cts_n         (cts_n_to_the_uart),
      .dataavailable (uart_s1_dataavailable),
      .irq           (uart_s1_irq),
      .read_n        (uart_s1_read_n),
      .readdata      (uart_s1_readdata),
      .readyfordata  (uart_s1_readyfordata),
      .reset_n       (uart_s1_reset_n),
      .rts_n         (rts_n_from_the_uart),
      .rxd           (rxd_to_the_uart),
      .txd           (txd_from_the_uart),
      .write_n       (uart_s1_write_n),
      .writedata     (uart_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  nios_ii_reset_pll_c0_system_domain_synch_module nios_ii_reset_pll_c0_system_domain_synch
    (
      .clk      (pll_c0_system),
      .data_in  (1'b1),
      .data_out (pll_c0_system_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_jtag_debug_module_resetrequest_from_sa |
    cpu_jtag_debug_module_resetrequest_from_sa |
    0 |
    pll_s1_resetrequest_from_sa |
    pll_s1_resetrequest_from_sa);

  //reset is asserted asynchronously and deasserted synchronously
  nios_ii_reset_clk_50_domain_synch_module nios_ii_reset_clk_50_domain_synch
    (
      .clk      (clk_50),
      .data_in  (1'b1),
      .data_out (clk_50_reset_n),
      .reset_n  (reset_n_sources)
    );

  //nios_ii_clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  assign nios_ii_clock_0_out_endofpacket = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/80/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/80/quartus/eda/sim_lib/220model.v"
`include "c:/altera/80/quartus/eda/sim_lib/sgate.v"
`include "SEG7.v"
`include "pll.v"
`include "altpllpll.v"
`include "sdram_u2.v"
`include "sdram_u2_test_component.v"
`include "pio_button.v"
`include "uart.v"
`include "pio_red_led.v"
`include "sysid.v"
`include "timer.v"
`include "jtag_uart.v"
`include "pio_switch.v"
`include "sdram_u1.v"
`include "sdram_u1_test_component.v"
`include "lcd.v"
`include "nios_ii_clock_0.v"
`include "pio_green_led.v"
`include "cpu_test_bench.v"
`include "cpu_mult_cell.v"
`include "cpu_jtag_debug_module_tck.v"
`include "cpu_jtag_debug_module_sysclk.v"
`include "cpu_jtag_debug_module_wrapper.v"
`include "cpu.v"
`include "onchip_mem.v"
`include "timer_stamp.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LCD_E_from_the_lcd;
  wire             LCD_RS_from_the_lcd;
  wire             LCD_RW_from_the_lcd;
  wire    [  7: 0] LCD_data_to_and_from_the_lcd;
  wire    [ 63: 0] avs_s1_export_seg7_from_the_SEG7;
  wire             clk;
  reg              clk_50;
  wire             cts_n_to_the_uart;
  wire    [  3: 0] in_port_to_the_pio_button;
  wire    [ 17: 0] in_port_to_the_pio_switch;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             nios_ii_clock_0_in_endofpacket_from_sa;
  wire    [  1: 0] nios_ii_clock_0_out_byteenable;
  wire             nios_ii_clock_0_out_endofpacket;
  wire    [  8: 0] out_port_from_the_pio_green_led;
  wire    [ 17: 0] out_port_from_the_pio_red_led;
  wire             pll_c0_system;
  wire             pll_c1_memory;
  wire             pll_c2_audio;
  reg              reset_n;
  wire             rts_n_from_the_uart;
  wire             rxd_to_the_uart;
  wire             txd_from_the_uart;
  wire             uart_s1_dataavailable_from_sa;
  wire             uart_s1_readyfordata_from_sa;
  wire    [ 12: 0] zs_addr_from_the_sdram_u1;
  wire    [ 12: 0] zs_addr_from_the_sdram_u2;
  wire    [  1: 0] zs_ba_from_the_sdram_u1;
  wire    [  1: 0] zs_ba_from_the_sdram_u2;
  wire             zs_cas_n_from_the_sdram_u1;
  wire             zs_cas_n_from_the_sdram_u2;
  wire             zs_cke_from_the_sdram_u1;
  wire             zs_cke_from_the_sdram_u2;
  wire             zs_cs_n_from_the_sdram_u1;
  wire             zs_cs_n_from_the_sdram_u2;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u1;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_u2;
  wire    [  1: 0] zs_dqm_from_the_sdram_u1;
  wire    [  1: 0] zs_dqm_from_the_sdram_u2;
  wire             zs_ras_n_from_the_sdram_u1;
  wire             zs_ras_n_from_the_sdram_u2;
  wire             zs_we_n_from_the_sdram_u1;
  wire             zs_we_n_from_the_sdram_u2;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  nios_ii DUT
    (
      .LCD_E_from_the_lcd               (LCD_E_from_the_lcd),
      .LCD_RS_from_the_lcd              (LCD_RS_from_the_lcd),
      .LCD_RW_from_the_lcd              (LCD_RW_from_the_lcd),
      .LCD_data_to_and_from_the_lcd     (LCD_data_to_and_from_the_lcd),
      .avs_s1_export_seg7_from_the_SEG7 (avs_s1_export_seg7_from_the_SEG7),
      .clk_50                           (clk_50),
      .cts_n_to_the_uart                (cts_n_to_the_uart),
      .in_port_to_the_pio_button        (in_port_to_the_pio_button),
      .in_port_to_the_pio_switch        (in_port_to_the_pio_switch),
      .out_port_from_the_pio_green_led  (out_port_from_the_pio_green_led),
      .out_port_from_the_pio_red_led    (out_port_from_the_pio_red_led),
      .pll_c0_system                    (pll_c0_system),
      .pll_c1_memory                    (pll_c1_memory),
      .pll_c2_audio                     (pll_c2_audio),
      .reset_n                          (reset_n),
      .rts_n_from_the_uart              (rts_n_from_the_uart),
      .rxd_to_the_uart                  (rxd_to_the_uart),
      .txd_from_the_uart                (txd_from_the_uart),
      .zs_addr_from_the_sdram_u1        (zs_addr_from_the_sdram_u1),
      .zs_addr_from_the_sdram_u2        (zs_addr_from_the_sdram_u2),
      .zs_ba_from_the_sdram_u1          (zs_ba_from_the_sdram_u1),
      .zs_ba_from_the_sdram_u2          (zs_ba_from_the_sdram_u2),
      .zs_cas_n_from_the_sdram_u1       (zs_cas_n_from_the_sdram_u1),
      .zs_cas_n_from_the_sdram_u2       (zs_cas_n_from_the_sdram_u2),
      .zs_cke_from_the_sdram_u1         (zs_cke_from_the_sdram_u1),
      .zs_cke_from_the_sdram_u2         (zs_cke_from_the_sdram_u2),
      .zs_cs_n_from_the_sdram_u1        (zs_cs_n_from_the_sdram_u1),
      .zs_cs_n_from_the_sdram_u2        (zs_cs_n_from_the_sdram_u2),
      .zs_dq_to_and_from_the_sdram_u1   (zs_dq_to_and_from_the_sdram_u1),
      .zs_dq_to_and_from_the_sdram_u2   (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm_from_the_sdram_u1         (zs_dqm_from_the_sdram_u1),
      .zs_dqm_from_the_sdram_u2         (zs_dqm_from_the_sdram_u2),
      .zs_ras_n_from_the_sdram_u1       (zs_ras_n_from_the_sdram_u1),
      .zs_ras_n_from_the_sdram_u2       (zs_ras_n_from_the_sdram_u2),
      .zs_we_n_from_the_sdram_u1        (zs_we_n_from_the_sdram_u1),
      .zs_we_n_from_the_sdram_u2        (zs_we_n_from_the_sdram_u2)
    );

  sdram_u1_test_component the_sdram_u1_test_component
    (
      .clk      (pll_c0_system),
      .zs_addr  (zs_addr_from_the_sdram_u1),
      .zs_ba    (zs_ba_from_the_sdram_u1),
      .zs_cas_n (zs_cas_n_from_the_sdram_u1),
      .zs_cke   (zs_cke_from_the_sdram_u1),
      .zs_cs_n  (zs_cs_n_from_the_sdram_u1),
      .zs_dq    (zs_dq_to_and_from_the_sdram_u1),
      .zs_dqm   (zs_dqm_from_the_sdram_u1),
      .zs_ras_n (zs_ras_n_from_the_sdram_u1),
      .zs_we_n  (zs_we_n_from_the_sdram_u1)
    );

  sdram_u2_test_component the_sdram_u2_test_component
    (
      .clk      (pll_c0_system),
      .zs_addr  (zs_addr_from_the_sdram_u2),
      .zs_ba    (zs_ba_from_the_sdram_u2),
      .zs_cas_n (zs_cas_n_from_the_sdram_u2),
      .zs_cke   (zs_cke_from_the_sdram_u2),
      .zs_cs_n  (zs_cs_n_from_the_sdram_u2),
      .zs_dq    (zs_dq_to_and_from_the_sdram_u2),
      .zs_dqm   (zs_dqm_from_the_sdram_u2),
      .zs_ras_n (zs_ras_n_from_the_sdram_u2),
      .zs_we_n  (zs_we_n_from_the_sdram_u2)
    );

  initial
    clk_50 = 1'b0;
  always
    #10 clk_50 <= ~clk_50;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on