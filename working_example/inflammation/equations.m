AND(infection,NOT(pro));#infection
infection;#sensor
AND(sensor,NOT(anti));#pro
AND(pro,NOT(sensor));#anti
