#!/bin/sh
# processes labor data

ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add cpseea1 'LaborStats/suppl/EMPSIT.CPSEEA1.TXT' --overwrite --dateregex=none --preprocess='aq_pp -f,+20,eok,qui - -d s,trm:year sep:"...................." x:placeholder sep:"    " s,trm:population sep:"      " s,trm:laborforce sep:"       " s,trm:lfpercent sep:"        " s,trm:employed sep:"       " s,trm:emppercent sep:"         " s,trm:unemployed sep:"        " s,trm:unemppercent sep:"        " s,trm:notlf'
ess summary cpseea1
ess cat 'LaborStats/suppl/EMPSIT.CPSEEA1.TXT' | head -20
ess stream cpseea1 '*' '*' > cpseea1.csv
