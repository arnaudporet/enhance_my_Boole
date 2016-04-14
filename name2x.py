eqs=open("equations","rt").read().splitlines()
nlabs=[]
elabs=[]
neqs=[]
eeqs=[]
for i in range(len(eqs)):
    z=eqs[i].partition("=")
    nlabs.append(z[0])
    neqs.append(z[2])
for i in range(len(neqs)):
    for j in range(len(nlabs)):
        for term in [",",")",";"]:
            neqs[i]=neqs[i].replace(nlabs[j]+term,nlabs[j]+"__"+term)
    neqs[i]=neqs[i].replace("__","__"+nlabs[i])
for i in range(len(neqs)):
    if neqs[i]!=";":
        elabs.append(neqs[i])
for i in range(len(elabs)):
    for term in ["not(","and(","or(",")",";"]:
        elabs[i]=elabs[i].replace(term,"")
    elabs[i]=elabs[i].replace(",","\n")
elabs="\n".join(elabs)
elabs=elabs.splitlines()
for i in range(len(elabs)):
    eeqs.append(elabs[i].partition("__")[0]+";")
for i in range(len(eeqs)):
    for j in range(len(nlabs)):
        if nlabs[j]+";"==eeqs[i]:
            eeqs[i]="node["+str(j+1)+",k];"
for i in range(len(neqs)):
    for j in range(len(elabs)):
        for term in [",",")",";"]:
            neqs[i]=neqs[i].replace(elabs[j]+term,"edge["+str(j+1)+",k]"+term)
eqs=[]
for i in range(len(eeqs)-1):
    eqs.append(eeqs[i]+",# "+elabs[i])
eqs.append(eeqs[i+1]+"# "+elabs[i+1])
eqs.append("\nnode equations:")
for i in range(len(neqs)-1):
    eqs.append(neqs[i]+",# "+nlabs[i])
eqs.append(neqs[i+1]+"# "+nlabs[i+1])
eqs="\n".join(eqs)
eqs=eqs.replace(";","")
elabs="\""+"\",\"".join(elabs)+"\""
nlabs="\""+"\",\"".join(nlabs)+"\""
open("equations.xed","w").write("edge names:\n"+elabs+"\n\nnode names:\n"+nlabs+"\n\nedge equations:\n"+eqs+"\n")
