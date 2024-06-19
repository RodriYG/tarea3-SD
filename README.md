# Hola

```sh
docker-compose up -d
```
```sh
docker exec -it tarea3-sd bash
```
```sh
hdfs dfs -mkdir -p /user/hadoop/datos-hive && 
hdfs dfs -mkdir -p /user/hadoop/datos-pig &&
hdfs dfs -put /datos/dataset.csv /user/hadoop/datos-hive/ &&
hdfs dfs -put /datos/dataset.csv /user/hadoop/datos-pig/ &&
hdfs dfs -mkdir -p /user/hadoop/output
```

## Hive

Ejecutar script
```sh
hive
source /scripts/hive/analisis.sql;
```
Ver tablas con los resulados (dentro de hive):
```sh
select * from stats;
```

```sh
select * from frecuencia_branch;
```

```sh
select * from relacion_branch_taken;
```

```sh
select * from proporcion_taken_1;
```


## Pig

Inicializar historyserver:
```sh
cd /usr/local/hadoop/sbin && 
./mr-jobhistory-daemon.sh start historyserver && 
cd /
```

Ejecutar scripts:
```sh
pig scripts/pig/analisis1.pig &&
pig scripts/pig/analisis2.pig &&
pig scripts/pig/analisis3.pig
```

Obener resultados:
```sh
hadoop fs -get /user/hadoop/output/ /output
```

```sh
docker cp tarea3-sd:/output/ ./
```