#!/bin/bash
# organizes state tax collection data
# These data were obtained from Bureau of Labor Statistics

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add state_taxes "USCensus/US_Census_Bureau_State_Tax_Collections/STC_2014_STC006.US01.zip" --noprobe --dateregex='[:%Y:]' --overwrite 
ess stream state_taxes '*' '*' 'aq_pp -f,+1,eok,qui,csv - -d s@7:state i@8:total i@9:property i@10:sales i@11:license i@12:income i@13:other' > state_taxes.csv
