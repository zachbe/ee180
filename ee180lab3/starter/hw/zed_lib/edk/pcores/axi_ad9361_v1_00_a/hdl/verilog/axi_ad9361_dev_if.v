// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// This interface includes both the transmit and receive components -
// They both uses the same clock (sourced from the receiving side).

`timescale 1ns/100ps

module axi_ad9361_dev_if (

  // physical interface (receive)

  rx_clk_in_p,
  rx_clk_in_n,
  rx_frame_in_p,
  rx_frame_in_n,
  rx_data_in_p,
  rx_data_in_n,

  // physical interface (transmit)

  tx_clk_out_p,
  tx_clk_out_n,
  tx_frame_out_p,
  tx_frame_out_n,
  tx_data_out_p,
  tx_data_out_n,

  // clock (common to both receive and transmit)

  clk,

  // receive data path interface

  adc_valid,
  adc_data_i1,
  adc_data_q1,
  adc_data_i2,
  adc_data_q2,
  adc_status,
  adc_r1_mode,

  // transmit data path interface

  dac_valid,
  dac_data_i1,
  dac_data_q1,
  dac_data_i2,
  dac_data_q2,
  dac_r1_mode,

  // delay control signals

  delay_clk,
  delay_rst,
  delay_sel,
  delay_rwn,
  delay_addr,
  delay_wdata,
  delay_rdata,
  delay_ack_t,
  delay_locked,

  // chipscope signals

  dev_dbg_trigger,
  dev_dbg_data);

  // this parameter controls the buffer type based on the target device.

  parameter   PCORE_BUFTYPE = 0;
  parameter   PCORE_IODELAY_GROUP = "dev_if_delay_group";
  localparam  PCORE_7SERIES = 0;
  localparam  PCORE_VIRTEX6 = 1;

  // physical interface (receive)

  input           rx_clk_in_p;
  input           rx_clk_in_n;
  input           rx_frame_in_p;
  input           rx_frame_in_n;
  input   [ 5:0]  rx_data_in_p;
  input   [ 5:0]  rx_data_in_n;

  // physical interface (transmit)

  output          tx_clk_out_p;
  output          tx_clk_out_n;
  output          tx_frame_out_p;
  output          tx_frame_out_n;
  output  [ 5:0]  tx_data_out_p;
  output  [ 5:0]  tx_data_out_n;

  // clock (common to both receive and transmit)

  output          clk;

  // receive data path interface

  output          adc_valid;
  output  [11:0]  adc_data_i1;
  output  [11:0]  adc_data_q1;
  output  [11:0]  adc_data_i2;
  output  [11:0]  adc_data_q2;
  output          adc_status;
  input           adc_r1_mode;

  // transmit data path interface

  input           dac_valid;
  input   [11:0]  dac_data_i1;
  input   [11:0]  dac_data_q1;
  input   [11:0]  dac_data_i2;
  input   [11:0]  dac_data_q2;
  input           dac_r1_mode;

  // delay control signals

  input           delay_clk;
  input           delay_rst;
  input           delay_sel;
  input           delay_rwn;
  input   [ 7:0]  delay_addr;
  input   [ 4:0]  delay_wdata;
  output  [ 4:0]  delay_rdata;
  output          delay_ack_t;
  output          delay_locked;

  // chipscope signals

  output  [ 3:0]  dev_dbg_trigger;
  output [297:0]  dev_dbg_data;

  // internal registers

  reg     [ 5:0]  rx_data_n = 'd0;
  reg             rx_frame_n = 'd0;
  reg     [11:0]  rx_data = 'd0;
  reg     [ 1:0]  rx_frame = 'd0;
  reg     [11:0]  rx_data_d = 'd0;
  reg     [ 1:0]  rx_frame_d = 'd0;
  reg             rx_error_r1 = 'd0;
  reg             rx_valid_r1 = 'd0;
  reg     [11:0]  rx_data_i_r1 = 'd0;
  reg     [11:0]  rx_data_q_r1 = 'd0;
  reg             rx_error_r2 = 'd0;
  reg             rx_valid_r2 = 'd0;
  reg     [11:0]  rx_data_i1_r2 = 'd0;
  reg     [11:0]  rx_data_q1_r2 = 'd0;
  reg     [11:0]  rx_data_i2_r2 = 'd0;
  reg     [11:0]  rx_data_q2_r2 = 'd0;
  reg             adc_valid = 'd0;
  reg     [11:0]  adc_data_i1 = 'd0;
  reg     [11:0]  adc_data_q1 = 'd0;
  reg     [11:0]  adc_data_i2 = 'd0;
  reg     [11:0]  adc_data_q2 = 'd0;
  reg             adc_status = 'd0;
  reg     [ 2:0]  tx_data_cnt = 'd0;
  reg     [11:0]  tx_data_i1_d = 'd0;
  reg     [11:0]  tx_data_q1_d = 'd0;
  reg     [11:0]  tx_data_i2_d = 'd0;
  reg     [11:0]  tx_data_q2_d = 'd0;
  reg             tx_frame = 'd0;
  reg     [ 5:0]  tx_data_p = 'd0;
  reg     [ 5:0]  tx_data_n = 'd0;
  reg     [ 6:0]  delay_ld = 'd0;
  reg     [ 4:0]  delay_rdata = 'd0;
  reg             delay_ack_t = 'd0;

  // internal signals

  wire    [ 3:0]  rx_frame_s;
  wire    [ 3:0]  tx_data_sel_s;
  wire    [ 4:0]  delay_rdata_s[6:0];
  wire    [ 5:0]  rx_data_ibuf_s;
  wire    [ 5:0]  rx_data_idelay_s;
  wire    [ 5:0]  rx_data_p_s;
  wire    [ 5:0]  rx_data_n_s;
  wire            rx_frame_ibuf_s;
  wire            rx_frame_idelay_s;
  wire            rx_frame_p_s;
  wire            rx_frame_n_s;
  wire    [ 5:0]  tx_data_oddr_s;
  wire            tx_frame_oddr_s;
  wire            tx_clk_oddr_s;
  wire            clk_ibuf_s;

  genvar          l_inst;

  // device debug signals

  assign dev_dbg_trigger[0] = rx_frame[0];
  assign dev_dbg_trigger[1] = rx_frame[1];
  assign dev_dbg_trigger[2] = tx_frame;
  assign dev_dbg_trigger[3] = adc_status;

  assign dev_dbg_data[  5:  0] = tx_data_n;
  assign dev_dbg_data[ 11:  6] = tx_data_p;
  assign dev_dbg_data[ 23: 12] = tx_data_i1_d;
  assign dev_dbg_data[ 35: 24] = tx_data_q1_d;
  assign dev_dbg_data[ 47: 36] = tx_data_i2_d;
  assign dev_dbg_data[ 59: 48] = tx_data_q2_d;
  assign dev_dbg_data[ 63: 60] = tx_data_sel_s;
  assign dev_dbg_data[ 66: 64] = tx_data_cnt;
  assign dev_dbg_data[ 67: 67] = tx_frame;
  assign dev_dbg_data[ 68: 68] = dac_r1_mode;
  assign dev_dbg_data[ 69: 69] = dac_valid;
  assign dev_dbg_data[ 81: 70] = dac_data_i1;
  assign dev_dbg_data[ 93: 82] = dac_data_q1;
  assign dev_dbg_data[105: 94] = dac_data_i2;
  assign dev_dbg_data[117:106] = dac_data_q2;
  assign dev_dbg_data[118:118] = rx_frame_p_s;
  assign dev_dbg_data[119:119] = rx_frame_n_s;
  assign dev_dbg_data[120:120] = rx_frame_n;
  assign dev_dbg_data[122:121] = rx_frame;
  assign dev_dbg_data[124:123] = rx_frame_d;
  assign dev_dbg_data[128:125] = rx_frame_s;
  assign dev_dbg_data[134:129] = rx_data_p_s;
  assign dev_dbg_data[140:135] = rx_data_n_s;
  assign dev_dbg_data[146:141] = rx_data_n;
  assign dev_dbg_data[158:147] = rx_data;
  assign dev_dbg_data[170:159] = rx_data_d;
  assign dev_dbg_data[171:171] = rx_error_r1;
  assign dev_dbg_data[172:172] = rx_valid_r1;
  assign dev_dbg_data[184:173] = rx_data_i_r1;
  assign dev_dbg_data[196:185] = rx_data_q_r1;
  assign dev_dbg_data[197:197] = rx_error_r2;
  assign dev_dbg_data[198:198] = rx_valid_r2;
  assign dev_dbg_data[210:199] = rx_data_i1_r2;
  assign dev_dbg_data[222:211] = rx_data_q1_r2;
  assign dev_dbg_data[234:223] = rx_data_i2_r2;
  assign dev_dbg_data[246:235] = rx_data_q2_r2;
  assign dev_dbg_data[247:247] = adc_r1_mode;
  assign dev_dbg_data[248:248] = adc_status;
  assign dev_dbg_data[249:249] = adc_valid;
  assign dev_dbg_data[261:250] = adc_data_i1;
  assign dev_dbg_data[273:262] = adc_data_q1;
  assign dev_dbg_data[285:274] = adc_data_i2;
  assign dev_dbg_data[297:286] = adc_data_q2;

  // receive data path interface

  assign rx_frame_s = {rx_frame_d, rx_frame};

  always @(posedge clk) begin
    rx_data_n <= rx_data_n_s;
    rx_frame_n <= rx_frame_n_s;
    rx_data <= {rx_data_n, rx_data_p_s};
    rx_frame <= {rx_frame_n, rx_frame_p_s};
    rx_data_d <= rx_data;
    rx_frame_d <= rx_frame;
  end

  // receive data path for single rf, frame is expected to qualify i/q msb only

  always @(posedge clk) begin
    rx_error_r1 <= ((rx_frame_s == 4'b1100) || (rx_frame_s == 4'b0011)) ? 1'b0 : 1'b1;
    rx_valid_r1 <= (rx_frame_s == 4'b1100) ? 1'b1 : 1'b0;
    if (rx_frame_s == 4'b1100) begin
      rx_data_i_r1 <= {rx_data_d[11:6], rx_data[11:6]};
      rx_data_q_r1 <= {rx_data_d[ 5:0], rx_data[ 5:0]};
    end
  end

  // receive data path for dual rf, frame is expected to qualify i/q msb and lsb for rf-1 only

  always @(posedge clk) begin
    rx_error_r2 <= ((rx_frame_s == 4'b1111) || (rx_frame_s == 4'b1100) ||
      (rx_frame_s == 4'b0000) || (rx_frame_s == 4'b0011)) ? 1'b0 : 1'b1;
    rx_valid_r2 <= (rx_frame_s == 4'b0000) ? 1'b1 : 1'b0;
    if (rx_frame_s == 4'b1111) begin
      rx_data_i1_r2 <= {rx_data_d[11:6], rx_data[11:6]};
      rx_data_q1_r2 <= {rx_data_d[ 5:0], rx_data[ 5:0]};
    end
    if (rx_frame_s == 4'b0000) begin
      rx_data_i2_r2 <= {rx_data_d[11:6], rx_data[11:6]};
      rx_data_q2_r2 <= {rx_data_d[ 5:0], rx_data[ 5:0]};
    end
  end

  // receive data path mux

  always @(posedge clk) begin
    if (adc_r1_mode == 1'b1) begin
      adc_valid <= rx_valid_r1;
      adc_data_i1 <= rx_data_i_r1;
      adc_data_q1 <= rx_data_q_r1;
      adc_data_i2 <= 12'd0;
      adc_data_q2 <= 12'd0;
      adc_status <= ~rx_error_r1;
    end else begin
      adc_valid <= rx_valid_r2;
      adc_data_i1 <= rx_data_i1_r2;
      adc_data_q1 <= rx_data_q1_r2;
      adc_data_i2 <= rx_data_i2_r2;
      adc_data_q2 <= rx_data_q2_r2;
      adc_status <= ~rx_error_r2;
    end
  end

  // transmit data path mux (reverse of what receive does above)
  // the count simply selets the data muxing on the ddr outputs

  assign tx_data_sel_s = {tx_data_cnt[2], dac_r1_mode, tx_data_cnt[1:0]};

  always @(posedge clk) begin
    if (dac_valid == 1'b1) begin
      tx_data_cnt <= 3'b100;
    end else if (tx_data_cnt[2] == 1'b1) begin
      tx_data_cnt <= tx_data_cnt + 1'b1;
    end
    if (dac_valid == 1'b1) begin
      tx_data_i1_d <= dac_data_i1;
      tx_data_q1_d <= dac_data_q1;
      tx_data_i2_d <= dac_data_i2;
      tx_data_q2_d <= dac_data_q2;
    end
    case (tx_data_sel_s)
      4'b1111: begin
        tx_frame <= 1'b0;
        tx_data_p <= tx_data_i1_d[ 5:0];
        tx_data_n <= tx_data_q1_d[ 5:0];
      end
      4'b1110: begin
        tx_frame <= 1'b1;
        tx_data_p <= tx_data_i1_d[11:6];
        tx_data_n <= tx_data_q1_d[11:6];
      end
      4'b1101: begin
        tx_frame <= 1'b0;
        tx_data_p <= tx_data_i1_d[ 5:0];
        tx_data_n <= tx_data_q1_d[ 5:0];
      end
      4'b1100: begin
        tx_frame <= 1'b1;
        tx_data_p <= tx_data_i1_d[11:6];
        tx_data_n <= tx_data_q1_d[11:6];
      end
      4'b1011: begin
        tx_frame <= 1'b0;
        tx_data_p <= tx_data_i2_d[ 5:0];
        tx_data_n <= tx_data_q2_d[ 5:0];
      end
      4'b1010: begin
        tx_frame <= 1'b0;
        tx_data_p <= tx_data_i2_d[11:6];
        tx_data_n <= tx_data_q2_d[11:6];
      end
      4'b1001: begin
        tx_frame <= 1'b1;
        tx_data_p <= tx_data_i1_d[ 5:0];
        tx_data_n <= tx_data_q1_d[ 5:0];
      end
      4'b1000: begin
        tx_frame <= 1'b1;
        tx_data_p <= tx_data_i1_d[11:6];
        tx_data_n <= tx_data_q1_d[11:6];
      end
      default: begin
        tx_frame <= 1'b0;
        tx_data_p <= 6'd0;
        tx_data_n <= 6'd0;
      end
    endcase
  end

  // delay write interface, each delay element can be individually
  // addressed, and a delay value can be directly loaded (no inc/dec stuff)

  always @(posedge delay_clk) begin
    if ((delay_sel == 1'b1) && (delay_rwn == 1'b0)) begin
      case (delay_addr)
        8'h06: delay_ld <= 7'h40;
        8'h05: delay_ld <= 7'h20;
        8'h04: delay_ld <= 7'h10;
        8'h03: delay_ld <= 7'h08;
        8'h02: delay_ld <= 7'h04;
        8'h01: delay_ld <= 7'h02;
        8'h00: delay_ld <= 7'h01;
        default: delay_ld <= 7'h00;
      endcase
    end else begin
      delay_ld <= 7'h00;
    end
  end

  // delay read interface, a delay ack toggle is used to transfer data to the
  // processor side- delay locked is independently transferred

  always @(posedge delay_clk) begin
    case (delay_addr)
      8'h06: delay_rdata <= delay_rdata_s[6];
      8'h05: delay_rdata <= delay_rdata_s[5];
      8'h04: delay_rdata <= delay_rdata_s[4];
      8'h03: delay_rdata <= delay_rdata_s[3];
      8'h02: delay_rdata <= delay_rdata_s[2];
      8'h01: delay_rdata <= delay_rdata_s[1];
      8'h00: delay_rdata <= delay_rdata_s[0];
      default: delay_rdata <= 5'd0;
    endcase
    if (delay_sel == 1'b1) begin
      delay_ack_t <= ~delay_ack_t;
    end
  end

  // delay controller

  (* IODELAY_GROUP = PCORE_IODELAY_GROUP *)
  IDELAYCTRL i_delay_ctrl (
    .RST (delay_rst),
    .REFCLK (delay_clk),
    .RDY (delay_locked));

  // receive data interface, ibuf -> idelay -> iddr

  generate
  for (l_inst = 0; l_inst <= 5; l_inst = l_inst + 1) begin: g_rx_data

  IBUFDS i_rx_data_ibuf (
    .I (rx_data_in_p[l_inst]),
    .IB (rx_data_in_n[l_inst]),
    .O (rx_data_ibuf_s[l_inst]));

  if (PCORE_BUFTYPE == PCORE_VIRTEX6) begin
  (* IODELAY_GROUP = PCORE_IODELAY_GROUP *)
  IODELAYE1 #(
    .CINVCTRL_SEL ("FALSE"),
    .DELAY_SRC ("I"),
    .HIGH_PERFORMANCE_MODE ("TRUE"),
    .IDELAY_TYPE ("VAR_LOADABLE"),
    .IDELAY_VALUE (0),
    .ODELAY_TYPE ("FIXED"),
    .ODELAY_VALUE (0),
    .REFCLK_FREQUENCY (200.0),
    .SIGNAL_PATTERN ("DATA"))
  i_rx_data_idelay (
    .T (1'b1),
    .CE (1'b0),
    .INC (1'b0),
    .CLKIN (1'b0),
    .DATAIN (1'b0),
    .ODATAIN (1'b0),
    .CINVCTRL (1'b0),
    .C (delay_clk),
    .IDATAIN (rx_data_ibuf_s[l_inst]),
    .DATAOUT (rx_data_idelay_s[l_inst]),
    .RST (delay_ld[l_inst]),
    .CNTVALUEIN (delay_wdata),
    .CNTVALUEOUT (delay_rdata_s[l_inst]));
  end else begin
  (* IODELAY_GROUP = PCORE_IODELAY_GROUP *)
  IDELAYE2 #(
    .CINVCTRL_SEL ("FALSE"),
    .DELAY_SRC ("IDATAIN"),
    .HIGH_PERFORMANCE_MODE ("FALSE"),
    .IDELAY_TYPE ("VAR_LOAD"),
    .IDELAY_VALUE (0),
    .REFCLK_FREQUENCY (200.0),
    .PIPE_SEL ("FALSE"),
    .SIGNAL_PATTERN ("DATA"))
  i_rx_data_idelay (
    .CE (1'b0),
    .INC (1'b0),
    .DATAIN (1'b0),
    .LDPIPEEN (1'b0),
    .CINVCTRL (1'b0),
    .REGRST (1'b0),
    .C (delay_clk),
    .IDATAIN (rx_data_ibuf_s[l_inst]),
    .DATAOUT (rx_data_idelay_s[l_inst]),
    .LD (delay_ld[l_inst]),
    .CNTVALUEIN (delay_wdata),
    .CNTVALUEOUT (delay_rdata_s[l_inst]));
  end

  IDDR #(
    .DDR_CLK_EDGE ("SAME_EDGE_PIPELINED"),
    .INIT_Q1 (1'b0),
    .INIT_Q2 (1'b0),
    .SRTYPE ("ASYNC"))
  i_rx_data_iddr (
    .CE (1'b1),
    .R (1'b0),
    .S (1'b0),
    .C (clk),
    .D (rx_data_idelay_s[l_inst]),
    .Q1 (rx_data_p_s[l_inst]),
    .Q2 (rx_data_n_s[l_inst]));

  end
  endgenerate

  // receive frame interface, ibuf -> idelay -> iddr

  IBUFDS i_rx_frame_ibuf (
    .I (rx_frame_in_p),
    .IB (rx_frame_in_n),
    .O (rx_frame_ibuf_s));

  generate
  if (PCORE_BUFTYPE == PCORE_VIRTEX6) begin
  (* IODELAY_GROUP = PCORE_IODELAY_GROUP *)
  IODELAYE1 #(
    .CINVCTRL_SEL ("FALSE"),
    .DELAY_SRC ("I"),
    .HIGH_PERFORMANCE_MODE ("TRUE"),
    .IDELAY_TYPE ("VAR_LOADABLE"),
    .IDELAY_VALUE (0),
    .ODELAY_TYPE ("FIXED"),
    .ODELAY_VALUE (0),
    .REFCLK_FREQUENCY (200.0),
    .SIGNAL_PATTERN ("DATA"))
  i_rx_frame_idelay (
    .T (1'b1),
    .CE (1'b0),
    .INC (1'b0),
    .CLKIN (1'b0),
    .DATAIN (1'b0),
    .ODATAIN (1'b0),
    .CINVCTRL (1'b0),
    .C (delay_clk),
    .IDATAIN (rx_frame_ibuf_s),
    .DATAOUT (rx_frame_idelay_s),
    .RST (delay_ld[6]),
    .CNTVALUEIN (delay_wdata),
    .CNTVALUEOUT (delay_rdata_s[6]));
  end else begin
  (* IODELAY_GROUP = PCORE_IODELAY_GROUP *)
  IDELAYE2 #(
    .CINVCTRL_SEL ("FALSE"),
    .DELAY_SRC ("IDATAIN"),
    .HIGH_PERFORMANCE_MODE ("FALSE"),
    .IDELAY_TYPE ("VAR_LOAD"),
    .IDELAY_VALUE (0),
    .REFCLK_FREQUENCY (200.0),
    .PIPE_SEL ("FALSE"),
    .SIGNAL_PATTERN ("DATA"))
  i_rx_frame_idelay (
    .CE (1'b0),
    .INC (1'b0),
    .DATAIN (1'b0),
    .LDPIPEEN (1'b0),
    .CINVCTRL (1'b0),
    .REGRST (1'b0),
    .C (delay_clk),
    .IDATAIN (rx_frame_ibuf_s),
    .DATAOUT (rx_frame_idelay_s),
    .LD (delay_ld[6]),
    .CNTVALUEIN (delay_wdata),
    .CNTVALUEOUT (delay_rdata_s[6]));
  end
  endgenerate

  IDDR #(
    .DDR_CLK_EDGE ("SAME_EDGE_PIPELINED"),
    .INIT_Q1 (1'b0),
    .INIT_Q2 (1'b0),
    .SRTYPE ("ASYNC"))
  i_rx_frame_iddr (
    .CE (1'b1),
    .R (1'b0),
    .S (1'b0),
    .C (clk),
    .D (rx_frame_idelay_s),
    .Q1 (rx_frame_p_s),
    .Q2 (rx_frame_n_s));

  // transmit data interface, oddr -> obuf

  generate
  for (l_inst = 0; l_inst <= 5; l_inst = l_inst + 1) begin: g_tx_data

  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT (1'b0),
    .SRTYPE ("ASYNC"))
  i_tx_data_oddr (
    .CE (1'b1),
    .R (1'b0),
    .S (1'b0),
    .C (clk),
    .D1 (tx_data_p[l_inst]),
    .D2 (tx_data_n[l_inst]),
    .Q (tx_data_oddr_s[l_inst]));

  OBUFDS i_tx_data_obuf (
    .I (tx_data_oddr_s[l_inst]),
    .O (tx_data_out_p[l_inst]),
    .OB (tx_data_out_n[l_inst]));

  end
  endgenerate

  // transmit frame interface, oddr -> obuf

  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT (1'b0),
    .SRTYPE ("ASYNC"))
  i_tx_frame_oddr (
    .CE (1'b1),
    .R (1'b0),
    .S (1'b0),
    .C (clk),
    .D1 (tx_frame),
    .D2 (tx_frame),
    .Q (tx_frame_oddr_s));

  OBUFDS i_tx_frame_obuf (
    .I (tx_frame_oddr_s),
    .O (tx_frame_out_p),
    .OB (tx_frame_out_n));

  // transmit clock interface, oddr -> obuf

  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT (1'b0),
    .SRTYPE ("ASYNC"))
  i_tx_clk_oddr (
    .CE (1'b1),
    .R (1'b0),
    .S (1'b0),
    .C (clk),
    .D1 (1'b0),
    .D2 (1'b1),
    .Q (tx_clk_oddr_s));

  OBUFDS i_tx_clk_obuf (
    .I (tx_clk_oddr_s),
    .O (tx_clk_out_p),
    .OB (tx_clk_out_n));

  // device clock interface (receive clock)

  IBUFGDS i_rx_clk_ibuf (
    .I (rx_clk_in_p),
    .IB (rx_clk_in_n),
    .O (clk_ibuf_s));

  BUFG i_clk_gbuf (
    .I (clk_ibuf_s),
    .O (clk));

endmodule

// ***************************************************************************
// ***************************************************************************
