"EGF__EGFR","HRG__EGFR","EGFR__PI3K","ERK__PI3K","PI3K__AKT","EGFR__Raf","AKT__Raf","Raf__ERK"

"EGF","HRG","EGFR","PI3K","AKT","Raf","ERK"

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

node(1,k);#EGF__EGFR
node(2,k);#HRG__EGFR
node(3,k);#EGFR__PI3K
node(7,k);#ERK__PI3K
node(4,k);#PI3K__AKT
node(3,k);#EGFR__Raf
node(5,k);#AKT__Raf
node(6,k);#Raf__ERK

;#EGF
;#HRG
OR(edge(1,k),edge(2,k));#EGFR
AND(edge(3,k),NOT(edge(4,k)));#PI3K
edge(5,k);#AKT
OR(edge(6,k),edge(7,k));#Raf
edge(8,k);#ERK