input_file=input("input file: ")
output_file=input("output file: ")

lines=open(input_file,"r").read().splitlines()
node_names=[]
edge_names=[]
node_equations=[]
edge_equations=[]

for i in range(len(lines)):
    node_names.append(lines[i].partition("#")[2])
    node_equations.append(lines[i].partition("#")[0])

for i in range(len(node_equations)):
    for j in range(len(node_names)):
        if node_names[j]+"," in node_equations[i]:
            node_equations[i]=node_equations[i].replace(node_names[j]+",",node_names[j]+"__,")
        if node_names[j]+")" in node_equations[i]:
            node_equations[i]=node_equations[i].replace(node_names[j]+")",node_names[j]+"__)")
        if node_names[j]+";" in node_equations[i]:
            node_equations[i]=node_equations[i].replace(node_names[j]+";",node_names[j]+"__;")
    node_equations[i]=node_equations[i].replace("__","__"+node_names[i])

for i in range(len(node_equations)):
    if node_equations[i]!=";":
        edge_names.append(node_equations[i])

for i in range(len(edge_names)):
    edge_names[i]=edge_names[i].replace("NOT(","")
    edge_names[i]=edge_names[i].replace("AND(","")
    edge_names[i]=edge_names[i].replace("OR(","")
    edge_names[i]=edge_names[i].replace(")","")
    edge_names[i]=edge_names[i].replace(";","")
    edge_names[i]=edge_names[i].replace(",","\n")
edge_names="\n".join(edge_names).splitlines()

for i in range(len(edge_names)):
    edge_equations.append(edge_names[i].partition("__")[0]+";")

for i in range(len(edge_equations)):
    for j in range(len(node_names)):
        if node_names[j]+";"==edge_equations[i]:
            edge_equations[i]="node("+str(j+1)+",k);"

for i in range(len(node_equations)):
    for j in range(len(edge_names)):
        if edge_names[j]+"," in node_equations[i]:
            node_equations[i]=node_equations[i].replace(edge_names[j]+",","edge("+str(j+1)+",k),")
        if edge_names[j]+")" in node_equations[i]:
            node_equations[i]=node_equations[i].replace(edge_names[j]+")","edge("+str(j+1)+",k))")
        if edge_names[j]+";" in node_equations[i]:
            node_equations[i]=node_equations[i].replace(edge_names[j]+";","edge("+str(j+1)+",k);")

lines=[]
for i in range(len(edge_equations)):
    lines.append(edge_equations[i]+"#"+edge_names[i])
lines.append("")
for i in range(len(node_equations)):
    lines.append(node_equations[i]+"#"+node_names[i])

open(output_file,"w").write("\""+"\",\"".join(edge_names)+"\"\n\n\""+"\",\"".join(node_names)+"\"\n\n;#"+"\n;#".join(edge_names)+"\n\n;#"+"\n;#".join(node_names)+"\n\n"+"\n".join(lines))
