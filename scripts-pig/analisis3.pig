-- Carga los datos
datos = LOAD '/user/hadoop/datos-pig/dataset.csv' USING PigStorage(',') AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Agrupa los datos por branch_type y taken
datos_agrupados = GROUP datos BY (branch_type, taken);

-- Cuenta las filas en cada grupo
relacion = FOREACH datos_agrupados GENERATE group AS branch_taken, COUNT(datos) AS count;

-- Guarda el resultado en un archivo de salida
STORE relacion INTO '/user/hadoop/output/relacion' USING PigStorage();