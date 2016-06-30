#!/bin/bash
# counts arson incidents in each state using USFA FEMA data
# data source: https://www.fema.gov/media-library/assets/documents/34029

ess server reset
ess create database usfa --ports=1
ess create vector vector1 s,pkey:state i,+add:count
ess server commit

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add usfa "USFA/USFA_Fire_Data/NFIRS_2000_PDR_082704.csv.zip" --archive='arson.csv' --dateregex=none --overwrite
ess stream usfa '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s@1:state -eval i:count "1" -udb_imp usfa:vector1'
aq_udb -exp usfa:vector1 -sort count -dec > usfa.csv
