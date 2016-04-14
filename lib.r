not<-function(x) {
    return(1-x)
}
and<-function(...) {
    x<-c(...)
    y<-x[1]
    for(i in seq(2,length(x))) {
        y<-y*x[i]
    }
    return(y)
}
or<-function(...) {
    x<-c(...)
    y<-x[1]
    for(i in seq(2,length(x))) {
        y<-y+x[i]-y*x[i]
    }
    return(y)
}
dothejob<-function(fedge,fnode,node0,kend,r,w,plotall,plotpercol,nodelab) {
    node<-as.matrix(node0)
    edge<-as.matrix(fedge(node,1))
    for(k in seq(kend-1)) {
        edge<-cbind(edge,(1-r)*edge[,k]+r*w*fedge(node,k))
        node<-cbind(node,fnode(edge,k))
    }
    if(plotall==1) {
        par(mfrow=c(ceiling(nrow(node)/plotpercol),plotpercol),xaxt="n",yaxt="n")
        for(i in seq(nrow(node))) {
            plot(node[i,],type="l",main=nodelab[i],ylim=c(0,1),xlab="",ylab="")
        }
    }
    return(node)
}
