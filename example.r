# Copyright 2014-2018 Arnaud Poret
# This work is licensed under the 2-Clause BSD License.
# To view a copy of this license, visit https://opensource.org/licenses/BSD-2-Clause

#### HOWTO #####################################################################

# 1) read my article, freely available at https://arxiv.org/abs/1407.1135
# 2) in addition to the present file (example.r), open the following ones:
#     * edge.r (contains code related to edges)
#     * node.r (contains code related to nodes)
# 3) read these files (edge.r, node.r and example.r)
# 4) replace their content with your own stuff
# 5) launch R
# 6) run (tested with R version 3.5.0 under Arch Linux):
#     source("example.r")

# This example is a tiny sample of the epidermal growth factor receptor signaling pathway taken from [1].

# [1] Melody K Morris, Julio Saez-Rodriguez, Peter K Sorger, Douglas A Lauffenburger (2010) Logic-based models for the analysis of cell signaling networks. Biochemistry, 49(15):3216-3224.

################################################################################

# close pre-existing plots
for(i in dev.list()) {
    dev.off(i)
}

# delete pre-existing variables
rm(list=ls())

# number of iterations to perform during a simulation
kend<-100

# if all the nodes should be automatically plotted
plotall<-TRUE

# if all the plots should be automatically saved
# only relevant if plotall<-TRUE
# here the SVG file format is used
printall<-FALSE

# read edge data required for the simulation
# see the corresponding file for details
source("edge.r")

# read node data required for the simulation
# see the corresponding file for details
source("node.r")

# read other data required for the simulation
# see the corresponding file for details
source("lib.r")

# execute the simulation and return node states
node<-dothejob(node0,r,w,kend,nedge,nnode,nodelab,plotall,printall)
