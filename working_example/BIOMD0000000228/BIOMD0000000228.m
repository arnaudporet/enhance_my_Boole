#Copyright (c) 2013-2014, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/working_example/BIOMD0000000228/BIOMD0000000228.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

kmax=50;
repeat=5;

edge_label={"mitogenic_stimulation__mitogenic_stimulation","mitogenic_stimulation__AP1","E2F1__AP1","pRb__AP1","AP1__CycD","E2F1__CycD","CycD__CycD","pRb__CycD","E2F1__pRb","pRb__pRb","CycD__pRb","CycE__pRb","E2F1__E2F1","pRb__E2F1","E2F1__CycE","CycE__CycE","pRb__CycE"};
node_label={"mitogenic_stimulation","AP1","CycD","pRb","E2F1","CycE"};
plot_label={"mitogenic stimulation","AP1","CycD","pRb","E2F1","CycE"};

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#off: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
4;#mitogenic_stimulation
1;#AP1
1;#CycD
1;#pRb
1;#E2F1
1#CycE
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#mitogenic_stimulation__mitogenic_stimulation
2;#mitogenic_stimulation__AP1
2;#E2F1__AP1
2;#pRb__AP1
2;#AP1__CycD
2;#E2F1__CycD
2;#CycD__CycD
2;#pRb__CycD
2;#E2F1__pRb
2;#pRb__pRb
2;#CycD__pRb
2;#CycE__pRb
2;#E2F1__E2F1
2;#pRb__E2F1
2;#E2F1__CycE
2;#CycE__CycE
2#pRb__CycE
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#mitogenic_stimulation__mitogenic_stimulation
3;#mitogenic_stimulation__AP1
3;#E2F1__AP1
3;#pRb__AP1
3;#AP1__CycD
3;#E2F1__CycD
3;#CycD__CycD
3;#pRb__CycD
3;#E2F1__pRb
3;#pRb__pRb
3;#CycD__pRb
3;#CycE__pRb
3;#E2F1__E2F1
3;#pRb__E2F1
3;#E2F1__CycE
3;#CycE__CycE
3#pRb__CycE
];

function y=fedge(node,k)
    y=[
    node(1,k);#mitogenic_stimulation__mitogenic_stimulation
    node(1,k);#mitogenic_stimulation__AP1
    node(5,k);#E2F1__AP1
    node(4,k);#pRb__AP1
    node(2,k);#AP1__CycD
    node(5,k);#E2F1__CycD
    node(3,k);#CycD__CycD
    node(4,k);#pRb__CycD
    node(5,k);#E2F1__pRb
    node(4,k);#pRb__pRb
    node(3,k);#CycD__pRb
    node(6,k);#CycE__pRb
    node(5,k);#E2F1__E2F1
    node(4,k);#pRb__E2F1
    node(5,k);#E2F1__CycE
    node(6,k);#CycE__CycE
    node(4,k)#pRb__CycE
    ];
endfunction

function y=fnode(edge,k)
    y=[
    edge(1,k);#mitogenic_stimulation
    AND(OR(edge(2,k),edge(3,k)),NOT(edge(4,k)));#AP1
    AND(OR(edge(5,k),edge(6,k),edge(7,k)),NOT(edge(8,k)));#CycD
    AND(edge(9,k),NOT(OR(edge(10,k),edge(11,k),edge(12,k))));#pRb
    AND(edge(13,k),NOT(edge(14,k)));#E2F1
    AND(OR(edge(15,k),edge(16,k)),NOT(edge(17,k)))#CycE
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

