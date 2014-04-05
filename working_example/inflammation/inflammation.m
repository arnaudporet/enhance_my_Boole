#Copyright (c) 2013, Arnaud Poret
#All rights reserved.

#run("~/kali/kali-sim/working_example/inflammation/inflammation.m")

clear all
clc
addpath("~/kali/kali-sim/lib/")
graphics_toolkit("gnuplot")

global edge_label node_label

kmax=50;
repeat=5;

edge_label={"infection__infection","pro__infection","infection__sensor","sensor__pro","anti__pro","pro__anti","sensor__anti"};
node_label={"infection","sensor","pro","anti"};
plot_label=node_label;

node0=[
1;#infection
0;#sensor
0;#pro
0#anti
];

#fast: 3
#normal: 2
#slow: 1
p=[
2;#infection__infection
2;#pro__infection
2;#infection__sensor
2;#sensor__pro
2;#anti__pro
2;#pro__anti
2#sensor__anti
];

#none: 4
#normal: 3
#weaker: 2
#weakest: 1
q=[
4;#infection__infection
3;#pro__infection
3;#infection__sensor
3;#sensor__pro
3;#anti__pro
3;#pro__anti
3#sensor__anti
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
    sensor;#sensor__pro
    anti;#anti__pro
    pro;#pro__anti
    sensor#sensor__anti
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
    AND(sensor__pro,NOT(anti__pro));#pro
    AND(pro__anti,NOT(sensor__anti))#anti
    ];
endfunction

[edge,node]=go("fedge","fnode",node0,kmax,p,q,repeat,plot_label);

