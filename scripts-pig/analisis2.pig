-- Carga los datos
datos = LOAD '/user/hadoop/datos-pig/dataset.csv' USING PigStorage(',') AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Agrupa los datos por branch_type y taken
datos_agrupados = GROUP datos BY (branch_type, taken);

-- Cuenta las filas en cada grupo
conteo = FOREACH datos_agrupados GENERATE group AS branch_taken, COUNT(datos) AS count;

-- Divide el conteo de filas con "taken" igual a 1 por el conteo total de filas para cada branch_type
datos_agrupados_por_tipo = GROUP conteo BY branch_taken.branch_type;
proporcion = FOREACH datos_agrupados_por_tipo {
    taken_1 = FILTER conteo BY branch_taken.taken == 1;
    GENERATE group AS branch_type, (double)SUM(taken_1.count) / (double)SUM(conteo.count) AS proportion;
}

-- Guarda el resultado en un archivo de salida
STORE proporcion INTO '/user/hadoop/output/proporcion' USING PigStorage();