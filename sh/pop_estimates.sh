#!/bin/bash
# cleans population estimate data, extracts desired fields and sorts by 2015 population

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add pop 'USCensus/UC_Census_Bureau_Population_Estimates/NST-EST2015-alldata.csv' --delimiter=',' --dateregex=none --preprocess='aq_pp -f,+1,eok,qui,csv - -d s@5:name I@8:pop2010 I@9:pop2011 I@10:pop2012 I@11:pop2013 I@12:pop2014 I@13:pop2015' --overwrite  
ess summary pop
ess query 'select * from pop:*:* order by pop2015 desc' > pop_estimates.csv
