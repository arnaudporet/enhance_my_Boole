#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/working_example/BIOMD0000000049/BIOMD0000000049.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

kmax=50;
repeat=5;

edge_label={"EGF__EGF","NGF__NGF","EGF__EGFR","EGFR__EGFR","NGF__TrkA","EGFR__Shc","TrkA__Shc","EGFR__FRS2","TrkA__FRS2","EGFR__Dok","TrkA__Dok","Shc__Grb2","FRS2__Crk","Dok__RasGAP","Grb2__SOS","ERK__SOS","Crk__C3G","SOS__Ras","RasGAP__Ras","C3G__Rap1","Rap1GAP__Rap1","Rap1GAP__Rap1GAP","Ras__cRaf","Rap1__BRaf","Ras__BRaf","cRaf__MEK","BRaf__MEK","PP2A__MEK","PP2A__PP2A","MEK__ERK","MKP3__ERK","MKP3__MKP3"};
node_label={"EGF","NGF","EGFR","TrkA","Shc","FRS2","Dok","Grb2","Crk","RasGAP","SOS","C3G","Ras","Rap1","Rap1GAP","cRaf","BRaf","MEK","PP2A","ERK","MKP3"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#off: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
4;#EGF
0;#NGF
0;#EGFR
0;#TrkA
0;#Shc
0;#FRS2
0;#Dok
0;#Grb2
0;#Crk
0;#RasGAP
0;#SOS
0;#C3G
0;#Ras
0;#Rap1
0;#Rap1GAP
0;#cRaf
0;#BRaf
0;#MEK
0;#PP2A
0;#ERK
0#MKP3
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#EGF__EGF
2;#NGF__NGF
2;#EGF__EGFR
2;#EGFR__EGFR
2;#NGF__TrkA
2;#EGFR__Shc
2;#TrkA__Shc
2;#EGFR__FRS2
2;#TrkA__FRS2
2;#EGFR__Dok
2;#TrkA__Dok
2;#Shc__Grb2
2;#FRS2__Crk
2;#Dok__RasGAP
2;#Grb2__SOS
2;#ERK__SOS
2;#Crk__C3G
2;#SOS__Ras
2;#RasGAP__Ras
2;#C3G__Rap1
2;#Rap1GAP__Rap1
2;#Rap1GAP__Rap1GAP
2;#Ras__cRaf
2;#Rap1__BRaf
2;#Ras__BRaf
2;#cRaf__MEK
2;#BRaf__MEK
2;#PP2A__MEK
2;#PP2A__PP2A
2;#MEK__ERK
2;#MKP3__ERK
2#MKP3__MKP3
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#EGF__EGF XXX self loop parameter XXX
4;#NGF__NGF XXX self loop parameter XXX
3;#EGF__EGFR
4;#EGFR__EGFR XXX self loop degradation XXX
3;#NGF__TrkA
3;#EGFR__Shc
3;#TrkA__Shc
3;#EGFR__FRS2
3;#TrkA__FRS2
3;#EGFR__Dok
3;#TrkA__Dok
3;#Shc__Grb2
3;#FRS2__Crk
3;#Dok__RasGAP
3;#Grb2__SOS
3;#ERK__SOS
3;#Crk__C3G
3;#SOS__Ras
3;#RasGAP__Ras
3;#C3G__Rap1
3;#Rap1GAP__Rap1
4;#Rap1GAP__Rap1GAP XXX self loop parameter XXX
3;#Ras__cRaf
3;#Rap1__BRaf
3;#Ras__BRaf
3;#cRaf__MEK
3;#BRaf__MEK
3;#PP2A__MEK
4;#PP2A__PP2A XXX self loop parameter XXX
3;#MEK__ERK
3;#MKP3__ERK
4#MKP3__MKP3 XXX self loop parameter XXX
];

function y=fedge(node,k)
    y=[
    node(1,k);#EGF__EGF
    node(2,k);#NGF__NGF
    node(1,k);#EGF__EGFR
    node(3,k);#EGFR__EGFR
    node(2,k);#NGF__TrkA
    node(3,k);#EGFR__Shc
    node(4,k);#TrkA__Shc
    node(3,k);#EGFR__FRS2
    node(4,k);#TrkA__FRS2
    node(3,k);#EGFR__Dok
    node(4,k);#TrkA__Dok
    node(5,k);#Shc__Grb2
    node(6,k);#FRS2__Crk
    node(7,k);#Dok__RasGAP
    node(8,k);#Grb2__SOS
    node(20,k);#ERK__SOS
    node(9,k);#Crk__C3G
    node(11,k);#SOS__Ras
    node(10,k);#RasGAP__Ras
    node(12,k);#C3G__Rap1
    node(15,k);#Rap1GAP__Rap1
    node(15,k);#Rap1GAP__Rap1GAP
    node(13,k);#Ras__cRaf
    node(14,k);#Rap1__BRaf
    node(13,k);#Ras__BRaf
    node(16,k);#cRaf__MEK
    node(17,k);#BRaf__MEK
    node(19,k);#PP2A__MEK
    node(19,k);#PP2A__PP2A
    node(18,k);#MEK__ERK
    node(21,k);#MKP3__ERK
    node(21,k)#MKP3__MKP3
    ];
endfunction

function y=fnode(edge,k)
    y=[
    edge(1,k);#EGF
    edge(2,k);#NGF
    AND(edge(3,k),NOT(edge(4,k)));#EGFR
    edge(5,k);#TrkA
    OR(edge(6,k),edge(7,k));#Shc
    OR(edge(8,k),edge(9,k));#FRS2
    OR(edge(10,k),edge(11,k));#Dok
    edge(12,k);#Grb2
    edge(13,k);#Crk
    edge(14,k);#RasGAP
    AND(edge(15,k),NOT(edge(16,k)));#SOS
    edge(17,k);#C3G
    AND(edge(18,k),NOT(edge(19,k)));#Ras
    AND(edge(20,k),NOT(edge(21,k)));#Rap1
    edge(22,k);#Rap1GAP
    edge(23,k);#cRaf
    OR(edge(24,k),edge(25,k));#BRaf
    AND(OR(edge(26,k),edge(27,k)),NOT(edge(28,k)));#MEK
    edge(29,k);#PP2A
    AND(edge(30,k),NOT(edge(31,k)));#ERK
    edge(32,k)#MKP3
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

