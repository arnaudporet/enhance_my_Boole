# the node names
nodelab<-c("EGF","HRG","EGFR","Raf","ERK","PI3K","AKT")
# the node initial states
# here randomly selected between 0 and 0.1 (why? why not, this is an example)
node0<-c(
    runif(1,0,0.1),# EGF
    runif(1,0,0.1),# HRG
    runif(1,0,0.1),# EGFR
    runif(1,0,0.1),# Raf
    runif(1,0,0.1),# ERK
    runif(1,0,0.1),# PI3K
    runif(1,0,0.1)# AKT
)# runif(length(nodelab),0,0.1) for short
# the function which updates the node states at each iteration of the simulation
# note that the inputs of this example network are:
#     * EGF: set to 1 between 2 and 6 tenth of kend, 0 otherwise (why? why not, this is an example)
#     * HRG: set to 0 (why? why not, this is an example)
fnode<-function(edge,k) {
    return(c(
        as.double((2*kend/10)<k && k<(6*kend/10)),# EGF
        0,# HRG
        or(edge[1,k],edge[2,k]),# EGFR
        or(edge[3,k],edge[4,k]),# Raf
        edge[5,k],# ERK
        and(edge[6,k],not(edge[7,k])),# PI3K
        edge[8,k]# AKT
    ))
}
