mitogenic_stimulation;#mitogenic_stimulation
AND(OR(mitogenic_stimulation,E2F1),NOT(pRb));#AP1
AND(OR(AP1,E2F1,CycD),NOT(pRb));#CycD
AND(E2F1,NOT(OR(pRb,CycD,CycE)));#pRb
AND(E2F1,NOT(pRb));#E2F1
AND(OR(E2F1,CycE),NOT(pRb));#CycE
