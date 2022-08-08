// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="cmac_tkeep_fix_cmac_tkeep_fix,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xcu200-fsgd2104-2-e,HLS_INPUT_CLOCK=3.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=0.411000,HLS_SYN_LAT=1,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=3,HLS_SYN_LUT=91,HLS_VERSION=2020_2}" *)

module cmac_tkeep_fix (
        ap_clk,
        ap_rst_n,
        in_r_TDATA,
        in_r_TVALID,
        in_r_TREADY,
        in_r_TKEEP,
        in_r_TSTRB,
        in_r_TLAST,
        out_r_TDATA,
        out_r_TVALID,
        out_r_TREADY,
        out_r_TKEEP,
        out_r_TSTRB,
        out_r_TLAST
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst_n;
input  [511:0] in_r_TDATA;
input   in_r_TVALID;
output   in_r_TREADY;
input  [63:0] in_r_TKEEP;
input  [63:0] in_r_TSTRB;
input  [0:0] in_r_TLAST;
output  [511:0] out_r_TDATA;
output   out_r_TVALID;
input   out_r_TREADY;
output  [63:0] out_r_TKEEP;
output  [63:0] out_r_TSTRB;
output  [0:0] out_r_TLAST;

 reg    ap_rst_n_inv;
reg   [0:0] first_strobe;
reg    in_r_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
reg    out_r_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter1;
reg    ap_block_state1_pp0_stage0_iter0;
wire    regslice_both_out_V_data_V_U_apdone_blk;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] or_ln27_fu_110_p2;
reg    ap_block_pp0_stage0_01001;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_in_V_data_V_U_apdone_blk;
wire   [511:0] in_r_TDATA_int_regslice;
wire    in_r_TVALID_int_regslice;
reg    in_r_TREADY_int_regslice;
wire    regslice_both_in_V_data_V_U_ack_in;
wire    regslice_both_in_V_keep_V_U_apdone_blk;
wire   [63:0] in_r_TKEEP_int_regslice;
wire    regslice_both_in_V_keep_V_U_vld_out;
wire    regslice_both_in_V_keep_V_U_ack_in;
wire    regslice_both_in_V_strb_V_U_apdone_blk;
wire   [63:0] in_r_TSTRB_int_regslice;
wire    regslice_both_in_V_strb_V_U_vld_out;
wire    regslice_both_in_V_strb_V_U_ack_in;
wire    regslice_both_in_V_last_V_U_apdone_blk;
wire   [0:0] in_r_TLAST_int_regslice;
wire    regslice_both_in_V_last_V_U_vld_out;
wire    regslice_both_in_V_last_V_U_ack_in;
reg    out_r_TVALID_int_regslice;
wire    out_r_TREADY_int_regslice;
wire    regslice_both_out_V_data_V_U_vld_out;
wire    regslice_both_out_V_keep_V_U_apdone_blk;
wire   [63:0] out_r_TKEEP_int_regslice;
wire    regslice_both_out_V_keep_V_U_ack_in_dummy;
wire    regslice_both_out_V_keep_V_U_vld_out;
wire    regslice_both_out_V_strb_V_U_apdone_blk;
wire    regslice_both_out_V_strb_V_U_ack_in_dummy;
wire    regslice_both_out_V_strb_V_U_vld_out;
wire    regslice_both_out_V_last_V_U_apdone_blk;
wire    regslice_both_out_V_last_V_U_ack_in_dummy;
wire    regslice_both_out_V_last_V_U_vld_out;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 first_strobe = 1'd1;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 512 ))
regslice_both_in_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TDATA),
    .vld_in(in_r_TVALID),
    .ack_in(regslice_both_in_V_data_V_U_ack_in),
    .data_out(in_r_TDATA_int_regslice),
    .vld_out(in_r_TVALID_int_regslice),
    .ack_out(in_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_in_V_data_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 64 ))
regslice_both_in_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TKEEP),
    .vld_in(in_r_TVALID),
    .ack_in(regslice_both_in_V_keep_V_U_ack_in),
    .data_out(in_r_TKEEP_int_regslice),
    .vld_out(regslice_both_in_V_keep_V_U_vld_out),
    .ack_out(in_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_in_V_keep_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 64 ))
regslice_both_in_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TSTRB),
    .vld_in(in_r_TVALID),
    .ack_in(regslice_both_in_V_strb_V_U_ack_in),
    .data_out(in_r_TSTRB_int_regslice),
    .vld_out(regslice_both_in_V_strb_V_U_vld_out),
    .ack_out(in_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_in_V_strb_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 1 ))
regslice_both_in_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TLAST),
    .vld_in(in_r_TVALID),
    .ack_in(regslice_both_in_V_last_V_U_ack_in),
    .data_out(in_r_TLAST_int_regslice),
    .vld_out(regslice_both_in_V_last_V_U_vld_out),
    .ack_out(in_r_TREADY_int_regslice),
    .apdone_blk(regslice_both_in_V_last_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 512 ))
regslice_both_out_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TDATA_int_regslice),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(out_r_TREADY_int_regslice),
    .data_out(out_r_TDATA),
    .vld_out(regslice_both_out_V_data_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_V_data_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 64 ))
regslice_both_out_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(out_r_TKEEP_int_regslice),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_V_keep_V_U_ack_in_dummy),
    .data_out(out_r_TKEEP),
    .vld_out(regslice_both_out_V_keep_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_V_keep_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 64 ))
regslice_both_out_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TSTRB_int_regslice),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_V_strb_V_U_ack_in_dummy),
    .data_out(out_r_TSTRB),
    .vld_out(regslice_both_out_V_strb_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_V_strb_V_U_apdone_blk)
);

cmac_tkeep_fix_regslice_both #(
    .DataWidth( 1 ))
regslice_both_out_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(in_r_TLAST_int_regslice),
    .vld_in(out_r_TVALID_int_regslice),
    .ack_in(regslice_both_out_V_last_V_U_ack_in_dummy),
    .data_out(out_r_TLAST),
    .vld_out(regslice_both_out_V_last_V_U_vld_out),
    .ack_out(out_r_TREADY),
    .apdone_blk(regslice_both_out_V_last_V_U_apdone_blk)
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
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        first_strobe <= 1'd1;
    end else begin
        if (((or_ln27_fu_110_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            first_strobe <= in_r_TLAST_int_regslice;
        end
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_r_TDATA_blk_n = in_r_TVALID_int_regslice;
    end else begin
        in_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_r_TREADY_int_regslice = 1'b1;
    end else begin
        in_r_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        out_r_TDATA_blk_n = out_r_TREADY_int_regslice;
    end else begin
        out_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        out_r_TVALID_int_regslice = 1'b1;
    end else begin
        out_r_TVALID_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_out_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((1'b1 == 1'b1) & ((out_r_TREADY_int_regslice == 1'b0) | (in_r_TVALID_int_regslice == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_out_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((1'b1 == 1'b1) & ((out_r_TREADY_int_regslice == 1'b0) | (in_r_TVALID_int_regslice == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter1 == 1'b1) & ((regslice_both_out_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0))) | ((1'b1 == 1'b1) & ((out_r_TREADY_int_regslice == 1'b0) | (in_r_TVALID_int_regslice == 1'b0))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((out_r_TREADY_int_regslice == 1'b0) | (in_r_TVALID_int_regslice == 1'b0));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((regslice_both_out_V_data_V_U_apdone_blk == 1'b1) | (out_r_TREADY_int_regslice == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign in_r_TREADY = regslice_both_in_V_data_V_U_ack_in;

assign or_ln27_fu_110_p2 = (in_r_TLAST_int_regslice | first_strobe);

assign out_r_TKEEP_int_regslice = ((first_strobe[0:0] == 1'b1) ? 64'd18446744073709551615 : in_r_TKEEP_int_regslice);

assign out_r_TVALID = regslice_both_out_V_data_V_U_vld_out;

endmodule //cmac_tkeep_fix
