"EGF__EGF","HRG__HRG","EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"

"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"

;#EGF__EGF
;#HRG__HRG
;#EGF__EGFR
;#HRG__EGFR
;#EGFR__PI3K
;#ERK__PI3K
;#PI3K__AKT
;#EGFR__Raf
;#AKT__Raf
;#Raf__ERK

;#EGF
;#HRG
;#EGFR
;#PI3K
;#AKT
;#Raf
;#ERK

node(1,k);#EGF__EGF
node(2,k);#HRG__HRG
node(1,k);#EGF__EGFR
node(2,k);#HRG__EGFR
node(3,k);#EGFR__PI3K
node(7,k);#ERK__PI3K
node(4,k);#PI3K__AKT
node(3,k);#EGFR__Raf
node(5,k);#AKT__Raf
node(6,k);#Raf__ERK

edge(1,k);#EGF
edge(2,k);#HRG
OR(edge(3,k),edge(4,k));#EGFR
AND(edge(5,k),NOT(edge(6,k)));#PI3K
edge(7,k);#AKT
OR(edge(8,k),edge(9,k));#Raf
edge(10,k);#ERK