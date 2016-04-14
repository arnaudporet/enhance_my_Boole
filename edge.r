# the edge names
edgelab<-c("EGF__EGFR","HRG__EGFR","EGFR__Raf","AKT__Raf","Raf__ERK","EGFR__PI3K","ERK__PI3K","PI3K__AKT")
# for each edge, the portion of its state which is updated at each iteration of the simulation (edge reactivity)
# here randomly selected between 0.3 and 0.7 (why? why not, this is an example)
r<-c(
    runif(1,0.3,0.7),# EGF__EGFR
    runif(1,0.3,0.7),# HRG__EGFR
    runif(1,0.3,0.7),# EGFR__Raf
    runif(1,0.3,0.7),# AKT__Raf
    runif(1,0.3,0.7),# Raf__ERK
    runif(1,0.3,0.7),# EGFR__PI3K
    runif(1,0.3,0.7),# ERK__PI3K
    runif(1,0.3,0.7)# PI3K__AKT
)# runif(length(edgelab),0.3,0.7) for short
# for each edge, the weakening of its state at each iteration of the simulation (edge weakening)
# here randomly selected between 0.7 and 1 (why? why not, this is an example)
w<-c(
    runif(1,0.7,1),# EGF__EGFR
    runif(1,0.7,1),# HRG__EGFR
    runif(1,0.7,1),# EGFR__Raf
    runif(1,0.7,1),# AKT__Raf
    runif(1,0.7,1),# Raf__ERK
    runif(1,0.7,1),# EGFR__PI3K
    runif(1,0.7,1),# ERK__PI3K
    runif(1,0.7,1)# PI3K__AKT
)# runif(length(edgelab),0.7,1) for short
# the function which updates the edge states at each iteration of the simulation
fedge<-function(node,k) {
    return(c(
        node[1,k],# EGF__EGFR
        node[2,k],# HRG__EGFR
        node[3,k],# EGFR__Raf
        node[7,k],# AKT__Raf
        node[4,k],# Raf__ERK
        node[3,k],# EGFR__PI3K
        node[5,k],# ERK__PI3K
        node[6,k]# PI3K__AKT
    ))
}
