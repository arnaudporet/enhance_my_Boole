EGF;#EGF
NGF;#NGF
AND(EGF,NOT(EGFR));#EGFR
NGF;#TrkA
OR(EGFR,TrkA);#Shc
OR(EGFR,TrkA);#FRS2
OR(EGFR,TrkA);#Dok
Shc;#Grb2
FRS2;#Crk
Dok;#RasGAP
AND(Grb2,NOT(ERK));#SOS
Crk;#C3G
AND(SOS,NOT(RasGAP));#Ras
AND(C3G,NOT(Rap1GAP));#Rap1
Rap1GAP;#Rap1GAP
Ras;#cRaf
OR(Rap1,Ras);#BRaf
AND(OR(cRaf,BRaf),NOT(PP2A));#MEK
PP2A;#PP2A
AND(MEK,NOT(MKP3));#ERK
MKP3;#MKP3
