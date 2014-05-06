#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/working_example/toy_network/toy_network.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

kmax=25;
repeat=3;

edge_label={"EGF__EGF","HRG__HRG","EGF__EGFR","HRG__EGFR","EGFR__Raf","AKT__Raf","Raf__ERK","EGFR__PI3K","ERK__PI3K","PI3K__AKT"};
node_label={"EGF","HRG","EGFR","Raf","ERK","PI3K","AKT"};
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
0;#EGFR
0;#Raf
0;#ERK
0;#PI3K
0#AKT
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#EGF__EGF
2;#HRG__HRG
2;#EGF__EGFR
2;#HRG__EGFR
2;#EGFR__Raf
2;#AKT__Raf
2;#Raf__ERK
2;#EGFR__PI3K
2;#ERK__PI3K
2#PI3K__AKT
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
4;#EGF__EGFR
4;#HRG__EGFR
4;#EGFR__Raf
4;#AKT__Raf
4;#Raf__ERK
4;#EGFR__PI3K
4;#ERK__PI3K
4#PI3K__AKT
];

function y=fedge(node,k)
    y=[
    node(1,k);#EGF__EGF
    node(2,k);#HRG__HRG
    node(1,k);#EGF__EGFR
    node(2,k);#HRG__EGFR
    node(3,k);#EGFR__Raf
    node(7,k);#AKT__Raf
    node(4,k);#Raf__ERK
    node(3,k);#EGFR__PI3K
    node(5,k);#ERK__PI3K
    node(6,k)#PI3K__AKT
    ];
endfunction

function y=fnode(edge,k)
    y=[
    edge(1,k);#EGF
    edge(2,k);#HRG
    OR(edge(3,k),edge(4,k));#EGFR
    OR(edge(5,k),edge(6,k));#Raf
    edge(7,k);#ERK
    AND(edge(8,k),NOT(edge(9,k)));#PI3K
    edge(10,k)#AKT
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

