#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#read the following comments, fill the following template, open a terminal, launch octave, past this command and press Enter: run("~/kali-sim/example_network.m")

#if plotting with gnuplot goes wrong, or if you do not have gnuplot, replace the argument of the graphics_toolkit function at line 37 by "fltk"

#kmax: the number of iterations performed during the simulation

#repeat: the number of times the simulation is repeated

#edge_label: the edge names

#node_label: the node names

#plot_label: the node names for the plot legends, for example if a node is named "DNA_damage" it should be renamed "DNA damage" for the plot legends

#node0: the node initial states, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#p: for each edges, the portion of its value which is updated at each iteration, low for slow responsive edges, high for fast responsive edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#q: for each edges, the weakening of its value applied at each iteration, low for weak edges, high for strong edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#f_edge: the function which update edge values at each iterations, for shorter computation time, comment or delete the first four lines and replace <node name> by node(<i>,k), also comment or delete line 39

#f_node: the function which update node values at each iterations, for shorter computation time, comment or delete the first four lines and replace <edge name> by edge(<i>,k), also comment or delete line 39

#dist_edge: a matrix to specify which edge to disturb, which kind of disturbance to apply and when. The disturbances are applied during intervals specified by their lower and upper bounds, both expressed in tenths of kmax. At each edge corresponds a row in the dist_edge matrix: the first coordinate specifies if a disturbance has to be applied, the second coordinate specifies the disturbance type (activation or inactivation) and the remaining of the coordinates are couples specifying the lower and upper bounds of the intervals.

#dist_node: a matrix to specify which node to disturb, which kind of disturbance to apply and when. The disturbances are applied during intervals specified by their lower and upper bounds, both expressed in tenths of kmax. At each node corresponds a row in the dist_node matrix: the first coordinate specifies if a disturbance has to be applied, the second coordinate specifies the disturbance type (activation or inactivation) and the remaining of the coordinates are couples specifying the lower and upper bounds of the intervals.

#this example network is an implementation of a logical graph proposed by Melody K Morris et al: Melody K Morris, Julio Saez-Rodriguez, Peter K Sorger, and Douglas A Lauffenburger. Logic-based models for the analysis of cell signaling networks. Biochemistry, 49(15):3216–3224, 2010.

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

global edge_label node_label

kmax=50;
repeat=5;

edge_label={"EGF__EGF","HRG__HRG","EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};
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
2;#EGF__EGF
2;#HRG__HRG
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
4;#EGF__EGF
4;#HRG__HRG
4;#EGF__EGFR
4;#HRG__EGFR
4;#EGFR__PI3K
4;#ERK__PI3K
4;#PI3K__AKT
4;#EGFR__Raf
4;#AKT__Raf
4#Raf__ERK
];

#yes/no (1/0), activation/inactivation (1/0), lower bound, upper bound, lower bound, upper bound,...
dist_edge=[
0,0,0,0;#EGF__EGF
0,0,0,0;#HRG__HRG
0,0,0,0;#EGF__EGFR
0,0,0,0;#HRG__EGFR
0,0,0,0;#EGFR__PI3K
1,0,5,10;#ERK__PI3K
0,0,0,0;#PI3K__AKT
0,0,0,0;#EGFR__Raf
0,0,0,0;#AKT__Raf
0,0,0,0#Raf__ERK
];

#yes/no (1/0), activation/inactivation (1/0), lower bound, upper bound, lower bound, upper bound,...
dist_node=[
0,0,0,0;#EGF
1,1,1,10;#HRG
0,0,0,0;#EGFR
0,0,0,0;#PI3K
0,0,0,0;#AKT
0,0,0,0;#Raf
0,0,0,0#ERK
];

function y=f_edge(node,k)
    global node_label
    for i_node=1:numel(node_label)
        eval(strcat(node_label{i_node},"=node(",num2str(i_node),",k);"))
    endfor
    y=[
    node(1,k);#EGF__EGF
    node(2,k);#HRG__HRG
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
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    edge(1,k);#EGF
    edge(2,k);#HRG
    OR(edge(3,k),edge(4,k));#EGFR
    AND(edge(5,k),NOT(edge(6,k)));#PI3K
    edge(7,k);#AKT
    OR(edge(8,k),edge(9,k));#Raf
    edge(10,k)#ERK
    ];
endfunction

[edge,node]=go("f_edge","f_node",node0,kmax,p,q,dist_edge,dist_node,repeat,plot_label);

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