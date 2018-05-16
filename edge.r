# Copyright 2014-2018 Arnaud Poret
# This work is licensed under the BSD 2-Clause License.
# To view a copy of this license, visit https://opensource.org/licenses/BSD-2-Clause

# number of edges
nedge<-8

# vector declarations
# see below for their meaning
edgelab<-vector(mode="character",length=nedge)
r<-vector(mode="numeric",length=nedge)
w<-vector(mode="numeric",length=nedge)

# edge names
# only relevant if edge states are plotted
# plotting edge states is currently not implemented
edgelab[1]<-"EGF__EGFR"
edgelab[2]<-"HRG__EGFR"
edgelab[3]<-"EGFR__Raf"
edgelab[4]<-"AKT__Raf"
edgelab[5]<-"Raf__ERK"
edgelab[6]<-"EGFR__PI3K"
edgelab[7]<-"ERK__PI3K"
edgelab[8]<-"PI3K__AKT"

# edge reactivity
# for each edge and at each iteration of the simulation: the portion of its state which is updated
# here randomly selected between 0.3 and 0.7 as example
r[1]<-runif(1,0.3,0.7)# EGF__EGFR
r[2]<-runif(1,0.3,0.7)# HRG__EGFR
r[3]<-runif(1,0.3,0.7)# EGFR__Raf
r[4]<-runif(1,0.3,0.7)# AKT__Raf
r[5]<-runif(1,0.3,0.7)# Raf__ERK
r[6]<-runif(1,0.3,0.7)# EGFR__PI3K
r[7]<-runif(1,0.3,0.7)# ERK__PI3K
r[8]<-runif(1,0.3,0.7)# PI3K__AKT

# edge weakening
# for each edge and at each iteration of the simulation: the weakening coefficient applied on the updated portion of its state
# here randomly selected between 0.7 and 1 as example
w[1]<-runif(1,0.7,1)# EGF__EGFR
w[2]<-runif(1,0.7,1)# HRG__EGFR
w[3]<-runif(1,0.7,1)# EGFR__Raf
w[4]<-runif(1,0.7,1)# AKT__Raf
w[5]<-runif(1,0.7,1)# Raf__ERK
w[6]<-runif(1,0.7,1)# EGFR__PI3K
w[7]<-runif(1,0.7,1)# ERK__PI3K
w[8]<-runif(1,0.7,1)# PI3K__AKT

# edge updating function
# for all edges and at each iteration of the simulation: the function which calculates their updated states
fedge<-function(node,k,nedge) {
    y<-vector(mode="numeric",length=nedge)
    y[1]<-node[1,k]# EGF__EGFR
    y[2]<-node[2,k]# HRG__EGFR
    y[3]<-node[3,k]# EGFR__Raf
    y[4]<-node[7,k]# AKT__Raf
    y[5]<-node[4,k]# Raf__ERK
    y[6]<-node[3,k]# EGFR__PI3K
    y[7]<-node[5,k]# ERK__PI3K
    y[8]<-node[6,k]# PI3K__AKT
    return(y)
}
