#!/bin/bash
# extracts date and sunspot estimate from SILS data
# data source: WDC-SILSO, Royal Observatory of Belgium, Brussels

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add sils "SILS/EISN_current.csv" --delimiter=',' --dateregex=none
ess stream sils '*' '*' 'aq_pp -f,eok,qui,csv - -d i@1:year i@2:month i@3:day i@5:count -eval s:date "ToS(month)+\"-\"+ToS(day)+\"-\"+ToS(year)" -o,noq - -c date count' > sils.csv
