
# How to:
#    1) read the comments
#    2) fill the template
#    3) launch octave: cd ~/kali-sim/ && octave
#    4) run: run("~/kali-sim/example_network.m")

# GNU Octave (http://www.gnu.org/software/octave/) is a high-level interpreted
# language, primarily intended for numerical computations. 

# The example network is a tiny sample of the epidermal growth factor receptor
# signaling pathway [1] adapted from [2].

# [1] Oda, K., Matsuoka, Y., Funahashi, A., & Kitano, H. (2005). A comprehensive
# pathway map of epidermal growth factor receptor signaling. Molecular systems
# biology, 1(1).

# [2] Morris, M. K., Saez-Rodriguez, J., Sorger, P. K., & Lauffenburger, D. A.
# (2010). Logic-based models for the analysis of cell signaling networks.
# Biochemistry, 49(15), 3216-3224.

clear all
clc
addpath("~/kali-sim/lib/")

# if plotting with gnuplot goes wrong, or if you do not have gnuplot
# (http://www.gnuplot.info/), replace the argument by "fltk"
graphics_toolkit("gnuplot")

global edge_label node_label

# the number of iterations performed during a run
k_end=100;

# the number of times the run is replicated
r=10;

# the edge names
edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};

# the node names
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};

# the node names for the plot legends, for example if a node is named
# "DNA_damage" it should be renamed "DNA damage" for the plot legends
plot_label=node_label;

# automatically plot all nodes (1: yes, 0: no)
plot_all=1;

# the node disturbed states:
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

# the iteration at which disturbances begin and end respectively, in tenth of
# k_end (-1 for undisturbed nodes)
k_dist=[
2,6;#EGF
-1,-1;#HRG
-1,-1;#EGFR
-1,-1;#PI3K
-1,-1;#AKT
-1,-1;#Raf
-1,-1#ERK
];

# the node initial states:
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

# for each edges, the portion of its value which is updated at each iteration:
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

# for each edges, the weakening of its value at each iteration:
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

# the function which update node values at each iterations, for shorter
# computation time, comment or delete the first four lines and replace
# <edge name> by edge(<i>,k)
function y=f_node(edge,k,node)
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    node(1,1);#EGF
    node(2,1);#HRG
    OR(EGF__EGFR,HRG__EGFR);#EGFR
    AND(EGFR__PI3K,NOT(ERK__PI3K));#PI3K
    PI3K__AKT;#AKT
    OR(EGFR__Raf,AKT__Raf);#Raf
    Raf__ERK#ERK
    ];
endfunction

# the function which update edge values at each iterations, for shorter
# computation time, comment or delete the first four lines and replace
# <node name> by node(<i>,k)
function y=f_edge(node,k)
    global node_label
    for i_node=1:numel(node_label)
        eval(strcat(node_label{i_node},"=node(",num2str(i_node),",k);"))
    endfor
    y=[
    EGF;#EGF__EGFR
    HRG;#HRG__EGFR
    EGFR;#EGFR__PI3K
    ERK;#ERK__PI3K
    PI3K;#PI3K__AKT
    EGFR;#EGFR__Raf
    AKT;#AKT__Raf
    Raf#Raf__ERK
    ];
endfunction

[edge,node]=go("f_edge","f_node",node0,k_end,p,q,r,plot_label,dist,k_dist,plot_all);

# if not automatically plot all nodes (plot_all=0), plot your own such as EGF,
# EGFR, PI3K and ERK
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

