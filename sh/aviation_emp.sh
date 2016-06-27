#!/bin/bash
# accesses aviation employee data, finds top 10 carriers with most employees on average

ess server reset
ess create database aviation --ports=1
ess create vector vector1 s,pkey:carrier_name i,+add:sum i,+add:count i:avg
ess server commit
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add aviation_emp 'USTransportation/aviation/air_carrier_employees/"P10 - Annual Employee Statistics by Labor Category"/*.csv' --dateregex=Y  --preprocess='aq_pp -f,csv,+1,eok,qui - -d s,trm:carrier_code s,trm:carrier_name s,trm:entity i:general_manager i:pilots i:other i:gen_admin i:maintenance i:aircraft_traffic i:gen_aircraft_traffic i:aircraft_control i:passenger i:cargo i:trainees i:stat i:traffic_solicit x: i:transport i:total -filt "total > 0" -eval i:sum "total" -eval i:count "1" -eval i:avg "sum/count" -udb_imp aviation:vector1' --overwrite
ess summary aviation_emp
aq_udb -exp aviation:vector1 -sort avg -dec -top 10 > aviation_top10.csv
