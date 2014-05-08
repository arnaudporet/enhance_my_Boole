#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/example_network-xed.m")
#%print(1,"~/kali/from_boolean_networks_to_fuzzy_networks/tralala","-mono","-dpdf")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

global kdist

kmax=50;
repeat=10;
kdist=[1,10]*kmax/10;

edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#none: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
0;#EGF
0;#HRG
0;#EGFR
0;#PI3K
0;#AKT
0;#Raf
0#ERK
];

#instantaneous: 4 (=1)
#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
p=[
2;#EGF__EGFR
2;#HRG__EGFR
2;#EGFR__PI3K
2;#ERK__PI3K
2;#PI3K__AKT
2;#EGFR__Raf
2;#AKT__Raf
2#Raf__ERK
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#EGF__EGFR
4;#HRG__EGFR
4;#EGFR__PI3K
2;#ERK__PI3K
4;#PI3K__AKT
4;#EGFR__Raf
4;#AKT__Raf
4#Raf__ERK
];

function y=f_edge(node,k)
    y=[
    node(1,k);#EGF__EGFR
    node(2,k);#HRG__EGFR
    node(3,k);#EGFR__PI3K
    node(7,k);#ERK__PI3K
    node(4,k);#PI3K__AKT
    node(3,k);#EGFR__Raf
    node(5,k);#AKT__Raf
    node(6,k)#Raf__ERK
    ];
endfunction

function y=f_node(edge,k)
    global kdist
    y=[
    not(and(kdist(1)<=k,k<=kdist(2)))*(0)+and(kdist(1)<=k,k<=kdist(2))*(1);#EGF
    0;#HRG
    OR(edge(1,k),edge(2,k));#EGFR
    AND(edge(3,k),NOT(edge(4,k)));#PI3K
    edge(5,k);#AKT
    OR(edge(6,k),edge(7,k));#Raf
    edge(8,k)#ERK
    ];
endfunction

[edge,node]=go("f_edge","f_node",node0,kmax,p,q,repeat,plot_label);

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
