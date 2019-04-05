# Copyright 2014-2019 Arnaud Poret
# This work is licensed under the BSD 2-Clause License.
# To view a copy of this license, visit https://opensource.org/licenses/BSD-2-Clause

# continuous logical NOT operator
# here the algebraic formulation is used
not<-function(a) {
    return(1-a)
}

# continuous logical AND operator
# here the algebraic formulation is used
# note that it accepts two or more arguments
and<-function(a,b,...) {
    x<-c(a,b,...)
    y<-x[1]
    for(i in seq(2,length(x))) {
        y<-y*x[i]
    }
    return(y)
}

# continuous logical OR operator
# here the algebraic formulation is used
# note that it accepts two or more arguments
or<-function(a,b,...) {
    x<-c(a,b,...)
    y<-x[1]
    for(i in seq(2,length(x))) {
        y<-y+x[i]-y*x[i]
    }
    return(y)
}

# main function: performs the simulation
dothejob<-function(node0,r,w,kend,nedge,nnode,nodelab,plotall,printall) {
    node<-as.matrix(node0)
    edge<-as.matrix(fedge(node,1,nedge))
    for(k in seq(2,kend)) {
        edge<-cbind(edge,as.matrix((1-r)*edge[,k-1]+r*w*fedge(node,k-1,nedge)))
        node<-cbind(node,as.matrix(fnode(edge,k-1,nnode)))
    }
    if(plotall) {
        for(i in seq(ceiling(nnode/9))) {
            dev.new()
            par(mfrow=c(3,3))
        }
        for(i in seq(nnode)) {
            nplot<-ceiling(i/9)
            dev.set(nplot+1)
            plot(node[i,],type="l",main=nodelab[i],ylim=c(0,1),xlab="",ylab="")
            if(printall) {
                dev.print(device=svg,filename=paste("plot",as.character(nplot),".svg",sep=""))
            }
        }
    }
    return(node)
}
