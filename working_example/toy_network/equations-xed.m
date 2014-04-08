edge_label={"EGF__EGF","HRG__HRG","EGF__EGFR","HRG__EGFR","EGFR__Raf","AKT__Raf","Raf__ERK","EGFR__PI3K","ERK__PI3K","PI3K__AKT"};

node_label={"EGF","HRG","EGFR","Raf","ERK","PI3K","AKT"};

;#EGF__EGF
;#HRG__HRG
;#EGF__EGFR
;#HRG__EGFR
;#EGFR__Raf
;#AKT__Raf
;#Raf__ERK
;#EGFR__PI3K
;#ERK__PI3K
;#PI3K__AKT

;#EGF
;#HRG
;#EGFR
;#Raf
;#ERK
;#PI3K
;#AKT

node(1,k);#EGF__EGF
node(2,k);#HRG__HRG
node(1,k);#EGF__EGFR
node(2,k);#HRG__EGFR
node(3,k);#EGFR__Raf
node(7,k);#AKT__Raf
node(4,k);#Raf__ERK
node(3,k);#EGFR__PI3K
node(5,k);#ERK__PI3K
node(6,k);#PI3K__AKT

edge(1,k);#EGF
edge(2,k);#HRG
OR(edge(3,k),edge(4,k));#EGFR
OR(edge(5,k),edge(6,k));#Raf
edge(7,k);#ERK
AND(edge(8,k),NOT(edge(9,k)));#PI3K
edge(10,k);#AKT