#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/example_network-xed.m")
#print("-f1","~/kali/from_boolean_networks_to_fuzzy_networks/tralala","-mono","-dpng")

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

#full: 5 (=1)
#much more: 4 (0.75<=,<=1)
#much: 3 (0.5<=,<=0.75)
#few: 2 (0.25<=,<=0.5)
#fewer: 1 (0<=,<=0.25)
#none: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
0;#EGF (INPUT)
0;#HRG (INPUT)
0;#EGFR
0;#PI3K
0;#AKT
0;#Raf
0#ERK
];

#instantaneous: 5 (=1)
#faster: 4 (0.75<=,<=1)
#fast: 3 (0.5<=,<=0.75)
#slow: 2 (0.25<=,<=0.5)
#slower: 1 (0<=,<=0.25)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
p=[
3;#EGF__EGFR
3;#HRG__EGFR
3;#EGFR__PI3K
3;#ERK__PI3K
3;#PI3K__AKT
3;#EGFR__Raf
3;#AKT__Raf
3#Raf__ERK
];

#strong: 5 (=1)
#weak: 4 (0.75<=,<=1)
#weaker: 3 (0.5<=,<=0.75)
#faint: 2 (0.25<=,<=0.5)
#fainter: 1 (0<=,<=0.25)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
5;#EGF__EGFR
5;#HRG__EGFR
5;#EGFR__PI3K
5;#ERK__PI3K
5;#PI3K__AKT
5;#EGFR__Raf
5;#AKT__Raf
5#Raf__ERK
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
    y=[
    0;#EGF (INPUT)
    0;#HRG (INPUT)
    OR(edge(1,k),edge(2,k));#EGFR
    AND(edge(3,k),NOT(edge(4,k)));#PI3K
    edge(5,k);#AKT
    OR(edge(6,k),edge(7,k));#Raf
    edge(8,k)#ERK
    ];
endfunction

[edge,node]=go_testing("f_edge","f_node",node0,kmax,p,q,repeat,plot_label);

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
