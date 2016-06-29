#!/bin/bash
# extracts desired fields from ACS data

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add pums "USCensus/PUMS_American_Community_Survey/*2006*.zip" --archive='*.csv' --delimiter=',' --dateregex='[:%Y:]' --overwrite
ess summary pums
ess stream pums '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d i@5:state i@7:weight i@8:age i@9:cit_status i@27:mar -filt "state==6" -o - -c weight age cit_status mar' > pums.csv
