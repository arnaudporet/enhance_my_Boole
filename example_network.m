#################################    HOWTO    ##################################

# 1) read the comments
# 2) fill the template
# 3) launch octave:
#        cd ~/kali-sim/ && octave
# 4) run:
#        run("./example_network.m")

################################################################################

clear all
clc
addpath("./lib/")

global edge_label node_label

# the number of iterations performed during a run
k_end=50;

# the number of times the run is replicated
r=3;

# the edge names
edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};

# the node names
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};

# the node names for the plot legend (for example, if a node is named
# "DNA_damage" then it should be renamed "DNA damage" for the plot legend)
plot_label=node_label;

# automatically plots all the nodes (1: yes, 0: no)
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

# the iterations at which the disturbances begin and end respectively, in tenth
# of k_end (-1 for undisturbed nodes)
k_dist=[
2,7;#EGF
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
0;#EGF
0;#HRG
0;#EGFR
0;#PI3K
0;#AKT
0;#Raf
0#ERK
];

# for each edge, the portion of its value which is updated at each
# iteration (edge reactivity):
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

# for each edge, the weakening of its value at each iteration (edge weakening):
#    5: strong (=1)
#    4: weak (0.75<=,<=1)
#    3: weaker (0.5<=,<=0.75)
#    2: faint (0.25<=,<=0.5)
#    1: fainter (0<=,<=0.25)
#    0: down (=0)
#   -1: undetermined (0<=,<=1)
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

# the function which updates the node values at each iteration
# for a shorter computation time, comment the first four lines of this
# function (the same for line 16) and replace <edge name> by edge(<i>,k)
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

# the function which updates the edge values at each iteration
# for a shorter computation time, comment the first four lines of this
# function (the same for line 16) and replace <node name> by node(<i>,k)
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

# if not automatically plots all the nodes (plot_all=0, line 35) then plot your
# own, such as EGF, EGFR, PI3K and ERK
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
