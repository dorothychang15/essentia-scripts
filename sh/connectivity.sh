#!/bin/bash
# accesses passenger connectivity data, measures connectivity by state

ess server reset
ess create database connectivity --ports=1
ess create vector vector1 s,pkey:state i,+add:total
ess server commit
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add connectivity 'USTransportation/highway/"Passenger Connectivity"/417924414_T_TRANSNET_FACILITY.zip' --dateregex=none --preprocess='aq_pp -f,csv,+1,eok,qui - -d x: s:airport_code x: x: x: x: x: x: s:state x: x: s:facility_name x: x: x: i:ft i:fi i:bt i:bi i:bcs i:bs i:ri i:rc i:rh i:rl i:as -eval i:total "ft+fi+bt+bi+bcs+bs+ri+rc+rh+rl+as" -udb_imp connectivity:vector1' --overwrite
ess summary connectivity
aq_udb -exp connectivity:vector1 -sort total -dec > connectivity.csv
