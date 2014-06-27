#run("~/kali-sim/misc/example_network_xed.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

global k_EGF k_HRG

k_end=50;
k_EGF=k_end/10;
k_HRG=k_EGF;
r=10;

edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};
plot_label=node_label;

#5: full (=1)
#4: much more (0.75<=,<=1)
#3: much (0.5<=,<=0.75)
#2: few (0.25<=,<=0.5)
#1: fewer (0<=,<=0.25)
#0: none (=0)
#-1: undetermined (0<=,<=1)
node0=[
0;#EGF
0;#HRG
0;#EGFR
0;#PI3K
0;#AKT
0;#Raf
0#ERK
];

#5: instantaneous (=1)
#4: faster (0.75<=,<=1)
#3: fast (0.5<=,<=0.75)
#2: slow (0.25<=,<=0.5)
#1: slower (0<=,<=0.25)
#0: down (=0)
#-1: undetermined (0<=,<=1)
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

#5: strong (=1)
#4: weaker (0.75<=,<=1)
#3: weak (0.5<=,<=0.75)
#2: faint (0.25<=,<=0.5)
#1: fainter (0<=,<=0.25)
#0: down (=0)
#-1: undetermined (0<=,<=1)
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
    0;#EGF
    0;#HRG
    OR(edge(1,k),edge(2,k));#EGFR
    AND(edge(3,k),NOT(edge(4,k)));#PI3K
    edge(5,k);#AKT
    OR(edge(6,k),edge(7,k));#Raf
    edge(8,k)#ERK
    ];
endfunction

[edge,node]=go("f_edge","f_node",node0,k_end,p,q,r,plot_label);

