edge_label={"mitogenic_stimulation__mitogenic_stimulation","mitogenic_stimulation__AP1","E2F1__AP1","pRb__AP1","AP1__CycD","E2F1__CycD","CycD__CycD","pRb__CycD","E2F1__pRb","pRb__pRb","CycD__pRb","CycE__pRb","E2F1__E2F1","pRb__E2F1","E2F1__CycE","CycE__CycE","pRb__CycE"};

node_label={"mitogenic_stimulation","AP1","CycD","pRb","E2F1","CycE"};

;#mitogenic_stimulation__mitogenic_stimulation
;#mitogenic_stimulation__AP1
;#E2F1__AP1
;#pRb__AP1
;#AP1__CycD
;#E2F1__CycD
;#CycD__CycD
;#pRb__CycD
;#E2F1__pRb
;#pRb__pRb
;#CycD__pRb
;#CycE__pRb
;#E2F1__E2F1
;#pRb__E2F1
;#E2F1__CycE
;#CycE__CycE
;#pRb__CycE

;#mitogenic_stimulation
;#AP1
;#CycD
;#pRb
;#E2F1
;#CycE

node(1,k);#mitogenic_stimulation__mitogenic_stimulation
node(1,k);#mitogenic_stimulation__AP1
node(5,k);#E2F1__AP1
node(4,k);#pRb__AP1
node(2,k);#AP1__CycD
node(5,k);#E2F1__CycD
node(3,k);#CycD__CycD
node(4,k);#pRb__CycD
node(5,k);#E2F1__pRb
node(4,k);#pRb__pRb
node(3,k);#CycD__pRb
node(6,k);#CycE__pRb
node(5,k);#E2F1__E2F1
node(4,k);#pRb__E2F1
node(5,k);#E2F1__CycE
node(6,k);#CycE__CycE
node(4,k);#pRb__CycE

edge(1,k);#mitogenic_stimulation
AND(OR(edge(2,k),edge(3,k)),NOT(edge(4,k)));#AP1
AND(OR(edge(5,k),edge(6,k),edge(7,k)),NOT(edge(8,k)));#CycD
AND(edge(9,k),NOT(OR(edge(10,k),edge(11,k),edge(12,k))));#pRb
AND(edge(13,k),NOT(edge(14,k)));#E2F1
AND(OR(edge(15,k),edge(16,k)),NOT(edge(17,k)));#CycE