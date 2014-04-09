#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/working_example/BIOMD0000000255/BIOMD0000000255.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

kmax=50;
repeat=5;

edge_label={"EGF__EGF","HRG__HRG","EGF__ErbB","HRG__ErbB","PTP1B__ErbB","ErbB__Shc","Shc__GS","ErbB__GS","GS__Ras","Ras__Raf","PP2A__Raf","AKT__Raf","Raf__MEK","PP2A__MEK","MEK__ERK","MKP__ERK","ErbB__Gab1","Gab1__PI3K","PI3K__PIP3","PTEN__PIP3","PIP3__PDK1","PDK1__AKT","PP2A__AKT","PTP1B__PTP1B","PP2A__PP2A","MKP__MKP","PTEN__PTEN"};
node_label={"EGF","HRG","ErbB","Shc","GS","Ras","Raf","MEK","ERK","Gab1","PI3K","PIP3","PDK1","AKT","PTP1B","PP2A","MKP","PTEN"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#off: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
4;#EGF
0;#HRG
0;#ErbB
0;#Shc
0;#GS
0;#Ras
0;#Raf
0;#MEK
0;#ERK
0;#Gab1
0;#PI3K
0;#PIP3
0;#PDK1
0;#AKT
0;#PTP1B
0;#PP2A
0;#MKP
0#PTEN
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#EGF__EGF
2;#HRG__HRG
2;#EGF__ErbB
2;#HRG__ErbB
2;#PTP1B__ErbB
2;#ErbB__Shc
2;#Shc__GS
2;#ErbB__GS
2;#GS__Ras
2;#Ras__Raf
2;#PP2A__Raf
2;#AKT__Raf
2;#Raf__MEK
2;#PP2A__MEK
2;#MEK__ERK
2;#MKP__ERK
2;#ErbB__Gab1
2;#Gab1__PI3K
2;#PI3K__PIP3
2;#PTEN__PIP3
2;#PIP3__PDK1
2;#PDK1__AKT
2;#PP2A__AKT
2;#PTP1B__PTP1B
2;#PP2A__PP2A
2;#MKP__MKP
2#PTEN__PTEN
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#EGF__EGF
4;#HRG__HRG
4;#EGF__ErbB
4;#HRG__ErbB
4;#PTP1B__ErbB
4;#ErbB__Shc
4;#Shc__GS
4;#ErbB__GS
4;#GS__Ras
4;#Ras__Raf
4;#PP2A__Raf
4;#AKT__Raf
4;#Raf__MEK
4;#PP2A__MEK
4;#MEK__ERK
4;#MKP__ERK
4;#ErbB__Gab1
4;#Gab1__PI3K
4;#PI3K__PIP3
4;#PTEN__PIP3
4;#PIP3__PDK1
4;#PDK1__AKT
4;#PP2A__AKT
4;#PTP1B__PTP1B
4;#PP2A__PP2A
4;#MKP__MKP
4#PTEN__PTEN
];

function y=fedge(node,k)
    y=[
    node(1,k);#EGF__EGF
    node(2,k);#HRG__HRG
    node(1,k);#EGF__ErbB
    node(2,k);#HRG__ErbB
    node(15,k);#PTP1B__ErbB
    node(3,k);#ErbB__Shc
    node(4,k);#Shc__GS
    node(3,k);#ErbB__GS
    node(5,k);#GS__Ras
    node(6,k);#Ras__Raf
    node(16,k);#PP2A__Raf
    node(14,k);#AKT__Raf
    node(7,k);#Raf__MEK
    node(16,k);#PP2A__MEK
    node(8,k);#MEK__ERK
    node(17,k);#MKP__ERK
    node(3,k);#ErbB__Gab1
    node(10,k);#Gab1__PI3K
    node(11,k);#PI3K__PIP3
    node(18,k);#PTEN__PIP3
    node(12,k);#PIP3__PDK1
    node(13,k);#PDK1__AKT
    node(16,k);#PP2A__AKT
    node(15,k);#PTP1B__PTP1B
    node(16,k);#PP2A__PP2A
    node(17,k);#MKP__MKP
    node(18,k)#PTEN__PTEN
    ];
endfunction

function y=fnode(edge,k)
    y=[
    edge(1,k);#EGF
    edge(2,k);#HRG
    AND(OR(edge(3,k),edge(4,k)),NOT(edge(5,k)));#ErbB
    edge(6,k);#Shc
    OR(edge(7,k),edge(8,k));#GS
    edge(9,k);#Ras
    AND(edge(10,k),NOT(OR(edge(11,k),edge(12,k))));#Raf
    AND(edge(13,k),NOT(edge(14,k)));#MEK
    AND(edge(15,k),NOT(edge(16,k)));#ERK
    edge(17,k);#Gab1
    edge(18,k);#PI3K
    AND(edge(19,k),NOT(edge(20,k)));#PIP3
    edge(21,k);#PDK1
    AND(edge(22,k),NOT(edge(23,k)));#AKT
    edge(24,k);#PTP1B
    edge(25,k);#PP2A
    edge(26,k);#MKP
    edge(27,k)#PTEN
    ];
endfunction

[edge,node]=go("fedge","fnode",node0,kmax,p,q,repeat,plot_label);

################################################################################
##############################       LICENSE      ##############################
##############################    BSD 3-Clause    ##############################
################################################################################

#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:

#1. Redistributions of source code must retain the above copyright notice, this
#list of conditions and the following disclaimer.

#2. Redistributions in binary form must reproduce the above copyright notice,
#this list of conditions and the following disclaimer in the documentation and/or
#other materials provided with the distribution.

#3. Neither the name of the copyright holder nor the names of its contributors
#may be used to endorse or promote products derived from this software without
#specific prior written permission.

#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
#ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
#ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

