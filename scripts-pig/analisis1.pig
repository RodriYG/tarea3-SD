-- Carga los datos
datos = LOAD '/user/hadoop/datos-pig/dataset.csv' USING PigStorage(',') AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Cuenta las filas
cantidad = FOREACH (GROUP datos ALL) GENERATE COUNT(datos);

-- Guarda el resultado en un archivo de salida
STORE cantidad INTO '/user/hadoop/output/cantidad' USING PigStorage();

-- Agrupa los datos por branch_type
datos_agrupados = GROUP datos BY branch_type;

-- Cuenta las filas en cada grupo
frecuencia = FOREACH datos_agrupados GENERATE group AS branch_type, COUNT(datos) AS count;

-- Guarda el resultado en un archivo de salida
STORE frecuencia INTO '/user/hadoop/output/frecuencia' USING PigStorage();