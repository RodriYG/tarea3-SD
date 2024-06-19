CREATE TABLE dataset (
    branch_addr STRING,
    branch_type STRING,
    taken INT,
    target STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

-- Cargar del dataset
LOAD DATA INPATH '/user/hadoop/datos/dataset.csv' INTO TABLE dataset;

-- Estadisticas basicas (número total de registros del dataset)
CREATE TABLE stats AS
SELECT COUNT(*) FROM dataset;

-- Frecuenciua de cada tipo de branch
CREATE TABLE frecuencia_branch AS
SELECT branch_type, COUNT(*) as frecuencia
From dataset 
GROUP BY branch_type;

-- Relación entre el tipo de branch y el valor de taken
CREATE TABLE relacion_branch_taken AS
SELECT branch_type, taken, COUNT(*)
FROM dataset
GROUP BY branch_type, taken;

-- Proporción de registros con taken = 1 para cada tipo de branch
CREATE TABLE proporcion_taken_1 AS
SELECT branch_type, 
       SUM(CASE WHEN taken = 1 THEN 1 END) / COUNT(*)
FROM dataset
GROUP BY branch_type;