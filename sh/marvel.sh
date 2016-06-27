#!/bin/bash
# marvel data set has been downloaded as snapshot, converted to volume and attached to instance
# uses udb to find 25 marvel characters with most frequent appearances in marvel universe social graph

echo "marvel social universe with udb"
echo "reset server"
ess server reset
echo "create marvel database"
ess create database marvel --ports=1
echo "create vector"
ess create vector vector1 s,pkey:character_name i,+add:appearance_count
ess server commit

echo "ess select local"
ess select local
echo "create category"
ess category add marvel "/data/labeled_edges.tsv" --dateregex=none  --overwrite
echo "evaluate appearance counts"
ess stream marvel '*' '*' "aq_pp -f,qui,eok,tsv - -d S,TRM:character_name X: -eval I:appearance_count \"1\" -udb_imp marvel:vector1" 
echo "stream first 10 lines"
ess stream marvel '*' '*' 'head -10' --debug
echo "select 25 characters who appear most frequently, write to marvel_top25.csv"
aq_udb -exp marvel:vector1 -sort appearance_count -dec -top 25 > marvel_top25.csv

