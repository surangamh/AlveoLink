// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="tx_checkCurrentPacket_dev_tx_checkCurrentPacket_dev,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu55c-fsvh2892-2L-e,HLS_INPUT_CLOCK=2.500000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.635000,HLS_SYN_LAT=4,HLS_SYN_TPT=2,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=123,HLS_SYN_LUT=142,HLS_VERSION=2020_2}" *)

module tx_checkCurrentPacket_dev (
        ap_clk,
        ap_rst_n,
        statBitMap_address_o_V_TDATA,
        statBitMap_address_o_V_TVALID,
        statBitMap_address_o_V_TREADY,
        statBitMap_data_o_V_TDATA,
        statBitMap_data_o_V_TVALID,
        statBitMap_data_o_V_TREADY,
        readPSN_l_V_TDATA,
        readPSN_l_V_TVALID,
        readPSN_l_V_TREADY,
        writePSN_l_V_TDATA,
        writePSN_l_V_TVALID,
        writePSN_l_V_TREADY,
        bitMap_address0,
        bitMap_ce0,
        bitMap_q0,
        toRetransmit_V_TDATA,
        toRetransmit_V_TVALID,
        toRetransmit_V_TREADY
);

parameter    ap_ST_fsm_pp0_stage0 = 2'd1;
parameter    ap_ST_fsm_pp0_stage1 = 2'd2;

input   ap_clk;
input   ap_rst_n;
output  [23:0] statBitMap_address_o_V_TDATA;
output   statBitMap_address_o_V_TVALID;
input   statBitMap_address_o_V_TREADY;
output  [7:0] statBitMap_data_o_V_TDATA;
output   statBitMap_data_o_V_TVALID;
input   statBitMap_data_o_V_TREADY;
output  [23:0] readPSN_l_V_TDATA;
output   readPSN_l_V_TVALID;
input   readPSN_l_V_TREADY;
input  [23:0] writePSN_l_V_TDATA;
input   writePSN_l_V_TVALID;
output   writePSN_l_V_TREADY;
output  [19:0] bitMap_address0;
output   bitMap_ce0;
input  [7:0] bitMap_q0;
output  [63:0] toRetransmit_V_TDATA;
output   toRetransmit_V_TVALID;
input   toRetransmit_V_TREADY;

reg bitMap_ce0;

(* shreg_extract = "no" *) reg    ap_rst_reg_2;
(* shreg_extract = "no" *) reg    ap_rst_reg_1;
(* shreg_extract = "no" *) reg    ap_rst_n_inv;
reg   [23:0] readPSN_V;
reg    statBitMap_address_o_V_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage1;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage1;
reg   [0:0] icmp_ln870_reg_174;
reg   [0:0] icmp_ln870_reg_174_pp0_iter1_reg;
reg   [1:0] packetStatus_V_reg_188;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter2;
wire    ap_block_pp0_stage0;
reg    statBitMap_data_o_V_TDATA_blk_n;
reg    readPSN_l_V_TDATA_blk_n;
reg    writePSN_l_V_TDATA_blk_n;
reg    toRetransmit_V_TDATA_blk_n;
reg   [23:0] readPSN_V_1_reg_167;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state3_pp0_stage0_iter1;
reg    ap_predicate_op47_write_state5;
reg    ap_predicate_op48_write_state5;
reg    ap_predicate_op49_write_state5;
wire    regslice_both_statBitMap_address_o_V_U_apdone_blk;
wire    regslice_both_statBitMap_data_o_V_U_apdone_blk;
wire    regslice_both_readPSN_l_V_U_apdone_blk;
wire    regslice_forward_toRetransmit_V_U_apdone_blk;
reg    ap_block_state5_pp0_stage0_iter2;
reg    ap_block_state5_io;
reg    ap_block_pp0_stage0_11001;
reg   [23:0] readPSN_V_1_reg_167_pp0_iter1_reg;
wire   [0:0] icmp_ln870_fu_131_p2;
wire   [19:0] trunc_ln674_fu_137_p1;
reg   [19:0] trunc_ln674_reg_178;
reg   [19:0] trunc_ln674_reg_178_pp0_iter1_reg;
wire   [1:0] packetStatus_V_fu_146_p1;
wire    ap_block_state2_pp0_stage1_iter0;
reg    ap_predicate_op43_write_state4;
reg    ap_predicate_op45_write_state4;
reg    ap_predicate_op46_write_state4;
reg    ap_block_state4_pp0_stage1_iter1;
reg    ap_block_state4_io;
reg    ap_block_pp0_stage1_11001;
reg    ap_block_pp0_stage1_subdone;
reg    ap_block_pp0_stage0_subdone;
wire   [63:0] zext_ln534_fu_141_p1;
wire   [23:0] grp_fu_116_p2;
reg   [23:0] ap_sig_allocacmp_readPSN_V_1;
reg    ap_block_pp0_stage0_01001;
reg    ap_block_pp0_stage1_01001;
wire   [33:0] tmp_fu_150_p4;
reg   [1:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire   [23:0] statBitMap_address_o_V_TDATA_int_regslice;
reg    statBitMap_address_o_V_TVALID_int_regslice;
wire    statBitMap_address_o_V_TREADY_int_regslice;
wire    regslice_both_statBitMap_address_o_V_U_vld_out;
reg    statBitMap_data_o_V_TVALID_int_regslice;
wire    statBitMap_data_o_V_TREADY_int_regslice;
wire    regslice_both_statBitMap_data_o_V_U_vld_out;
reg    readPSN_l_V_TVALID_int_regslice;
wire    readPSN_l_V_TREADY_int_regslice;
wire    regslice_both_readPSN_l_V_U_vld_out;
wire    regslice_both_writePSN_l_V_U_apdone_blk;
wire   [23:0] writePSN_l_V_TDATA_int_regslice;
wire    writePSN_l_V_TVALID_int_regslice;
reg    writePSN_l_V_TREADY_int_regslice;
wire    regslice_both_writePSN_l_V_U_ack_in;
wire   [63:0] toRetransmit_V_TDATA_int_regslice;
reg    toRetransmit_V_TVALID_int_regslice;
wire    toRetransmit_V_TREADY_int_regslice;
wire    regslice_forward_toRetransmit_V_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_rst_reg_2 = 1'b0;
#0 ap_rst_reg_1 = 1'b0;
#0 ap_rst_n_inv = 1'b0;
#0 readPSN_V = 24'd0;
#0 ap_CS_fsm = 2'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 icmp_ln870_reg_174 = 1'd0;
#0 icmp_ln870_reg_174_pp0_iter1_reg = 1'd0;
#0 packetStatus_V_reg_188 = 2'd0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 readPSN_V_1_reg_167 = 24'd0;
#0 readPSN_V_1_reg_167_pp0_iter1_reg = 24'd0;
#0 trunc_ln674_reg_178 = 20'd0;
#0 trunc_ln674_reg_178_pp0_iter1_reg = 20'd0;
end

tx_checkCurrentPacket_dev_regslice_both #(
    .DataWidth( 24 ))
regslice_both_statBitMap_address_o_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(statBitMap_address_o_V_TDATA_int_regslice),
    .vld_in(statBitMap_address_o_V_TVALID_int_regslice),
    .ack_in(statBitMap_address_o_V_TREADY_int_regslice),
    .data_out(statBitMap_address_o_V_TDATA),
    .vld_out(regslice_both_statBitMap_address_o_V_U_vld_out),
    .ack_out(statBitMap_address_o_V_TREADY),
    .apdone_blk(regslice_both_statBitMap_address_o_V_U_apdone_blk)
);

tx_checkCurrentPacket_dev_regslice_both #(
    .DataWidth( 8 ))
regslice_both_statBitMap_data_o_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(8'd0),
    .vld_in(statBitMap_data_o_V_TVALID_int_regslice),
    .ack_in(statBitMap_data_o_V_TREADY_int_regslice),
    .data_out(statBitMap_data_o_V_TDATA),
    .vld_out(regslice_both_statBitMap_data_o_V_U_vld_out),
    .ack_out(statBitMap_data_o_V_TREADY),
    .apdone_blk(regslice_both_statBitMap_data_o_V_U_apdone_blk)
);

tx_checkCurrentPacket_dev_regslice_both #(
    .DataWidth( 24 ))
regslice_both_readPSN_l_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(readPSN_V_1_reg_167),
    .vld_in(readPSN_l_V_TVALID_int_regslice),
    .ack_in(readPSN_l_V_TREADY_int_regslice),
    .data_out(readPSN_l_V_TDATA),
    .vld_out(regslice_both_readPSN_l_V_U_vld_out),
    .ack_out(readPSN_l_V_TREADY),
    .apdone_blk(regslice_both_readPSN_l_V_U_apdone_blk)
);

tx_checkCurrentPacket_dev_regslice_both #(
    .DataWidth( 24 ))
regslice_both_writePSN_l_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(writePSN_l_V_TDATA),
    .vld_in(writePSN_l_V_TVALID),
    .ack_in(regslice_both_writePSN_l_V_U_ack_in),
    .data_out(writePSN_l_V_TDATA_int_regslice),
    .vld_out(writePSN_l_V_TVALID_int_regslice),
    .ack_out(writePSN_l_V_TREADY_int_regslice),
    .apdone_blk(regslice_both_writePSN_l_V_U_apdone_blk)
);

tx_checkCurrentPacket_dev_regslice_forward #(
    .DataWidth( 64 ))
regslice_forward_toRetransmit_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(toRetransmit_V_TDATA_int_regslice),
    .vld_in(toRetransmit_V_TVALID_int_regslice),
    .ack_in(toRetransmit_V_TREADY_int_regslice),
    .data_out(toRetransmit_V_TDATA),
    .vld_out(regslice_forward_toRetransmit_V_U_vld_out),
    .ack_out(toRetransmit_V_TREADY),
    .apdone_blk(regslice_forward_toRetransmit_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_rst_n_inv <= 1'b0;
    end else begin
        ap_rst_n_inv <= ap_rst_reg_1;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_rst_reg_1 <= 1'b0;
    end else begin
        ap_rst_reg_1 <= ap_rst_reg_2;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_rst_reg_2 <= 1'b0;
    end else begin
        ap_rst_reg_2 <= ~ap_rst_n;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        icmp_ln870_reg_174 <= 1'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            icmp_ln870_reg_174 <= icmp_ln870_fu_131_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        icmp_ln870_reg_174_pp0_iter1_reg <= 1'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            icmp_ln870_reg_174_pp0_iter1_reg <= icmp_ln870_reg_174;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        packetStatus_V_reg_188 <= 2'd0;
    end else begin
        if (((icmp_ln870_reg_174 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            packetStatus_V_reg_188 <= packetStatus_V_fu_146_p1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        readPSN_V <= 24'd0;
    end else begin
        if (((~(packetStatus_V_fu_146_p1 == 2'd3) & ~(packetStatus_V_fu_146_p1 == 2'd0) & (icmp_ln870_reg_174 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln870_reg_174 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (packetStatus_V_fu_146_p1 == 2'd0)))) begin
            readPSN_V <= grp_fu_116_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        readPSN_V_1_reg_167 <= 24'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            readPSN_V_1_reg_167 <= ap_sig_allocacmp_readPSN_V_1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        readPSN_V_1_reg_167_pp0_iter1_reg <= 24'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            readPSN_V_1_reg_167_pp0_iter1_reg <= readPSN_V_1_reg_167;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        trunc_ln674_reg_178 <= 20'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln870_fu_131_p2 == 1'd0))) begin
            trunc_ln674_reg_178 <= trunc_ln674_fu_137_p1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        trunc_ln674_reg_178_pp0_iter1_reg <= 20'd0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            trunc_ln674_reg_178_pp0_iter1_reg <= trunc_ln674_reg_178;
        end
    end
end

always @ (*) begin
    if (((1'b1 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((~(packetStatus_V_fu_146_p1 == 2'd3) & ~(packetStatus_V_fu_146_p1 == 2'd0) & (icmp_ln870_reg_174 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln870_reg_174 == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (packetStatus_V_fu_146_p1 == 2'd0)))) begin
        ap_sig_allocacmp_readPSN_V_1 = grp_fu_116_p2;
    end else begin
        ap_sig_allocacmp_readPSN_V_1 = readPSN_V;
    end
end

always @ (*) begin
    if ((((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        bitMap_ce0 = 1'b1;
    end else begin
        bitMap_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        readPSN_l_V_TDATA_blk_n = readPSN_l_V_TREADY_int_regslice;
    end else begin
        readPSN_l_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        readPSN_l_V_TVALID_int_regslice = 1'b1;
    end else begin
        readPSN_l_V_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        statBitMap_address_o_V_TDATA_blk_n = statBitMap_address_o_V_TREADY_int_regslice;
    end else begin
        statBitMap_address_o_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1) & (ap_predicate_op45_write_state4 == 1'b1))) begin
        statBitMap_address_o_V_TVALID_int_regslice = 1'b1;
    end else begin
        statBitMap_address_o_V_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        statBitMap_data_o_V_TDATA_blk_n = statBitMap_data_o_V_TREADY_int_regslice;
    end else begin
        statBitMap_data_o_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1) & (ap_predicate_op46_write_state4 == 1'b1))) begin
        statBitMap_data_o_V_TVALID_int_regslice = 1'b1;
    end else begin
        statBitMap_data_o_V_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (ap_enable_reg_pp0_iter2 == 1'b1) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        toRetransmit_V_TDATA_blk_n = toRetransmit_V_TREADY_int_regslice;
    end else begin
        toRetransmit_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1) & (ap_predicate_op43_write_state4 == 1'b1))) begin
        toRetransmit_V_TVALID_int_regslice = 1'b1;
    end else begin
        toRetransmit_V_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        writePSN_l_V_TDATA_blk_n = writePSN_l_V_TVALID_int_regslice;
    end else begin
        writePSN_l_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        writePSN_l_V_TREADY_int_regslice = 1'b1;
    end else begin
        writePSN_l_V_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_reset_idle_pp0 == 1'b0))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_reset_idle_pp0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd1];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((1'b1 == 1'b1) & (writePSN_l_V_TVALID_int_regslice == 1'b0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((regslice_forward_toRetransmit_V_U_apdone_blk == 1'b1) | (regslice_both_readPSN_l_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_data_o_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_address_o_V_U_apdone_blk == 1'b1) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op47_write_state5 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op49_write_state5 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op48_write_state5 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (readPSN_l_V_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((1'b1 == 1'b1) & (writePSN_l_V_TVALID_int_regslice == 1'b0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state5_io) | (regslice_forward_toRetransmit_V_U_apdone_blk == 1'b1) | (regslice_both_readPSN_l_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_data_o_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_address_o_V_U_apdone_blk == 1'b1) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op47_write_state5 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op49_write_state5 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op48_write_state5 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (readPSN_l_V_TREADY_int_regslice == 1'b0)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((1'b1 == 1'b1) & (writePSN_l_V_TVALID_int_regslice == 1'b0)) | ((ap_enable_reg_pp0_iter2 == 1'b1) & ((1'b1 == ap_block_state5_io) | (regslice_forward_toRetransmit_V_U_apdone_blk == 1'b1) | (regslice_both_readPSN_l_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_data_o_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_address_o_V_U_apdone_blk == 1'b1) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op47_write_state5 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op49_write_state5 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op48_write_state5 == 1'b1)))) | ((ap_enable_reg_pp0_iter1 == 1'b1) & (readPSN_l_V_TREADY_int_regslice == 1'b0)));
end

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage1_01001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((readPSN_l_V_TREADY_int_regslice == 1'b0) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op43_write_state4 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op46_write_state4 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state4 == 1'b1))));
end

always @ (*) begin
    ap_block_pp0_stage1_11001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state4_io) | (readPSN_l_V_TREADY_int_regslice == 1'b0) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op43_write_state4 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op46_write_state4 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state4 == 1'b1))));
end

always @ (*) begin
    ap_block_pp0_stage1_subdone = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((1'b1 == ap_block_state4_io) | (readPSN_l_V_TREADY_int_regslice == 1'b0) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op43_write_state4 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op46_write_state4 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state4 == 1'b1))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (writePSN_l_V_TVALID_int_regslice == 1'b0);
end

assign ap_block_state2_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage0_iter1 = (readPSN_l_V_TREADY_int_regslice == 1'b0);
end

always @ (*) begin
    ap_block_state4_io = ((readPSN_l_V_TREADY_int_regslice == 1'b0) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op43_write_state4 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op46_write_state4 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state4 == 1'b1)));
end

always @ (*) begin
    ap_block_state4_pp0_stage1_iter1 = ((readPSN_l_V_TREADY_int_regslice == 1'b0) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op43_write_state4 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op46_write_state4 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op45_write_state4 == 1'b1)));
end

always @ (*) begin
    ap_block_state5_io = (((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op47_write_state5 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op49_write_state5 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op48_write_state5 == 1'b1)));
end

always @ (*) begin
    ap_block_state5_pp0_stage0_iter2 = ((regslice_forward_toRetransmit_V_U_apdone_blk == 1'b1) | (regslice_both_readPSN_l_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_data_o_V_U_apdone_blk == 1'b1) | (regslice_both_statBitMap_address_o_V_U_apdone_blk == 1'b1) | ((toRetransmit_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op47_write_state5 == 1'b1)) | ((statBitMap_data_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op49_write_state5 == 1'b1)) | ((statBitMap_address_o_V_TREADY_int_regslice == 1'b0) & (ap_predicate_op48_write_state5 == 1'b1)));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_predicate_op43_write_state4 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op45_write_state4 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op46_write_state4 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op47_write_state5 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op48_write_state5 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op49_write_state5 = (~(packetStatus_V_reg_188 == 2'd3) & ~(packetStatus_V_reg_188 == 2'd0) & (icmp_ln870_reg_174_pp0_iter1_reg == 1'd0));
end

assign bitMap_address0 = zext_ln534_fu_141_p1;

assign grp_fu_116_p2 = (readPSN_V_1_reg_167 + 24'd1);

assign icmp_ln870_fu_131_p2 = ((ap_sig_allocacmp_readPSN_V_1 == writePSN_l_V_TDATA_int_regslice) ? 1'b1 : 1'b0);

assign packetStatus_V_fu_146_p1 = bitMap_q0[1:0];

assign readPSN_l_V_TVALID = regslice_both_readPSN_l_V_U_vld_out;

assign statBitMap_address_o_V_TDATA_int_regslice = trunc_ln674_reg_178_pp0_iter1_reg;

assign statBitMap_address_o_V_TVALID = regslice_both_statBitMap_address_o_V_U_vld_out;

assign statBitMap_data_o_V_TVALID = regslice_both_statBitMap_data_o_V_U_vld_out;

assign tmp_fu_150_p4 = {{{packetStatus_V_reg_188}, {8'd0}}, {readPSN_V_1_reg_167_pp0_iter1_reg}};

assign toRetransmit_V_TDATA_int_regslice = tmp_fu_150_p4;

assign toRetransmit_V_TVALID = regslice_forward_toRetransmit_V_U_vld_out;

assign trunc_ln674_fu_137_p1 = ap_sig_allocacmp_readPSN_V_1[19:0];

assign writePSN_l_V_TREADY = regslice_both_writePSN_l_V_U_ack_in;

assign zext_ln534_fu_141_p1 = trunc_ln674_fu_137_p1;

endmodule //tx_checkCurrentPacket_dev
