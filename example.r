#### HOWTO #####################################################################
# 1) read my article (all is explained inside), freely available on:
#     * arXiv: https://arxiv.org/abs/1407.1135
#     * HAL: https://hal.archives-ouvertes.fr/hal-01018236
# 2) in addition to the present file (example.r), open the following files:
#     * edge.r (contains the code relative to the edges of the modelled network)
#     * node.r (contains the code relative to the nodes of the modelled network)
# 3) read the comments of these files
# 4) replace the contents of these files with your own stuff
# 5) launch R
# 6) run (tested with R version 3.2.4 under Arch Linux):
#     * source("example.r")
# This example is a tiny sample of the epidermal growth factor receptor signaling pathway taken from [1].
################################################################################
# close pre-existing plots
for(i in dev.list()) {
    dev.off(i)
}
# remove pre-existing variables
rm(list=ls())
# load the requiered files
source("edge.r")# code relative to the edges
source("node.r")# code relative to the nodes
source("lib.r")# required functions to perform the job
# the number of iterations to perform for the simulation
kend<-100
# automatically plots all the nodes (1: yes, 0: no)
plotall<-1
# if plot all, the number of plots per column in the produced graphic
plotpercol<-3
# then do the job
node<-dothejob(fedge,fnode,node0,kend,r,w,plotall,plotpercol,nodelab)
# [1] Melody K Morris, Julio Saez-Rodriguez, Peter K Sorger, Douglas A Lauffenburger (2010) Logic-based models for the analysis of cell signaling networks. Biochemistry, 49(15):3216-3224.
