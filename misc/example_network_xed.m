# run("~/kali-sim/misc/example_network_xed.m")

clear all
clc
addpath("~/kali-sim/lib/")
graphics_toolkit("gnuplot")

k_end=100;
r=10;
edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};
plot_label=node_label;
plot_all=1;

#    5: full (=1)
#    4: much more (0.75<=,<=1)
#    3: much (0.5<=,<=0.75)
#    2: few (0.25<=,<=0.5)
#    1: fewer (0<=,<=0.25)
#    0: none (=0)
#   -1: undetermined (0<=,<=1)
#   -2: no disturbance
dist=[
4;#EGF
-2;#HRG
-2;#EGFR
-2;#PI3K
-2;#AKT
-2;#Raf
-2#ERK
];

# in tenth of k_end (-1 for undisturbed nodes)
k_dist=[
2,6;#EGF
-1,-1;#HRG
-1,-1;#EGFR
-1,-1;#PI3K
-1,-1;#AKT
-1,-1;#Raf
-1,-1#ERK
];

#    5: full (=1)
#    4: much more (0.75<=,<=1)
#    3: much (0.5<=,<=0.75)
#    2: few (0.25<=,<=0.5)
#    1: fewer (0<=,<=0.25)
#    0: none (=0)
#   -1: undetermined (0<=,<=1)
node0=[
1;#EGF
1;#HRG
1;#EGFR
1;#PI3K
1;#AKT
1;#Raf
1#ERK
];

#    5: instantaneous (=1)
#    4: faster (0.75<=,<=1)
#    3: fast (0.5<=,<=0.75)
#    2: slow (0.25<=,<=0.5)
#    1: slower (0<=,<=0.25)
#    0: down (=0)
#   -1: undetermined (0<=,<=1)
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

#    5: strong (=1)
#    4: weaker (0.75<=,<=1)
#    3: weak (0.5<=,<=0.75)
#    2: faint (0.25<=,<=0.5)
#    1: fainter (0<=,<=0.25)
#    0: down (=0)
#   -1: undetermined (0<=,<=1)
q=[
4;#EGF__EGFR
4;#HRG__EGFR
4;#EGFR__PI3K
4;#ERK__PI3K
4;#PI3K__AKT
4;#EGFR__Raf
4;#AKT__Raf
4#Raf__ERK
];

function y=f_node(edge,k,node)
    y=[
    node(1,1);#EGF
    node(2,1);#HRG
    OR(edge(1,k),edge(2,k));#EGFR
    AND(edge(3,k),NOT(edge(4,k)));#PI3K
    edge(5,k);#AKT
    OR(edge(6,k),edge(7,k));#Raf
    edge(8,k)#ERK
    ];
endfunction

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

[edge,node]=go("f_edge","f_node",node0,k_end,p,q,r,plot_label,dist,k_dist,plot_all);

if not(plot_all)
    figure(1)
    clf(1)
    for i_r=1:r
        NODE(i_r,:)=node(1,:,i_r);
    endfor
    subplot(2,2,1)
    plot((1:k_end)',NODE')
    axis([1,k_end,-0.1,1.1],"ticy","labely")
    title(plot_label{1})
    for i_r=1:r
        NODE(i_r,:)=node(3,:,i_r);
    endfor
    subplot(2,2,2)
    plot((1:k_end)',NODE')
    axis([1,k_end,-0.1,1.1],"ticy","labely")
    title(plot_label{3})
    for i_r=1:r
        NODE(i_r,:)=node(4,:,i_r);
    endfor
    subplot(2,2,3)
    plot((1:k_end)',NODE')
    axis([1,k_end,-0.1,1.1],"ticy","labely")
    title(plot_label{4})
    for i_r=1:r
        NODE(i_r,:)=node(7,:,i_r);
    endfor
    subplot(2,2,4)
    plot((1:k_end)',NODE')
    axis([1,k_end,-0.1,1.1],"ticy","labely")
    title(plot_label{7})
endif

