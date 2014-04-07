#Copyright (c) 2013, Arnaud Poret
#All rights reserved.

#run("~/kali-sim/working_example/BIOMD0000000188/BIOMD0000000188.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

kmax=50;
repeat=5;

edge_label={"DNA_damage__DNA_damage","oncogene_activation__oncogene_activation","DNA_damage__ATM","oncogene_activation__p14ARF","p14ARF__MDM2","p53__MDM2","ATM__p53","MDM2__p53","p53__target_genes"};
node_label={"DNA_damage","oncogene_activation","ATM","p14ARF","MDM2","p53","target_genes"};
plot_label=node_label;

#full: 4 (=1)
#much: 3 (2/3<=,<=1)
#some: 2 (1/3<=,<=2/3)
#few: 1 (0<=,<=1/3)
#off: 0 (=0)
#undetermined: -1 (0<=,<=1)
node0=[
4;#DNA_damage
0;#oncogene_activation
0;#ATM
0;#p14ARF
1;#MDM2
0;#p53
0#target_genes
];

#fast: 3 (2/3<=,<=1)
#normal: 2 (1/3<=,<=2/3)
#slow: 1 (0<=,<=1/3)
#undetermined: -1 (0<=,<=1)
p=[
2;#DNA_damage__DNA_damage
2;#oncogene_activation__oncogene_activation
2;#DNA_damage__ATM
2;#oncogene_activation__p14ARF
2;#p14ARF__MDM2
2;#p53__MDM2
2;#ATM__p53
2;#MDM2__p53
2#p53__target_genes
];

#strong: 4 (=1)
#normal: 3 (2/3<=,<=1)
#weaker: 2 (1/3<=,<=2/3)
#weakest: 1 (0<=,<=1/3)
#down: 0 (=0)
#undetermined: -1 (0<=,<=1)
q=[
4;#DNA_damage__DNA_damage
4;#oncogene_activation__oncogene_activation
4;#DNA_damage__ATM
4;#oncogene_activation__p14ARF
4;#p14ARF__MDM2
4;#p53__MDM2
4;#ATM__p53
4;#MDM2__p53
4#p53__target_genes
];

function y=fedge(node,k)
    y=[
    node(1,k);#DNA_damage__DNA_damage
    node(2,k);#oncogene_activation__oncogene_activation
    node(1,k);#DNA_damage__ATM
    node(2,k);#oncogene_activation__p14ARF
    node(4,k);#p14ARF__MDM2
    node(6,k);#p53__MDM2
    node(3,k);#ATM__p53
    node(5,k);#MDM2__p53
    node(6,k)#p53__target_genes
    ];
endfunction

function y=fnode(edge,k)
    y=[
    edge(1,k);#DNA_damage
    edge(2,k);#oncogene_activation
    edge(3,k);#ATM
    edge(4,k);#p14ARF
    NOT(OR(edge(5,k),edge(6,k)));#MDM2
    OR(edge(7,k),edge(8,k));#p53
    edge(9,k)#target_genes
    ];
endfunction

[edge,node]=go("fedge","fnode",node0,kmax,p,q,repeat,plot_label);

