#!/bin/bash
# extracts desired fields

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add births "HHS/NCHS/NCHS_-_Births__Birth_Rates__and_Fertility_Rates__by_Race_of_Mother__United_States__1960-2013.csv" --dateregex=none --overwrite
ess stream births '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d i:year s:race s:births' > births.csv
