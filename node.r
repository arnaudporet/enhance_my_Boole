# Copyright 2014-2019 Arnaud Poret
# This work is licensed under the BSD 2-Clause License.
# To view a copy of this license, visit https://opensource.org/licenses/BSD-2-Clause

# number of nodes
nnode<-7

# vector declarations
# see below for their meaning
nodelab<-vector(mode="character",length=nnode)
node0<-vector(mode="numeric",length=nnode)

# node names
# only relevant if node states are plotted
nodelab[1]<-"EGF"
nodelab[2]<-"HRG"
nodelab[3]<-"EGFR"
nodelab[4]<-"Raf"
nodelab[5]<-"ERK"
nodelab[6]<-"PI3K"
nodelab[7]<-"AKT"

# node initial states
# here randomly selected between 0 and 0.1 as example
node0[1]<-runif(1,0,0.1)# EGF
node0[2]<-runif(1,0,0.1)# HRG
node0[3]<-runif(1,0,0.1)# EGFR
node0[4]<-runif(1,0,0.1)# Raf
node0[5]<-runif(1,0,0.1)# ERK
node0[6]<-runif(1,0,0.1)# PI3K
node0[7]<-runif(1,0,0.1)# AKT

# node updating function
# for all nodes and at each iteration of the simulation: the function which calculates their updated states
# EGF and HRG are the two inputs of this example
# as such, they are set manually:
#     EGF is activated from 20% to 60% of the simulation, otherwise it is inactive (i.e. equals to its initial state)
#     HRG is not active (i.e. equals to its initial state)
fnode<-function(edge,k,nnode) {
    y<-vector(mode="numeric",length=nnode)
    if(0.2*kend<=k && k<=0.6*kend) {
        y[1]<-1# EGF
    } else {
        y[1]<-node0[1]# EGF
    }
    y[2]<-node0[2]# HRG
    y[3]<-or(edge[1,k],edge[2,k])# EGFR
    y[4]<-or(edge[3,k],edge[4,k])# Raf
    y[5]<-edge[5,k]# ERK
    y[6]<-and(edge[6,k],not(edge[7,k]))# PI3K
    y[7]<-edge[8,k]# AKT
    return(y)
}
