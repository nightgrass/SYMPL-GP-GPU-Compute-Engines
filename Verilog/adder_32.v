 `timescale 1ns/100ps

// Adder module for SYMPL GP-GPU Compute Engine.  
// Author:  Jerry D. Harthcock
// Version:  1.02  Dec. 12, 2015
// Copyright (C) 2014-2016.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                //
//             SYMPL 32-BIT RISC, COARSE-GRAINED SCHEDULER (CGS) and GP-GPU SHADER IP CORES                       //
//                              Evaluation and Product Development License                                        //
//                                                                                                                //
// Provided that you comply with all the terms and conditions set forth herein, Jerry D. Harthcock ("licensor"),  //
// the original author and exclusive copyright owner of these SYMPL 32-BIT RISC, COARSE-GRAINED SCHEDULER (CGS)   //
// and GP-GPU SHADER Verilog RTL IP cores and related development software ("this IP")  hereby grants             //
// to recipient of this IP ("licensee"), a world-wide, paid-up, non-exclusive license to implement this IP in     //
// Xilinx, Altera, MicroSemi or Lattice Semiconductor brand FPGAs only and used for the purposes of evaluation,   //
// education, and development of end products and related development tools only.  Furthermore, limited to the    //
// the purposes of prototyping, evaluation, characterization and testing of their implementation in a hard,       //
// custom or semi-custom ASIC, any university or institution of higher education may have their implementation of //
// this IP produced for said limited purposes at any foundary of their choosing provided that such prototypes do  //
// not ever wind up in commercial circulation with such license extending to said foundary and is in connection   //
// with said academic pursuit and under the supervision of said university or institution of higher education.    //
//                                                                                                                //
// Any customization, modification, or derivative work of this IP must include an exact copy of this license      //
// and original copyright notice at the very top of each source file and derived netlist, and, in the case of     //
// binaries, a printed copy of this license and/or a text format copy in a separate file distributed with said    //
// netlists or binary files having the file name, "LICENSE.txt".  You, the licensee, also agree not to remove     //
// any copyright notices from any source file covered under this Evaluation and Product Development License.      //
//                                                                                                                //
// LICENSOR DOES NOT WARRANT OR GUARANTEE THAT YOUR USE OF THIS IP WILL NOT INFRINGE THE RIGHTS OF OTHERS OR      //
// THAT IT IS SUITABLE OR FIT FOR ANY PURPOSE AND THAT YOU, THE LICENSEE, AGREE TO HOLD LICENSOR HARMLESS FROM    //
// ANY CLAIM BROUGHT BY YOU OR ANY THIRD PARTY FOR YOUR SUCH USE.                                                 //
//                                                                                                                //
// Licensor reserves all his rights without prejudice, including, but in no way limited to, the right to change   //
// or modify the terms and conditions of this Evaluation and Product Development License anytime without notice   //
// of any kind to anyone. By using this IP for any purpose, you agree to all the terms and conditions set forth   //
// in this Evaluation and Product Development License.                                                            //
//                                                                                                                //
// This Evaluation and Product Development License does not include the right to sell products that incorporate   //
// this IP, any IP derived from this IP.  If you would like to obtain such a license, please contact Licensor.    //
//                                                                                                                //
// Licensor can be contacted at:  SYMPL.gpu@gmail.com                                                             //
//                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ADDER_32 (
              SUBTRACT,
              TERM_A,     
              TERM_B, 
              CI,         // carry in
              ADDER_OUT,  // adder out
              CO,         // carry out
              HCO,        // half carry out (aka aux. carry)
              OVO,
              ZERO);      // overflow out

input         SUBTRACT;
input  [31:0] TERM_A;
input  [31:0] TERM_B;
input         CI;
output [31:0] ADDER_OUT;
output        CO;
output        HCO;
output        OVO;
output        ZERO;

wire   [31:0] ADDER_OUT;
wire          CO;
wire          CO30;
wire          HCO;
wire          OVO;
wire          ZERO;
wire          CIS;
wire          HC;
wire          C;


wire          MSB;
wire   [26:0] HI_NYBS;
wire    [3:0] LO_NYB;
wire   [31:0] TERM_BS;

assign        TERM_BS         = SUBTRACT ? (TERM_B ^ 32'hFFFFFFFF) : TERM_B;
assign        CIS             = SUBTRACT ? ~CI : CI;
assign        HCO             = SUBTRACT ? ~HC : HC;
assign        CO              = SUBTRACT ? ~C : C;
assign        {C, MSB}        = TERM_A[31]   + TERM_BS[31]   + CO30;
assign        {CO30, HI_NYBS} = TERM_A[30:4] + TERM_BS[30:4] + HC;
assign        {HC, LO_NYB}    = TERM_A[3:0] + TERM_BS[3:0] + CIS;
assign        ADDER_OUT       = {MSB, HI_NYBS, LO_NYB};
assign        ZERO            = ~|ADDER_OUT;
assign        OVO             = C ^ CO30;

endmodule  //ADDER_aASYMPL32






