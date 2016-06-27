#!/bin/bash
# organizes gasoline price data
# These data were obtained from Bureau of Labor Statistics

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add gas "LaborStats/CPI_Gasoline_Fuels/ap.data.2.Gasoline" --noprobe --dateregex=none --overwrite 
echo "Data source: Bureau of Labor Statistics" > gas.csv
ess stream gas '*' '*' 'aq_pp -f,+1,eok,qui - -d s:seriesid sep:"     	" i:year sep:"	" s:period sep:"	       " f,trm:value -filt "seriesid==\"APU010074715\"" -map period "M%%var%%" "%%var%%" -eval s:date "ToS(year)+\"-\"+period" -o,notitle,noq - -c date value' >> gas.csv 
