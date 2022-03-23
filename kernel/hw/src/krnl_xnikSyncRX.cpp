
/*
 * Copyright 2019-2022 Xilinx, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include "hw/interface.hpp"
#include "xnikSync.hpp"

typedef typename AlveoLink::kernel::HopCtrlPkt<XANS_netDataBits, XANS_destBits>::TypeAXIS UdpPktType;

extern "C" void krnl_xnikSyncRX(hls::stream<UdpPktType>& p_inStr,
                                 hls::stream<ap_uint<XANS_netDataBits> >& p_txStr,
                                 hls::stream<ap_uint<XANS_netDataBits> >& p_rxStr,
                                 hls::stream<ap_uint<XANS_netDataBits> >& p_xnik2nhopStr) {
    AXIS(p_inStr)
    AXIS(p_txStr)
    AXIS(p_rxStr)
    AXIS(p_xnik2nhopStr)
    AP_CTRL_NONE(return)

    AlveoLink::kernel::xnikSync_RX<XANS_netDataBits, XANS_destBits> l_xnikSyncRX;
    l_xnikSyncRX.process(p_inStr, p_txStr, p_rxStr, p_xnik2nhopStr);
}
