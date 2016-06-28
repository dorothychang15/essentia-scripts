#!/bin/bash
# organizes project tycho data, converts epi_week to year, aggregates death count by year and disease

ess server reset
ess create database tycho --ports=1
ess create vector vector1 s,pkey:yeardisease s:year s:disease i,+add:death_count
ess server commit

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add tycho "HHS/ProjectTycho_Level2_v1.1.0_0.zip" --delimiter=',' --dateregex=none --overwrite
ess stream tycho --threads 3 --progress '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s@1:yrweek s@3:state s@6:disease s@7:event i@8:count -mapf yrweek "%%var%%%?%?" -mapc s:year "%%var%%" -filt "event==\"DEATHS\"" -eval s:yeardisease "year+disease" -eval i:death_count "1" -udb_imp tycho:vector1'
aq_udb -exp tycho:vector1 -sort death_count -dec > tycho.csv
