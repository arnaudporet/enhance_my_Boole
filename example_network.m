#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#read the following comments, fill the following template, open a terminal, launch octave, past this command and press Enter: run("~/kali-sim/working_example/example_network/example_network.m")

#if plotting with gnuplot goes wrong, or if you do not have gnuplot, replace the argument of the graphics_toolkit function at line 33 by "fltk"

#kmax: the number of iterations performed during the simulation

#repeat: the number of times the simulation is repeated

#edge_label: the edge names

#node_label: the node names

#plot_label: the node names for the plot legends, for example if a node is named "DNA_damage" it should be renamed "DNA damage" for the plot legends

#node0: the node initial states, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#p: for each edges, the portion of its value which is updated at each iteration, low for slow responsive edges, high for fast responsive edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#q: for each edges, the weakening of its value applied at each iteration, low for weak edges, high for strong edges, selected randomly by the algorithm along a uniform distribution in an appropriate interval of [0;1]

#fedge: the function which update edge values at each iterations, for shorter computation time, comment or delete the first four lines and replace <node name> by node(<i>,k), also comment or delete line 35

#fnode: the function which update node values at each iterations, for shorter computation time, comment or delete the first four lines and replace <edge name> by edge(<i>,k), also comment or delete line 35

#dist: a matrix to specify which entity to disturb, which kind of disturbance to apply and when. The disturbances are applied during intervals specified by their lower and upper bounds, both expressed in tenths of kmax. At each node corresponds a row in the dist matrix: the first coordinate specifies if a disturbance has to be applied, the second coordinate specifies the disturbance type (activation or inactivation) and the remaining of the coordinates are couples specifying the lower and upper bounds of the intervals.

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

global edge_label node_label

kmax=50;
repeat=5;

edge_label={"infection__infection","pro__infection","infection__sensor","pro__anti","sensor__anti","sensor__pro","anti__pro"};
node_label={"infection","sensor","anti","pro"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#none: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
0;#infection
0;#sensor
0;#anti
0#pro
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#infection__infection
2;#pro__infection
2;#infection__sensor
2;#pro__anti
2;#sensor__anti
2;#sensor__pro
2#anti__pro
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#infection__infection
3;#pro__infection
3;#infection__sensor
3;#pro__anti
3;#sensor__anti
3;#sensor__pro
3#anti__pro
];

#yes/no (1/0), activation/inactivation (1/0), lower bound, upper bound, lower bound, upper bound,...
dist=[
1,1,1,3,5,8;#infection
0,0,0,0,0,0;#sensor
0,0,0,0,0,0;#anti
0,0,0,0,0,0#pro
];

function y=fedge(node,k)
    global node_label
    for i_node=1:numel(node_label)
        eval(strcat(node_label{i_node},"=node(",num2str(i_node),",k);"))
    endfor
    y=[
    infection;#infection__infection
    pro;#pro__infection
    infection;#infection__sensor
    pro;#pro__anti
    sensor;#sensor__anti
    sensor;#sensor__pro
    anti#anti__pro
    ];
endfunction

function y=fnode(edge,k)
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    AND(infection__infection,NOT(pro__infection));#infection
    infection__sensor;#sensor
    AND(pro__anti,NOT(sensor__anti));#anti
    AND(sensor__pro,NOT(anti__pro))#pro
    ];
endfunction

[edge,node]=go("fedge","fnode",node0,kmax,p,q,dist,repeat,plot_label);

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
