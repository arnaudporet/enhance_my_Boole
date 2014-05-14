#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#read the following comments, fill the following template, open a terminal, launch octave, past this command and press Enter: run("~/kali-sim/example_network.m")

#if plotting with gnuplot goes wrong, or if you do not have gnuplot, replace the argument of the graphics_toolkit function at line 33 by "fltk"

#kmax: the number of iterations performed during a run

#repeat: the number of times the run is repeated

#edge_label: the edge names

#node_label: the node names

#plot_label: the node names for the plot legends, for example if a node is named "DNA_damage" it should be renamed "DNA damage" for the plot legends

#node0: the node initial states, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#p: for each edges, the portion of its value which is updated at each iteration, low for slow responsive edges, high for fast responsive edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#q: for each edges, the weakening of its value applied at each iteration, low for weak edges, high for strong edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#f_edge: the function which update edge values at each iterations, for shorter computation time, comment or delete the first four lines and replace <node name> by node(<i>,k), also comment or delete line 35

#f_node: the function which update node values at each iterations, for shorter computation time, comment or delete the first four lines and replace <edge name> by edge(<i>,k), also comment or delete line 35

#the example network is an implementation of a logical graph used by Melody K Morris et al: Melody K Morris, Julio Saez-Rodriguez, Peter K Sorger, and Douglas A Lauffenburger. Logic-based models for the analysis of cell signaling networks. Biochemistry, 49(15):3216–3224, 2010.

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

global edge_label node_label

kmax=50;
repeat=10;

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
#weaker: 4 (0.75<=,<=1)
#weak: 3 (0.5<=,<=0.75)
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
    global node_label
    for i_node=1:numel(node_label)
        eval(strcat(node_label{i_node},"=node(",num2str(i_node),",k);"))
    endfor
    y=[
    EGF;#EGF__EGFR
    HRG;#HRG__EGFR
    EGFR;#EGFR__PI3K
    ERK;#ERK__PI3K
    PI3K;#PI3K__AKT
    EGFR;#EGFR__Raf
    AKT;#AKT__Raf
    Raf#Raf__ERK
    ];
endfunction

function y=f_node(edge,k)
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    1;#EGF (INPUT)
    0;#HRG (INPUT)
    OR(EGF__EGFR,HRG__EGFR);#EGFR
    AND(EGFR__PI3K,NOT(ERK__PI3K));#PI3K
    PI3K__AKT;#AKT
    OR(EGFR__Raf,AKT__Raf);#Raf
    Raf__ERK#ERK
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
