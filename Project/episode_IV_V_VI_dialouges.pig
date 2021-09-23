inputDialouges = Load 'hdfs:///user/root/inputs/' USING PigStorage('\t') AS (name: chararray, line: chararray);
ranked = RANK inputDialouges;
OnlyDialouges = FILTER ranked BY (rank_inputDialouges > 2);
groupByName = GROUP OnlyDialouges BY name;
names = FOREACH groupByName GENERATE $0 AS name, COUNT($1) AS no_of_lines;
nameOrdered = ORDER names BY no_of_lines DESC;
STORE nameOrdered INTO 'hdfs:///user/root/inputs/IV_V_VI_dialogues_classification' USING PigStorage ('\t');