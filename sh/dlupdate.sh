#!/bin/sh
# processes airline data

ess server reset
ess create database airline --ports=1
ess create vector vector1 s,pkey:year i,+add:numflights f,+add:totaldelay f,+add:numdelay15
ess server commit

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add airlineontime 'USTransportation/aviation/airline_ontime/new/*.zip' --archive='*.csv' --dateregex='[:%Y:]' --overwrite
ess summary airlineontime
ess stream airlineontime --threads 3 --progress '2009-01-01' '2015-01-01' "aq_pp -f,+1,eok,qui,csv - -d i:yearint s@6:date s@7:carrier i@8:airlineid f@33:delay f@34:delay15 -filt \"airlineid==19790\" -eval s:year \"ToS(yearint)\" -eval i:numflights \"1\" -eval f:totaldelay \"delay\" -eval f:numdelay15 \"delay15\" -udb_imp airline:vector1" 
aq_udb -exp airline:vector1 > dlupdate.csv
