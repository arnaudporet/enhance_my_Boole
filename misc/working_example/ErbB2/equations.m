x(1,k);#EGF (input)
x(1,k);#ERBB1
x(1,k);#ERBB2
x(1,k);#ERBB3
AND(x(2,k),x(3,k));#ERBB1_2
AND(x(2,k),x(4,k));#ERBB1_3
AND(x(3,k),x(4,k));#ERBB2_3
AND(OR(x(9,k),x(11,k)),NOT(x(7,k)));#IGF1R
OR(x(11,k),x(12,k));#ERalpha
OR(x(11,k),x(12,k),x(9,k));#cMYC
OR(x(2,k),x(5,k),x(6,k),x(7,k),x(8,k));#AKT1
OR(x(2,k),x(5,k),x(6,k),x(7,k),x(8,k));#MEK1
AND(x(17,k),NOT(x(18,k)),NOT(x(19,k)));#CDK2
AND(x(16,k),NOT(x(18,k)),NOT(x(19,k)));#CDK4
x(16,k);#CDK6
AND(x(9,k),x(10,k),OR(x(11,k),x(12,k)));#CycD1 (AKT1 V MEK1 V ER-α V c-MYC)
x(10,k);#CycE1
AND(x(9,k),NOT(x(11,k)),NOT(x(10,k)),NOT(x(14,k)));#p21
AND(x(9,k),NOT(x(14,k)),NOT(x(13,k)),NOT(x(11,k)),NOT(x(10,k)));#p27
OR(AND(x(14,k),x(15,k)),AND(x(14,k),x(15,k),x(13,k)));#pRB (output)
