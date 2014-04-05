edge_label={"EGF__EGF","NGF__NGF","EGF__EGFR","EGFR__EGFR","NGF__TrkA","EGFR__Shc","TrkA__Shc","EGFR__FRS2","TrkA__FRS2","EGFR__Dok","TrkA__Dok","Shc__Grb2","FRS2__Crk","Dok__RasGAP","Grb2__SOS","ERK__SOS","Crk__C3G","SOS__Ras","RasGAP__Ras","C3G__Rap1","Rap1GAP__Rap1","Rap1GAP__Rap1GAP","Ras__cRaf","Rap1__BRaf","Ras__BRaf","cRaf__MEK","BRaf__MEK","PP2A__MEK","PP2A__PP2A","MEK__ERK","MKP3__ERK","MKP3__MKP3"};

node_label={"EGF","NGF","EGFR","TrkA","Shc","FRS2","Dok","Grb2","Crk","RasGAP","SOS","C3G","Ras","Rap1","Rap1GAP","cRaf","BRaf","MEK","PP2A","ERK","MKP3"};

;#EGF__EGF
;#NGF__NGF
;#EGF__EGFR
;#EGFR__EGFR
;#NGF__TrkA
;#EGFR__Shc
;#TrkA__Shc
;#EGFR__FRS2
;#TrkA__FRS2
;#EGFR__Dok
;#TrkA__Dok
;#Shc__Grb2
;#FRS2__Crk
;#Dok__RasGAP
;#Grb2__SOS
;#ERK__SOS
;#Crk__C3G
;#SOS__Ras
;#RasGAP__Ras
;#C3G__Rap1
;#Rap1GAP__Rap1
;#Rap1GAP__Rap1GAP
;#Ras__cRaf
;#Rap1__BRaf
;#Ras__BRaf
;#cRaf__MEK
;#BRaf__MEK
;#PP2A__MEK
;#PP2A__PP2A
;#MEK__ERK
;#MKP3__ERK
;#MKP3__MKP3

;#EGF
;#NGF
;#EGFR
;#TrkA
;#Shc
;#FRS2
;#Dok
;#Grb2
;#Crk
;#RasGAP
;#SOS
;#C3G
;#Ras
;#Rap1
;#Rap1GAP
;#cRaf
;#BRaf
;#MEK
;#PP2A
;#ERK
;#MKP3

node(1,k);#EGF__EGF
node(2,k);#NGF__NGF
node(1,k);#EGF__EGFR
node(3,k);#EGFR__EGFR
node(2,k);#NGF__TrkA
node(3,k);#EGFR__Shc
node(4,k);#TrkA__Shc
node(3,k);#EGFR__FRS2
node(4,k);#TrkA__FRS2
node(3,k);#EGFR__Dok
node(4,k);#TrkA__Dok
node(5,k);#Shc__Grb2
node(6,k);#FRS2__Crk
node(7,k);#Dok__RasGAP
node(8,k);#Grb2__SOS
node(20,k);#ERK__SOS
node(9,k);#Crk__C3G
node(11,k);#SOS__Ras
node(10,k);#RasGAP__Ras
node(12,k);#C3G__Rap1
node(15,k);#Rap1GAP__Rap1
node(15,k);#Rap1GAP__Rap1GAP
node(13,k);#Ras__cRaf
node(14,k);#Rap1__BRaf
node(13,k);#Ras__BRaf
node(16,k);#cRaf__MEK
node(17,k);#BRaf__MEK
node(19,k);#PP2A__MEK
node(19,k);#PP2A__PP2A
node(18,k);#MEK__ERK
node(21,k);#MKP3__ERK
node(21,k);#MKP3__MKP3

edge(1,k);#EGF
edge(2,k);#NGF
AND(edge(3,k),NOT(edge(4,k)));#EGFR
edge(5,k);#TrkA
OR(edge(6,k),edge(7,k));#Shc
OR(edge(8,k),edge(9,k));#FRS2
OR(edge(10,k),edge(11,k));#Dok
edge(12,k);#Grb2
edge(13,k);#Crk
edge(14,k);#RasGAP
AND(edge(15,k),NOT(edge(16,k)));#SOS
edge(17,k);#C3G
AND(edge(18,k),NOT(edge(19,k)));#Ras
AND(edge(20,k),NOT(edge(21,k)));#Rap1
edge(22,k);#Rap1GAP
edge(23,k);#cRaf
OR(edge(24,k),edge(25,k));#BRaf
AND(OR(edge(26,k),edge(27,k)),NOT(edge(28,k)));#MEK
edge(29,k);#PP2A
AND(edge(30,k),NOT(edge(31,k)));#ERK
edge(32,k);#MKP3