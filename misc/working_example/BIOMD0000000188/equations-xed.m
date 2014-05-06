edge_label={"DNA_damage__DNA_damage","oncogene_activation__oncogene_activation","DNA_damage__ATM","oncogene_activation__p14ARF","p14ARF__MDM2","p53__MDM2","ATM__p53","MDM2__p53","p53__target_genes"};

node_label={"DNA_damage","oncogene_activation","ATM","p14ARF","MDM2","p53","target_genes"};

;#DNA_damage__DNA_damage
;#oncogene_activation__oncogene_activation
;#DNA_damage__ATM
;#oncogene_activation__p14ARF
;#p14ARF__MDM2
;#p53__MDM2
;#ATM__p53
;#MDM2__p53
;#p53__target_genes

;#DNA_damage
;#oncogene_activation
;#ATM
;#p14ARF
;#MDM2
;#p53
;#target_genes

node(1,k);#DNA_damage__DNA_damage
node(2,k);#oncogene_activation__oncogene_activation
node(1,k);#DNA_damage__ATM
node(2,k);#oncogene_activation__p14ARF
node(4,k);#p14ARF__MDM2
node(6,k);#p53__MDM2
node(3,k);#ATM__p53
node(5,k);#MDM2__p53
node(6,k);#p53__target_genes

edge(1,k);#DNA_damage
edge(2,k);#oncogene_activation
edge(3,k);#ATM
edge(4,k);#p14ARF
NOT(OR(edge(5,k),edge(6,k)));#MDM2
OR(edge(7,k),edge(8,k));#p53
edge(9,k);#target_genes