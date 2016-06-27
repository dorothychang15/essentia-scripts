#!/bin/sh
# processes airline data

ess server reset
ess create database airline --ports=1
ess create vector vector1 s,pkey:year i,+add:numflights f,+add:totaldelay f:avgdelay f,+add:carrierdelay f,+add:weatherdelay f,+add:nasdelay f,+add:securitydelay f,+add:lateaircraftdelay
ess server commit

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add airlineontime 'USTransportation/aviation/airline_ontime/*' --archive='*.csv' --dateregex='[:%Y:]' --overwrite
ess summary airlineontime
ess stream airlineontime --threads 3 --progress '*' '*' "aq_pp -f,+1,eok,qui,csv - -d i:yearint i@3:month i@4:dayofmonth s@6:date s@7:carrier i@8:airlineid f@26:delay f@50:carrierd f@51:weather f@52:nas f@53:security f@54:aircraft -filt \"airlineid==19790\" -filt \"delay>0\" -eval s:year \"ToS(yearint)\" -eval i:numflights \"1\" -eval f:totaldelay \"delay\" -eval f:avgdelay \"totaldelay/numflights\" -eval f:carrierdelay \"carrierd\" -eval f:weatherdelay \"weather\" -eval f:nasdelay \"nas\" -eval f:securitydelay \"security\" -eval f:lateaircraftdelay \"aircraft\" -udb_imp airline:vector1" 
aq_udb -exp airline:vector1 > delaydl.csv
