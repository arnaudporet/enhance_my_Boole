#Copyright (c) 2013, Arnaud Poret
#All rights reserved.

#run("~/kali/kali-sim/working_example/BIOMD0000000427/BIOMD0000000427.m")

clear all
clc
addpath("~/kali/kali-sim/lib/")
graphics_toolkit("gnuplot")

global edge_label node_label

kmax=25;
repeat=5;

edge_label={"EGFR__EGFR","p90Rsk__SOS","IGF1R__SOS","EGFR__SOS","RasGap__Ras","SOS__Ras","ERK__p90Rsk","IGF1R__IGF1R","Ras__PI3KCA","IGF1R__PI3KCA","EGFR__PI3KCA","PI3KCA__Akt","PP2A__MEK","Raf__MEK","PP2A__ERK","MEK__ERK","PP2A__PP2A","Akt__Raf","RafPP__Raf","Ras__Raf","RasGap__RasGap","RafPP__RafPP"};
node_label={"EGFR","SOS","Ras","p90Rsk","IGF1R","PI3KCA","Akt","MEK","ERK","PP2A","Raf","RasGap","RafPP"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#off: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
4;#EGFR XXX parameter XXX
-1;#SOS
-1;#Ras
-1;#p90Rsk
0;#IGF1R XXX parameter XXX
-1;#PI3KCA
-1;#Akt
-1;#MEK
-1;#ERK
0;#PP2A XXX parameter XXX
-1;#Raf
0;#RasGap XXX parameter XXX
0#RafPP XXX parameter XXX
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#EGFR__EGFR
2;#p90Rsk__SOS
2;#IGF1R__SOS
2;#EGFR__SOS
2;#RasGap__Ras
2;#SOS__Ras
2;#ERK__p90Rsk
2;#IGF1R__IGF1R
2;#Ras__PI3KCA
2;#IGF1R__PI3KCA
2;#EGFR__PI3KCA
2;#PI3KCA__Akt
2;#PP2A__MEK
2;#Raf__MEK
2;#PP2A__ERK
2;#MEK__ERK
2;#PP2A__PP2A
2;#Akt__Raf
2;#RafPP__Raf
2;#Ras__Raf
2;#RasGap__RasGap
2#RafPP__RafPP
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#EGFR__EGFR XXX self loop parameter XXX
3;#p90Rsk__SOS
3;#IGF1R__SOS
3;#EGFR__SOS
3;#RasGap__Ras
3;#SOS__Ras
3;#ERK__p90Rsk
4;#IGF1R__IGF1R XXX self loop parameter XXX
3;#Ras__PI3KCA
3;#IGF1R__PI3KCA
3;#EGFR__PI3KCA
3;#PI3KCA__Akt
3;#PP2A__MEK
3;#Raf__MEK
3;#PP2A__ERK
3;#MEK__ERK
4;#PP2A__PP2A XXX self loop parameter XXX
3;#Akt__Raf
3;#RafPP__Raf
3;#Ras__Raf
4;#RasGap__RasGap XXX self loop parameter XXX
4#RafPP__RafPP XXX self loop parameter XXX
];

function y=fedge(node,k)
    global node_label
    for i_node=1:numel(node_label)
        eval(strcat(node_label{i_node},"=node(",num2str(i_node),",k);"))
    endfor
    y=[
    EGFR;#EGFR__EGFR
    p90Rsk;#p90Rsk__SOS
    IGF1R;#IGF1R__SOS
    EGFR;#EGFR__SOS
    RasGap;#RasGap__Ras
    SOS;#SOS__Ras
    ERK;#ERK__p90Rsk
    IGF1R;#IGF1R__IGF1R
    Ras;#Ras__PI3KCA
    IGF1R;#IGF1R__PI3KCA
    EGFR;#EGFR__PI3KCA
    PI3KCA;#PI3KCA__Akt
    PP2A;#PP2A__MEK
    Raf;#Raf__MEK
    PP2A;#PP2A__ERK
    MEK;#MEK__ERK
    PP2A;#PP2A__PP2A
    Akt;#Akt__Raf
    RafPP;#RafPP__Raf
    Ras;#Ras__Raf
    RasGap;#RasGap__RasGap
    RafPP#RafPP__RafPP
    ];
endfunction

function y=fnode(edge,k)
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    EGFR__EGFR;#EGFR XXX parameter XXX
    AND(NOT(p90Rsk__SOS),OR(IGF1R__SOS,EGFR__SOS));#SOS
    AND(NOT(RasGap__Ras),SOS__Ras);#Ras
    ERK__p90Rsk;#p90Rsk
    IGF1R__IGF1R;#IGF1R XXX parameter XXX
    OR(Ras__PI3KCA,IGF1R__PI3KCA,EGFR__PI3KCA);#PI3KCA
    PI3KCA__Akt;#Akt
    AND(NOT(PP2A__MEK),Raf__MEK);#MEK
    AND(NOT(PP2A__ERK),MEK__ERK);#ERK
    PP2A__PP2A;#PP2A XXX parameter XXX
    AND(NOT(OR(Akt__Raf,RafPP__Raf)),Ras__Raf);#Raf
    RasGap__RasGap;#RasGap XXX parameter XXX
    RafPP__RafPP#RafPP XXX parameter XXX
    ];
endfunction

[edge,node]=go("fedge","fnode",node0,kmax,p,q,repeat,plot_label);

