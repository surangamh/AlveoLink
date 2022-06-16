
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

#ifndef XNIKSYNC_HPP
#define XNIKSYNC_HPP

#include "xnikPktDefs.hpp"

namespace AlveoLink {
namespace kernel {

    typedef enum {
        idle = 0,
        wait_start,
        active,
        state_done
    } SYNC_STATE;

    typedef enum {
        manager_idle = 0,
        idle_2_active,
        manager_active,
        active_2_query,
        query,
        query_2_termination,
        termination,
        termination_2_idle
    } MANAGER_STATE;

    template <unsigned int t_NetDataBits,
              unsigned int t_DestBits>
    class xnikSync_TX {
        public:
            xnikSync_TX() {
#pragma HLS INLINE
                m_state = SYNC_STATE::idle;
                m_myId = 0;
                m_numDevs = 0;
                m_response = true;
                m_batchPkts = 128;
                m_timeOutCycles = 0;
            }
            void process(hls::stream<ap_uint<t_NetDataBits> >& p_nhop2xnikStr, 
                         hls::stream<ap_uint<t_NetDataBits> >& p_rxStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_txStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_outStr) {

                bool l_exit = false;
                bool l_waitSending = false;
                uint32_t l_batchPkts, l_timeOutCycles;
LOOP_NHOP2XNIK:
                while(!l_exit) {
#pragma HLS PIPELINE II=1
                    DvHopCtrlPkt<t_NetDataBits, t_DestBits> l_ctrlPkt;
                    switch(m_state) {
                        case SYNC_STATE::idle:
                            if (l_ctrlPkt.readNB(p_nhop2xnikStr)) { 
                                if (l_ctrlPkt.isConfig()) {
                                    m_myId = l_ctrlPkt.getSrcId();
                                    m_numDevs = l_ctrlPkt.getNumDevs();
                                    m_batchPkts = l_ctrlPkt.getBatchPkts();
                                    m_timeOutCycles = l_ctrlPkt.getTimeOutCycles();
                                    l_batchPkts = m_batchPkts;
                                    l_timeOutCycles = m_timeOutCycles;
                                    l_ctrlPkt.write(p_txStr);
                                    l_ctrlPkt.setSrcId(m_myId);
                                    l_ctrlPkt.setNumDevs(m_numDevs);
                                    l_ctrlPkt.setType(PKT_TYPE::start);
                                    l_ctrlPkt.write2Dest(m_numDevs, p_outStr);
                                    m_state = SYNC_STATE::wait_start;
                                }
                            }
                            break;
                        case SYNC_STATE::wait_start:
                            if (l_ctrlPkt.readNB(p_rxStr)) {
                                if (l_ctrlPkt.isStart()) {//rec start pkt from manager
                                    m_response = true;
                                    m_state = SYNC_STATE::active; 
                                }
                            }
                            break;
                        case SYNC_STATE::active:
                            if (l_ctrlPkt.readNB(p_rxStr)) {
                                if (l_ctrlPkt.isQueryStatus()) {
                                    m_response = true;
                                }
                            }
                            else if (l_waitSending) {
                                if (l_timeOutCycles == 0) {
                                    l_waitSending = false;
                                    l_timeOutCycles = m_timeOutCycles;
                                }
                                else {
                                    l_timeOutCycles = l_timeOutCycles-1;
                                }
                            }
                            else if (l_ctrlPkt.readNB(p_nhop2xnikStr)) {
                                if (l_ctrlPkt.isDoneWork()) {
                                    if (m_response) {
                                        l_ctrlPkt.setSrcId(m_myId);
                                        l_ctrlPkt.setType(PKT_TYPE::done);
                                        l_ctrlPkt.write2Dest(m_numDevs, p_outStr);
                                        m_response = false;
                                    }
                                    l_ctrlPkt.write(p_txStr);
                                    m_state = SYNC_STATE::state_done;
                                }
                                else if (l_ctrlPkt.isWorkload()) {
                                    if (!l_waitSending) {
                                        if (l_batchPkts == 0) {
                                            l_waitSending = true;
                                            l_batchPkts = m_batchPkts;
                                        }
                                        else {
                                            l_batchPkts = l_batchPkts-1;
                                        }
                                        l_ctrlPkt.write(p_outStr);
                                    }
                                }
                            }
                            break;
                        case SYNC_STATE::state_done:
                            if (l_ctrlPkt.readNB(p_rxStr)) {
                                if (l_ctrlPkt.isWorkload()) {
                                    m_state = SYNC_STATE::active;
                                }
                                else if (l_ctrlPkt.isQueryStatus()) {
                                    l_ctrlPkt.setSrcId(m_myId);
                                    l_ctrlPkt.setType(PKT_TYPE::idle_after_done);
                                    l_ctrlPkt.write2Dest(m_numDevs, p_outStr);
                                }
                                else if (l_ctrlPkt.isTerminate()) {
                                    l_exit = true;
                                    m_state = SYNC_STATE::idle;
                                }
                            }
                            else if (l_ctrlPkt.readNB(p_nhop2xnikStr)) {//do nothing, just avoid FIFO block
                                m_state = SYNC_STATE::state_done;
                            }
                            break;
                    }
                }
            }
            
        private:
            SYNC_STATE m_state; 
            ap_uint<t_DestBits> m_myId, m_numDevs;
            bool m_response;
            uint32_t m_batchPkts;
            uint32_t m_timeOutCycles;
    };

    template <unsigned int t_NetDataBits,
              unsigned int t_DestBits>
    class xnikSync_RX {
        public: 
            xnikSync_RX() {
#pragma HLS INLINE
                m_state = SYNC_STATE::idle;
                m_myId = 0;
            }
            void process(hls::stream<ap_uint<t_NetDataBits>  >& p_inStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_txStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_rxStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_xnik2nhopStr) {
                bool l_exit = false;
LOOP_XNIK2NHOP:
                while (!l_exit) {
#pragma HLS PIPELINE II=1
                    DvHopCtrlPkt<t_NetDataBits, t_DestBits> l_ctrlPkt;
                    switch (m_state) {
                        case SYNC_STATE::idle:
                            if (l_ctrlPkt.readNB(p_txStr)) {//should only receive cfg pkt from txStr
                                m_myId = l_ctrlPkt.getSrcId();
                                m_state = SYNC_STATE::wait_start;
                            }
                            else if (l_ctrlPkt.readNB(p_inStr)) {
                                m_state = SYNC_STATE::idle;
                            } 
                        break;
                        case SYNC_STATE::wait_start:
                            if (l_ctrlPkt.readNB(p_inStr)) {
                                if (l_ctrlPkt.isStart()) {
                                    l_ctrlPkt.write(p_rxStr);
                                    m_state = SYNC_STATE::active;
                                }
                                else {
                                    l_ctrlPkt.write(p_xnik2nhopStr);
                                }
                            }
                            break;
                        case SYNC_STATE::active:
                            if (l_ctrlPkt.readNB(p_inStr)) {
                                if (l_ctrlPkt.isQueryStatus()) {
                                    l_ctrlPkt.write(p_rxStr);
                                }
                                else if (l_ctrlPkt.isWorkload()) {
                                    l_ctrlPkt.write(p_xnik2nhopStr);
                                }
                            }
                            else if (l_ctrlPkt.readNB(p_txStr)) {
                                if (l_ctrlPkt.isDoneWork()) {
                                    m_state = SYNC_STATE::state_done;
                                }
                            }
                        break;
                        case SYNC_STATE::state_done:
                            if (l_ctrlPkt.readNB(p_inStr)) {
                                l_ctrlPkt.write(p_rxStr);
                                if (l_ctrlPkt.isWorkload()) {
                                    l_ctrlPkt.write(p_xnik2nhopStr);
                                    m_state = SYNC_STATE::active;
                                }
                                else { //pkt is query_status or terminate
                                    if (l_ctrlPkt.isTerminate()) {
                                        l_ctrlPkt.setType(PKT_TYPE::done);
                                        l_ctrlPkt.write(p_xnik2nhopStr);
                                        l_exit = true;
                                        m_state = SYNC_STATE::idle;
                                    }
                                }
                            }
                        break;
                    }
                    
                }
            }
        private:
            SYNC_STATE m_state; 
            ap_uint<t_DestBits> m_myId;
    };
    
    template <unsigned int t_NetDataBits,
              unsigned int t_DestBits,
              unsigned int t_MaxConnections=16>
    class xnikSync_Manager {
        public:
            xnikSync_Manager() {
                m_state = MANAGER_STATE::manager_idle;
                m_numDevs = 1;
                m_waitCycles = 0;
                m_flushCounter = 1;
                m_recStatus = -1;
            }
            void recAllPkts(const PKT_TYPE p_pktType, hls::stream<ap_uint<t_NetDataBits> >& p_inStr) {
                m_recStatus(m_numDevs-1, 0) = 0;
                bool l_exit = m_recStatus.and_reduce();
LOOP_MANAGER_RECALL:
                while (!l_exit) {
#pragma HLS PIPELINE II=1
                    DvHopCtrlPkt<t_NetDataBits, t_DestBits> l_ctrlPkt;
                    l_ctrlPkt.read(p_inStr);
                    if (l_ctrlPkt.getType() == p_pktType) {
                        ap_uint<t_DestBits> l_srcId = l_ctrlPkt.getSrcId();
                        m_recStatus[l_srcId] = 1;
                    }
                    l_exit =  m_recStatus.and_reduce();
                }
            }
            void recAllDonePkts(hls::stream<ap_uint<t_NetDataBits> >& p_inStr, bool& p_allIdle) {
                m_recStatus(m_numDevs-1, 0) = 0;
                p_allIdle = true;
                bool l_exit = m_recStatus.and_reduce();
LOOP_MANAGER_RECALLDONE:
                while (!l_exit) {
#pragma HLS PIPELINE II=1
                    DvHopCtrlPkt<t_NetDataBits, t_DestBits> l_ctrlPkt;
                     l_ctrlPkt.read(p_inStr);
                    if ((l_ctrlPkt.getType() == PKT_TYPE::done) || (l_ctrlPkt.getType() == PKT_TYPE::idle_after_done)) {
                        ap_uint<t_DestBits> l_srcId = l_ctrlPkt.getSrcId();
                        m_recStatus[l_srcId] = 1;
                        if (l_ctrlPkt.getType() == PKT_TYPE::done) {
                            p_allIdle = false;
                        }
                    }
                    l_exit =  m_recStatus.and_reduce();
                }
            }
            void sendAllPkts(const PKT_TYPE p_pktType, hls::stream<ap_uint<t_NetDataBits> >& p_outStr) {
LOOP_MANAGER_SENDALL:
                for (unsigned int i=0; i<m_numDevs; ++i) {
#pragma HLS PIPELINE II=1
                    DvHopCtrlPkt<t_NetDataBits, t_DestBits> l_ctrlPkt;
                    l_ctrlPkt.setType(p_pktType);
                    l_ctrlPkt.setDest(i);
                    l_ctrlPkt.write(p_outStr);
                }
            }

            void process(uint16_t* p_config,
                         hls::stream<ap_uint<t_NetDataBits> >& p_inStr,
                         hls::stream<ap_uint<t_NetDataBits> >& p_outStr) {

                    m_numDevs = p_config[0];
                    m_waitCycles = p_config[1];
                    m_flushCounter = p_config[2];
                    uint16_t l_flushCounter;
                    bool l_allIdle =true;
                    bool l_procExit = false;
                    uint16_t l_cycleCounter;
LOOP_MANAGER:
                    while (!l_procExit) {
                        switch (m_state) {
                            case MANAGER_STATE::manager_idle:
                                recAllPkts(PKT_TYPE::start, p_inStr);
                                m_state = MANAGER_STATE::idle_2_active;
                                break;
                            case MANAGER_STATE::idle_2_active:
                                sendAllPkts(PKT_TYPE::start, p_outStr);
                                m_state = MANAGER_STATE::manager_active;
                                break;
                            case MANAGER_STATE::manager_active:
                                recAllDonePkts(p_inStr, l_allIdle);
                                m_state = MANAGER_STATE::active_2_query;
                                break;
                            case MANAGER_STATE::active_2_query:
                                sendAllPkts(PKT_TYPE::query_status, p_outStr);
                                m_state = MANAGER_STATE::query;
                                break;
                            case MANAGER_STATE::query:
                                recAllDonePkts(p_inStr, l_allIdle);
                                m_state = MANAGER_STATE::query_2_termination;
                                break;
                            case MANAGER_STATE::query_2_termination:
                                sendAllPkts(PKT_TYPE::query_status, p_outStr);
                                if (l_allIdle) {
                                    l_cycleCounter = m_waitCycles;
                                    l_flushCounter = m_flushCounter;
                                    m_state = MANAGER_STATE::termination;
                                }
                                else {
                                    m_state = MANAGER_STATE::query;
                                }
                                break;
                            case MANAGER_STATE::termination:
                                recAllDonePkts(p_inStr, l_allIdle);
                                m_state = MANAGER_STATE::termination_2_idle;
                                break;
                            case MANAGER_STATE::termination_2_idle:
                                if (l_allIdle && (l_flushCounter == 0)) {
                                    sendAllPkts(PKT_TYPE::terminate, p_outStr);
                                    l_procExit = true;
                                    m_state = MANAGER_STATE::manager_idle;
                                }
                                else if (l_allIdle && (l_cycleCounter == 0)) {
                                    sendAllPkts(PKT_TYPE::query_status, p_outStr);
                                    l_flushCounter--;
                                    m_state = MANAGER_STATE::termination;
                                }
                                else if (l_allIdle && (l_cycleCounter != 0)) {
                                    l_cycleCounter--;
                                    m_state = MANAGER_STATE::termination_2_idle;
                                }
                                else {
                                    sendAllPkts(PKT_TYPE::query_status, p_outStr);
                                    m_state = MANAGER_STATE::query;
                                }
                                break;
                        }
                    }
            }

        private:
            MANAGER_STATE m_state;
            uint16_t m_numDevs;
            uint16_t m_waitCycles;
            uint16_t m_flushCounter;
            ap_uint<t_MaxConnections> m_recStatus; 
    };
    
}
}
#endif
