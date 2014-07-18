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

# The f_node of the inputs (i.e. the f_node set by the modeler, in the present
# example f_EGF and f_HRG line 144 and 145 respectively) are rather
# rudimentarily implemented in the lib/go.m file. This issue will be addressed
# as soon as possible.

clear all
clc
addpath("~/kali-sim/lib/")

# if plotting with gnuplot goes wrong, or if you do not have gnuplot
# (http://www.gnuplot.info/), replace the argument by "fltk"
graphics_toolkit("gnuplot")

global edge_label node_label k_EGF k_HRG

# the number of iterations performed during a run
k_end=50;

# the iteration at which the EGF perturbation begins
k_EGF=k_end/10;

# the iteration at which the HRG perturbation begins
k_HRG=k_EGF;

# the number of times the run is replicated
r=10;

# the edge names
edge_label={"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"};

# the node names
node_label={"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"};

# the node names for the plot legends, for example if a node is named
# "DNA_damage" it should be renamed "DNA damage" for the plot legends
plot_label=node_label;

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
5;#EGF__EGFR
5;#HRG__EGFR
5;#EGFR__PI3K
5;#ERK__PI3K
5;#PI3K__AKT
5;#EGFR__Raf
5;#AKT__Raf
5#Raf__ERK
];

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

# the function which update node values at each iterations, for shorter
# computation time, comment or delete the first four lines and replace
# <edge name> by edge(<i>,k)
function y=f_node(edge,k)
    global edge_label
    for i_edge=1:numel(edge_label)
        eval(strcat(edge_label{i_edge},"=edge(",num2str(i_edge),",k);"))
    endfor
    y=[
    0;#EGF
    0;#HRG
    OR(EGF__EGFR,HRG__EGFR);#EGFR
    AND(EGFR__PI3K,NOT(ERK__PI3K));#PI3K
    PI3K__AKT;#AKT
    OR(EGFR__Raf,AKT__Raf);#Raf
    Raf__ERK#ERK
    ];
endfunction

[edge,node]=go("f_edge","f_node",node0,k_end,p,q,r,plot_label);

