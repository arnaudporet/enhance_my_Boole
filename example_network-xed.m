#run("~/kali-sim/example_network-xed.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

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

#yes/no (1/0), activation/inactivation (1/0), lower bound, upper bound, lower bound, upper bound, ...
D_edge=[
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

#yes/no (1/0), activation/inactivation (1/0), lower bound, upper bound, lower bound, upper bound, ...
D_node=[
1,1,1,3,6,9;#EGF
0,0,0,0,0,0;#HRG
0,0,0,0,0,0;#EGFR
0,0,0,0,0,0;#PI3K
0,0,0,0,0,0;#AKT
0,0,0,0,0,0;#Raf
0,0,0,0,0,0#ERK
];

function y=f_edge(node,k)
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

[edge,node]=go("f_edge","f_node",node0,kmax,p,q,D_edge,D_node,repeat,plot_label);
